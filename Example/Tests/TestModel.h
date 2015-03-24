//
//  TestModel.h
//  REDModelTests
//
//  Created by Red Davis on 11/03/2015.
//  Copyright (c) 2015 Red Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <REDModel/REDModel.h>


@interface TestModel : NSObject <REDModel>

@property (copy, nonatomic) NSString *string;
@property (copy, nonatomic) NSDate *date;
@property (copy, nonatomic) NSNumber *number;

@end
