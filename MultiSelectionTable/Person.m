//
//  Person.m
//  MultiSelectionTable
//
//  Created by Hoàng Thái on 3/12/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

#import "Person.h"

@implementation Person

NSArray* firstName;
NSArray* lastName;

- (instancetype)init {
    static dispatch_once_t dispatch_Once;
    dispatch_once(&dispatch_Once, ^{
        firstName = @[@"Heiniken", @"Tiger", @"Larue", @"SaigonBeer", @"Habeco", @"VietHa", @"DaiViet", @"Halida"];
        lastName = @[@"VeryGood", @"Fantasic", @"NotBad", @"Impossible", @"Amazing"];
    });
    if (self = [super init]) {
        self.name = [NSString stringWithFormat:@"%@ %@", 
                     firstName[arc4random_uniform((int)firstName.count)], 
                     lastName[arc4random_uniform((int)lastName.count)]];
        self.age = [NSString stringWithFormat:@"%d", 10 + arc4random_uniform(40)];
    };
    return self;
}

@end
