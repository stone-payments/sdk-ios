//
//  STNMerchantListProvider.h
//  StoneSDK
//
//  Created by Jaison Vieira on 8/25/16.
//  Copyright © 2016 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNMerchantListProvider : NSObject

/// Lists all activated merchants.
+ (NSArray *)listMerchants;

@end
