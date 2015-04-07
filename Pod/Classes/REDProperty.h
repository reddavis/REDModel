//
//  REDProperty.h
//  Example
//
//  Created by Red Davis on 05/03/2015.
//  Copyright (c) 2015 Red Davis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface REDProperty : NSObject

@property (copy, nonatomic, readonly) NSString *name;

@property (assign, nonatomic, readonly) BOOL isDynamic;
@property (assign, nonatomic, readonly) BOOL isPrimitive;

@property (assign, nonatomic, readonly) Class propertyClass;
@property (assign, nonatomic, readonly) SEL getterSelector;
@property (assign, nonatomic, readonly) SEL setterSelector;

- (instancetype)initWithProperty:(objc_property_t)property;

@end
