//
//  TableLoaderProvider.h
//  StoneSDK
//
//  Created by Stone  on 9/23/15.
//  Copyright (c) 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNMerchantModel.h"
#import "STNBaseProvider.h"

@interface STNTableLoaderProvider : STNBaseProvider

/// Loads AID and CAPK tables to the PinPad. Uses the tables from the first activated merchant.
+ (void)loadTables:(void (^)(BOOL succeeded, NSError *error))block;


/**
 Loads a merchant AID and CAPK tables to the PinPad.

 @param merchant The merchant from which the tables will be loaded.
 */
+ (void)loadTablesFromMerchant:(STNMerchantModel*)merchant withBlock:(void (^)(BOOL succeeded, NSError *error))block __deprecated_msg("use loadTables instead.");

@end
