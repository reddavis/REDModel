//
//  REDProperty.m
//  Example
//
//  Created by Red Davis on 05/03/2015.
//  Copyright (c) 2015 Red Davis. All rights reserved.
//

#import "REDProperty.h"


@interface REDProperty ()

@property (assign, nonatomic) BOOL isDynamic;

@property (assign, nonatomic) objc_property_t property;

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) Class propertyClass;

@property (assign, nonatomic) SEL getterSelector;
@property (assign, nonatomic) SEL setterSelector;

- (void)processAttributes;

@end


@implementation REDProperty

#pragma mark - Initialization

- (instancetype)initWithProperty:(objc_property_t)property
{
    self = [self init];
    if (self)
    {
        self.property = property;
        [self processAttributes];
    }
    
    return self;
}

#pragma mark -

- (void)processAttributes
{
    unsigned int numberOfAttributes;
    objc_property_attribute_t *attributeList = property_copyAttributeList(self.property, &numberOfAttributes);
    
    for (int attributeIndex = 0; attributeIndex < numberOfAttributes; attributeIndex++)
    {
        objc_property_attribute_t attribute = attributeList[attributeIndex];
        
        if (attribute.name[0] == 'D')
        {
            self.isDynamic = YES;
        }
        
        // Name
        self.name = [NSString stringWithCString:property_getName(self.property) encoding:NSUTF8StringEncoding];
        
        // Property class
        const char *propertyAttributes = property_getAttributes(self.property);
        NSString *propertyAttributesString = [NSString stringWithCString:propertyAttributes encoding:NSUTF8StringEncoding];
        
        NSString *propertyClassName = nil;
        NSScanner *propertyClassScanner = [NSScanner scannerWithString:propertyAttributesString];
        [propertyClassScanner scanUpToString:@"\"" intoString:nil];
        [propertyClassScanner scanString:@"\"" intoString:nil];
        [propertyClassScanner scanUpToString:@"\"" intoString:&propertyClassName];
        
        self.propertyClass = NSClassFromString(propertyClassName);
                
        // Setter selector
        NSString *formattedPropertyName = [self.name copy];
        if (formattedPropertyName.length > 1)
        {
            formattedPropertyName = [NSString stringWithFormat:@"%@%@", [formattedPropertyName substringToIndex:1].capitalizedString, [formattedPropertyName substringFromIndex:1]];
        }
        else
        {
            formattedPropertyName = formattedPropertyName.capitalizedString;
        }
        
        NSString *setterSelectorName = [NSString stringWithFormat:@"set%@:", formattedPropertyName];
        self.setterSelector = NSSelectorFromString(setterSelectorName);
        
        // Getter selector
        self.getterSelector = NSSelectorFromString(self.name);
    }
    
    free(attributeList);
}

#pragma mark -

- (BOOL)isPrimitive
{
    return !self.propertyClass;
}

@end
