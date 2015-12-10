//
//  AppDelegate.h
//  Stone Demo
//
//  Created by Erika Bueno on 14/11/15.
//  Copyright © 2015 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoneSDK/StoneSDK.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

-(void)showErrorMessage: (NSString*) error;

@property (strong, nonatomic) UIWindow *window;

@end