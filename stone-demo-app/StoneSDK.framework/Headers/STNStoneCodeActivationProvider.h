//
//  StoneCodeActivationProvider.h
//  StoneSDK
//
//  Created by Stone  on 9/15/15.
//  Copyright (c) 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNStoneCodeActivationProvider : NSObject

/// Validates and activates Stonecode.
- (void)activateStoneCode:(NSString *)stoneCode withBlock:(void (^)(BOOL succeeded, NSError *error))block;

@end