//
//  DownloadTablesProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/14/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNMerchantModel.h"
#import "STNBaseProvider.h"

@interface STNTableDownloaderProvider : STNBaseProvider

/// Downloads AID and CAPK tables from server. Uses the first activated merchant.
+ (void)downLoadTables:(void (^)(BOOL succeeded, NSError *error))block __deprecated_msg("no need anymore.");

/**
 Downloads AID and CAPK tables from server from a merchant.

 @param merchant The merchant from which the tables will be downloaded.
 */
+ (void)downLoadTablesFromMerchant:(STNMerchantModel*)merchant withBlock:(void (^)(BOOL succeeded, NSError *error))block __deprecated_msg("no need anymore.");

@end
