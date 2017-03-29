//
//  ValidationProvider.h
//  StoneSDK
//
//  Created by Stone  on 11/10/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNValidationProvider : NSObject

/// Checks wheather Stonecode is activated or not.
+ (BOOL)validateActivation;

/// Checks wheather the pinpad is connected or not.
+ (BOOL)validatePinpadConnection;

/// Checks wheather the tables are cached or not.
+ (BOOL)validateTablesDownloaded;

/// Checks wheather the servers are reachable or not.
+ (BOOL)validateConnectionToNetWork;

@end
