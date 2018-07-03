//
//  DemoPreferences.m
//  Demo Objc
//
//  Created by Kennedy Noia | Stone on 24/04/2018.
//  Copyright © 2018 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "DemoPreferences.h"

@implementation DemoPreferences

+ (BOOL)writeEnvironment:(STNEnvironment)environment
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:(int)environment forKey:@"DemoEnvironment"];
    [defaults synchronize];
    BOOL written = ([DemoPreferences readEnvironment] == environment);
    if (written)
    {
        [STNConfig setEnvironment:environment];
        return YES;
    }
    return NO;
}

+ (STNEnvironment)readEnvironment
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (STNEnvironment)[defaults integerForKey:@"DemoEnvironment"];
}

@end
