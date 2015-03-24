//
//  TestUser.h
//  REDModelTests
//
//  Created by Red Davis on 22/03/2015.
//  Copyright (c) 2015 Red Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <REDModel/REDModel.h>


@interface TestUser : NSObject <REDModel>

@property (copy, nonatomic) NSString *name;

- (instancetype)initWithIdentifier:(NSString *)identifier;

@end
