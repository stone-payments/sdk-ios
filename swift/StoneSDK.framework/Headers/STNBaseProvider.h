//
// Created by Bruno Colombini | Stone on 26/11/18.
// Copyright (c) 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STNBaseProvider : NSObject


@property(nonatomic) NSString *stoneCode;

- (NSError *) validateVersion;
- (BOOL) isValidVersion;
@end