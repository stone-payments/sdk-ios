//
//  ValidationProvider.h
//  StoneSDK
//
//  Created by Stone  on 11/10/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNMerchantModel.h"
#import "STNBaseProvider.h"

@interface STNValidationProvider : NSObject 

/// Checks whether a Stonecode is activated or not.
+ (BOOL)validateActivation;

/// Checks whether the provided Stonecode is activated or not.
+ (BOOL)validateActivationOfStonecode:(NSString*)stoneCode;

/// Checks whether the provided merchant is activated or not.
+ (BOOL)validateActivationOfMerchant:(STNMerchantModel*)merchant;

/// Checks whether the pinpad is connected or not.
+ (BOOL)validatePinpadConnection;

/// Checks whether the pinpad is supported or not.
+ (BOOL)validateSupportedPinpad __deprecated;
+ (BOOL)validatePinpadSupport;

/// Checks whether the tables are cached or not.
+ (BOOL)validateTablesDownloaded __deprecated;

/// Checks whether the tables are correct or not.
+ (BOOL)validateTablesData;

/// Checks whether the servers are reachable or not.
+ (BOOL)validateConnectionToNetWork;

@end
