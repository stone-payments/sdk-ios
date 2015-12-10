//
//  StoneCodeActivationProvider.h
//  StoneSDK
//
//  Created by Stone  on 9/15/15.
//  Copyright (c) 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootProvider.h"

@interface StoneCodeActivationProvider : RootProvider

/// Validates and activates Stonecode.
- (void)validateAndActivateWithStoneCode:(NSString *)stoneCode;

@end