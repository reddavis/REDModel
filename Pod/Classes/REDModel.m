//
//  REDModel.m
//  Example
//
//  Created by Red Davis on 19/02/2015.
//  Copyright (c) 2015 Red Davis. All rights reserved.
//

#import "REDModel.h"
#import "REDProperty.h"

#import <objc/objc-runtime.h>
#import <UIKit/UIKit.h>


static inline NSUserDefaults *red_userDefaults();
static inline NSString *userDefaultsKeyForProperty(NSString *propertyName, Class class, NSString *identifier);

#pragma mark - User Defaults

static inline NSUserDefaults *red_userDefaults()
{
    return [NSUserDefaults standardUserDefaults];
}

static inline NSString *userDefaultsKeyForProperty(NSString *propertyName, Class class, NSString *identifier)
{
    NSString *userDefaultsKey = nil;
    if (identifier)
    {
        userDefaultsKey = [NSString stringWithFormat:@"com.redmodel.%@-%@-%@", identifier, NSStringFromClass(class), propertyName];
    }
    else
    {
        userDefaultsKey = [NSString stringWithFormat:@"com.redmodel.%@-%@", NSStringFromClass(class), propertyName];
    }
    
    return userDefaultsKey;
}


@interface REDModel ()

@property (copy, nonatomic) NSString *REDModelIdentifier;

@end


@implementation REDModel

+ (void)load
{
    int numberOfClasses = objc_getClassList(NULL, 0);
    Class *classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numberOfClasses);
    numberOfClasses = objc_getClassList(classes, numberOfClasses);
    
    for (int index = 0; index < numberOfClasses; index++)
    {
        Class class = classes[index];
        
        if (class_getClassMethod(class, @selector(conformsToProtocol:)) && class_conformsToProtocol(class, @protocol(REDModel)))
        {
            unsigned int numberOfProperties;
            objc_property_t *propertyList = class_copyPropertyList(class, &numberOfProperties);
            
            for (int propertyIndex = 0; propertyIndex < numberOfProperties; propertyIndex++)
            {
                REDProperty *property = [[REDProperty alloc] initWithProperty:propertyList[propertyIndex]];
                if (property.isDynamic)
                {
                    // Setter
                    IMP setterIMP = nil;
                    const char *setterTypes = nil;
                    if (property.isPrimitive)
                    {
                        setterIMP = imp_implementationWithBlock(^(id self, NSInteger object) {
                            [NSException raise:@"Primitive types arent suppored, user NSNumber instead" format:nil];
                        });
                        
                        setterTypes = [[NSString stringWithFormat: @"%s%s", @encode(id), @encode(NSInteger)] UTF8String];
                    }
                    else
                    {
                        setterIMP = imp_implementationWithBlock(^(id self, id object) {
                            NSString *identifier = [self respondsToSelector:@selector(REDModelIdentifier)] ? [self REDModelIdentifier] : nil;
                            NSString *userDefaultsKey = userDefaultsKeyForProperty(property.name, class, identifier);
                            
                            [red_userDefaults() setObject:object forKey:userDefaultsKey];
                            [red_userDefaults() synchronize];
                        });
                        
                        setterTypes = [[NSString stringWithFormat: @"%s%s", @encode(id), @encode(id)] UTF8String];
                    }

                    class_addMethod(class, property.setterSelector, setterIMP, setterTypes);
                    
                    // Getter
                    IMP getterIMP = nil;
                    const char *getterTypes = nil;
                    if (property.isPrimitive)
                    {
                        getterIMP = imp_implementationWithBlock(^(id self) {
                            [NSException raise:@"Primitive types arent suppored, user NSNumber instead" format:nil];
                        });
                        
                        getterTypes = [[NSString stringWithFormat: @"%s", @encode(NSInteger)] UTF8String];
                    }
                    else
                    {
                        getterIMP = imp_implementationWithBlock(^(id self) {
                            NSString *identifier = [self respondsToSelector:@selector(REDModelIdentifier)] ? [self REDModelIdentifier] : nil;
                            NSString *userDefaultsKey = userDefaultsKeyForProperty(property.name, class, identifier);
                            
                            NSLog(@"getter %@ -- %@ %@ %@", userDefaultsKey, property.name, NSStringFromClass(class), identifier);
                            
                            return [red_userDefaults() objectForKey:userDefaultsKey];
                        });
                        
                        getterTypes = [[NSString stringWithFormat: @"%s", @encode(id)] UTF8String];
                    }
                    
                    class_addMethod(class, property.getterSelector, getterIMP, getterTypes);
                }
            }
            
            free(propertyList);
        }
    }
    
    free(classes);
}

@end
