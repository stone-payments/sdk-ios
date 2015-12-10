//
//  ValidationProvider.h
//  StoneSDK
//
//  Created by Stone  on 11/10/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <StoneSDK/StoneSDK.h>

@interface ValidationProvider : RootProvider

/// Checks wheather there's network connection or not.
+ (BOOL)validateNetwork;

/// Checks wheather Stonecode is activated or not.
+ (BOOL)validateActivation;

/// Checks wheather the pinpad is connected or not.
+ (BOOL)validatePinpadConnection;

@end
