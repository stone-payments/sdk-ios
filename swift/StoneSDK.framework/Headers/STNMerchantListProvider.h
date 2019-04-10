//
//  STNMerchantListProvider.h
//  StoneSDK
//
//  Created by Jaison Vieira on 8/25/16.
//  Copyright © 2016 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNMerchantModel.h"
#import "STNBaseProvider.h"

@interface STNMerchantListProvider : NSObject

/**
 Lists all activated merchants.

 @return An array of STNMerchantModel containing all activated merchant.
 */
+ (NSArray *) listMerchants;

/**
 Gets a merchant model with given stonecode.

 @param stoneCode The merchant's stonecode.
 @return The merchant model representing the merchant with given stonecode.
 */
+ (STNMerchantModel *)getActivatedMerchantWithStoneCode:(NSString*)stoneCode;

@end
