//
//  TransactionListProvider.h
//  StoneSDK
//
//  Created by Stone  on 11/3/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <StoneSDK/StoneSDK.h>

@interface STNTransactionListProvider : NSObject

/// Lists all completed transactions.
- (NSArray *)listTransactions:(void (^)(BOOL succeeded, NSError *error))block;
/// Lists all completed transactions for inserted card.
- (NSArray *)listTransactionsByPan:(void (^)(BOOL succeeded, NSError *error))block;


@end
