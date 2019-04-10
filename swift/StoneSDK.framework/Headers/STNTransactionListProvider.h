//
//  TransactionListProvider.h
//  StoneSDK
//
//  Created by Stone  on 11/3/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNBaseProvider.h"

@interface STNTransactionListProvider : STNBaseProvider

/// Lists all completed transactions.
+ (NSArray *)listTransactions;
/// Lists all completed transactions for inserted card.
+ (void)listTransactionsByPan:(void (^)(BOOL succeeded, NSArray *transactionsList, NSError *error))block;

@end
