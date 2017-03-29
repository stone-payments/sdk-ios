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

@interface STNTransactionProvider : NSObject

/// Send payment transaction.
+ (void)sendTransaction:(STNTransactionModel *)transaction withBlock:(void (^)(BOOL succeeded, NSError *error))block;

/// Use 'sendTransaction:' instead.
- (void)sendTransactionWithValue:(NSInteger *)transactionAmount transactionTypeSimplified:(TransactionTypeSimplified)transactionTypeSimplified instalmentTransaction:(InstalmentTransaction)instalmentTransaction transactionId:(NSString *)transactionId withBlock:(void (^)(BOOL succeeded, NSError *error))block DEPRECATED_ATTRIBUTE;

/// Use 'transactionId' instead of 'orderIdentification' in the method's signature.
- (void)sendTransactionWithValue:(NSInteger *)transactionAmount transactionTypeSimplified:(TransactionTypeSimplified)transactionTypeSimplified instalmentTransaction:(InstalmentTransaction)instalmentTransaction orderIdentification:(NSString *)orderIdentification withBlock:(void (^)(BOOL succeeded, NSError *error))block DEPRECATED_ATTRIBUTE;


@property (strong, nonatomic) NSString *Chname;
@property (strong, nonatomic) NSString *flag;
@property (strong, nonatomic) NSString *reference;
@property (strong, nonatomic) NSString *recipient;
@property (strong, nonatomic) NSString *Acode;
@property (strong, nonatomic) NSString *msgCntt;
@property (strong, nonatomic) NSString *str_type;
@property (strong, nonatomic) NSString *PAN;
@property (strong, nonatomic) NSString *str_amount;
@property (weak, nonatomic) NSString *str_status;
@property (strong, nonatomic) NSString *RECIDX;

@property (strong, nonatomic) NSString *emvData;

@property (strong, nonatomic) NSString *amount;
@property (strong, nonatomic) NSString *parcelas;
@property (strong, nonatomic) NSString *orderId;

@end


