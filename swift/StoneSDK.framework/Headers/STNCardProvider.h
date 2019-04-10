//
//  STNCardProvider.h
//  StoneSDK
//
//  Created by Jaison Vieira on 1/22/16.
//  Copyright © 2016 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNMerchantModel.h"
#import "STNBaseProvider.h"

@interface STNCardProvider : STNBaseProvider

/// Asks user to insert card and gets its last 4 digits. Uses the first activated merchant tables.
+ (void)getCardPan:(void (^)(BOOL succeeded, NSString *pan, NSError *error))block;


/**
 Asks user to insert card and gets its last 4 digits.

 @param merchant The merchant for which the tables are loaded at the pinpad.
 */
+ (void)getCardPanWithMerchant:(STNMerchantModel*)merchant andBlock:(void (^)(BOOL succeeded, NSString *pan, NSError *error))block __deprecated;

@end
