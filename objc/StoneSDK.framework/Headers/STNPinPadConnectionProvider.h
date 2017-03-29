//
//  PinPadConnectionProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/2/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNPinPadConnectionProvider : NSObject

/// Estabilishes session when connected to Pinpad.
+ (void)connectToPinpad:(void (^)(BOOL succeeded, NSError *error))block;

@end
