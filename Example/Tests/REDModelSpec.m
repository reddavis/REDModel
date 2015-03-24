//
//  REDModelSpec.m
//  REDModelTests
//
//  Created by Red Davis on 11/03/2015.
//  Copyright (c) 2015 Red Davis. All rights reserved.
//

#import <Kiwi/Kiwi.h>

#import "TestModel.h"
#import "TestUser.h"


SPEC_BEGIN(REDModelSpec)

describe(@"REDModel", ^{
    let(model, ^TestModel *{
        return [[TestModel alloc] init];
    });
    
    specify(^{
        [[model shouldNot] beNil];
    });
    
    context(@"NSString", ^{
        it(@"should save", ^{
            NSString *string = @"string";
            
            model.string = string;
            [[model.string should] equal:string];
        });
    });
    
    context(@"NSDate", ^{
        it(@"should save", ^{
            NSDate *date = [NSDate date];
            
            model.date = date;
            [[model.date should] equal:date];
        });
    });
    
    context(@"NSNumber", ^{
        it(@"should save", ^{
            NSNumber *number = @(5);
            
            model.number = number;
            [[model.number should] equal:number];
        });
    });
    
    context(@"Identifiable models", ^{
        let(userOne, ^TestUser *{
            return [[TestUser alloc] initWithIdentifier:@"1"];
        });
        
        let(userTwo, ^TestUser *{
            return [[TestUser alloc] initWithIdentifier:@"2"];
        });
        
        specify(^{
            [[userOne shouldNot] beNil];
            [[userTwo shouldNot] beNil];
        });
        
        it(@"should not overide other users data", ^{
            NSString *nameOne = @"nameOne";
            NSString *nameTwo = @"nameTwo";
            
            userOne.name = nameOne;
            userTwo.name = nameTwo;
            
            [[userOne.name should] equal:nameOne];
            [[userTwo.name should] equal:nameTwo];
        });
    });
});

SPEC_END
