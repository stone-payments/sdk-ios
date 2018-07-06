//
//  DemoPreferences.h
//  Demo Objc
//
//  Created by Kennedy Noia | Stone on 24/04/2018.
//  Copyright © 2018 Stone. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "StoneSDK/StoneSDK.h"

@interface DemoPreferences : NSObject

// NSUserDefaults write and read for last selected environment
+ (BOOL)updateEnvironment:(STNEnvironment)environment;
+ (STNEnvironment)lastSelectedEnvironment;

// NSUserDefaults write and read for last selected device
+ (BOOL)updateLastSelectedDevice:(NSString *)deviceId;
+ (NSString *)lastSelectedDevice;

// NSUserDefaults write and read for last selected merchant
+ (BOOL)updateLastSelectedStoneCode:(NSString *)stoneCode;
+ (NSString *)lastSelectedStoneCode;

@end
