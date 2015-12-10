//
//  TransactionProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/21/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <StoneSDK/StoneSDK.h>
#import "STNEnums.h"

@interface STNTransactionProvider : NSObject

/// Send payment transaction.
-(void)sendTransactionWithValue:(NSInteger *)transactionAmount transactionTypeSimplified:(TransactionTypeSimplified)transactionTypeSimplified instalmentTransaction:(InstalmentTransaction)instalmentTransaction orderIdentification:(NSString *)orderIdentification withBlock:(void (^)(BOOL succeeded, NSError *error))block;

@end
