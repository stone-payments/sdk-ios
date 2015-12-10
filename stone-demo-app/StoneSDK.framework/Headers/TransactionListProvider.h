//
//  TransactionListProvider.h
//  StoneSDK
//
//  Created by Stone  on 11/3/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <StoneSDK/StoneSDK.h>

@interface TransactionListProvider : RootProvider

/// Lists all completed transactions.
- (NSArray *)listTransactions;
/// Lists all completed transactions for inserted card.
- (NSArray *)listTransactionsByPan;


@end
