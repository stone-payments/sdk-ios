//
//  DemoPreferences.h
//  Demo Objc
//
//  Created by Kennedy Noia | Stone on 24/04/2018.
//  Copyright © 2018 Eduardo Mello de Macedo | Stone. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "StoneSDK/StoneSDK.h"

@interface DemoPreferences : NSObject

+ (BOOL)updateEnvironment:(STNEnvironment)environment;
+ (STNEnvironment)lastSelectedEnvironment;

@end
