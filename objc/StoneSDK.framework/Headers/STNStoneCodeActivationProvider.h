//
//  StoneCodeActivationProvider.h
//  StoneSDK
//
//  Created by Stone  on 9/15/15.
//  Copyright (c) 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNMerchantModel.h"
#import "STNBaseProvider.h"

@interface STNStoneCodeActivationProvider : STNBaseProvider

/// Validates and activates merchant with Stonecode.
+ (void)activateStoneCode:(NSString *_Nonnull)stonecode withBlock:(nullable void (^)(BOOL succeeded, NSError *_Nullable error))block;

/// Deactivates merchant and deletes user/transactions informations.
+ (void)deactivateMerchant:(STNMerchantModel *_Nonnull)merchant;

/// Deactivates merchant and deletes user/transactions informations with Stonecode.
+ (void)deactivateMerchantWithStoneCode:(NSString *_Nonnull)stoneCode;

@end