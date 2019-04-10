//
//  TransactionProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/21/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNEnums.h"
#import "STNTransactionModel.h"

#import "STNEnums_old.h"
#import "STNBaseProvider.h"

@interface STNTransactionProvider : STNBaseProvider

/// Send payment transaction.
+ (void)sendTransaction:(STNTransactionModel *)transaction withBlock:(void (^)(BOOL succeeded, NSError *error))block;

+ (NSString *)responseMessageFromAuthorizerForLastTransaction;


@end


