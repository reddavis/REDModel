//
//  TestModel.m
//  REDModelTests
//
//  Created by Red Davis on 11/03/2015.
//  Copyright (c) 2015 Red Davis. All rights reserved.
//

#import "TestModel.h"


@implementation TestModel

@dynamic string, date, number;

- (NSString *)modelIdentifier
{
    return @"testModel";
}

@end
