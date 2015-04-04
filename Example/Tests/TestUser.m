//
//  TestUser.m
//  REDModelTests
//
//  Created by Red Davis on 22/03/2015.
//  Copyright (c) 2015 Red Davis. All rights reserved.
//

#import "TestUser.h"


@interface TestUser ()
@property (copy, nonatomic) NSString *modelIdentifier;
@end


@implementation TestUser

@dynamic name;

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [self init];
    if (self)
    {
        self.modelIdentifier = identifier;
    }
    
    return self;
}

@end
