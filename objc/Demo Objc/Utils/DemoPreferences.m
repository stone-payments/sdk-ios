//
//  DemoPreferences.m
//  Demo Objc
//
//  Created by Kennedy Noia | Stone on 24/04/2018.
//  Copyright © 2018 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "DemoPreferences.h"

@implementation DemoPreferences

// NSUserDefaults write environment
+ (BOOL)updateEnvironment:(STNEnvironment)environment {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:(int)environment forKey:@"DemoEnvironment"];
    [defaults synchronize];
    if ([DemoPreferences lastSelectedEnvironment] == environment) {
        [STNConfig setEnvironment:environment];
        return YES;
    }
    return NO;
}

// NSUserDefaults read environment
+ (STNEnvironment)lastSelectedEnvironment {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (STNEnvironment)[defaults integerForKey:@"DemoEnvironment"];
}

// NSUserDefaults write selected device
+ (BOOL)updateLastSelectedDevice:(NSString *)deviceId {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:deviceId forKey:@"DemoLastSelectedDevice"];
    [defaults synchronize];
    
    return ([DemoPreferences lastSelectedDevice] == deviceId);
}

// NSUserDefaults read last selected device
+ (NSString *)lastSelectedDevice {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:@"DemoLastSelectedDevice"];
}

// NSUserDefaults write last selected merchant
+ (BOOL)updateLastSelectedStoneCode:(NSString *)stoneCode {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:stoneCode forKey:@"DemoLastSelectedStoneCode"];
    [defaults synchronize];
    
    return ([DemoPreferences lastSelectedStoneCode] == stoneCode);
}

// NSUserDefaults read last selected merchant
+ (NSString *)lastSelectedStoneCode {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:@"DemoLastSelectedStoneCode"];
}
@end
