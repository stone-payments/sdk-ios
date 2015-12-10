//
//  AppDelegate.m
//  Stone Demo
//
//  Created by Erika Bueno on 14/11/15.
//  Copyright © 2015 Stone. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

NSTimer* timer;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.133 green:0.604 blue:0.239 alpha:1]];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    // Mantém a conexão ativa mesmo quando o app fica em background.
    timer = [NSTimer scheduledTimerWithTimeInterval: 60 * 3
                                             target: self
                                           selector: @selector(keepConnectionAlive)
                                           userInfo: nil
                                            repeats: YES];
    
    UIBackgroundTaskIdentifier bgTask;
    UIApplication *app = [UIApplication sharedApplication];
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^
              {
                  [app endBackgroundTask:bgTask];
              }];
    
}


// Mantém a conexão ativa.

- (void)keepConnectionAlive
{
    
    STNPinPadConnectionProvider *pinPadConnectionProvider = [[STNPinPadConnectionProvider alloc] init];
    [pinPadConnectionProvider connectToPinpad:^(BOOL succeeded, NSError *error)
     {
         if (succeeded)
         {
             NSLog(@"Pinpad conectado.");
         } else
         {
             [self showErrorMessage:[error localizedDescription]];
         }
     }];
    
}


// Alerta de erro.

-(void)showErrorMessage: (NSString *) error
{
    
    UIAlertController *errorAlert = [UIAlertController
                                     alertControllerWithTitle:@"Erro!"
                                     message:error
                                     preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   [errorAlert dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [errorAlert addAction:okButton];
    [self.window.rootViewController presentViewController:errorAlert animated:YES completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [timer invalidate];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end