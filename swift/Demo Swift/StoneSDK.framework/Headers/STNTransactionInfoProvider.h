//
//  TransactionsInfo.h
//  StoneSDK
//
//  Created by Stone  on 9/3/15.
//  Copyright (c) 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNTransactionModel.h"

@interface STNTransacInfoProvider : NSObject

@property (nonatomic, assign) int uniqueId;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *instalments;
@property (nonatomic, strong) NSString *aid;
@property (nonatomic, strong) NSString *arqc;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *receiptTransactionKey;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSString *pan;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *cardHolderName;
@property (nonatomic, strong) NSString *authorisationCode; //stoneId
@property (nonatomic, strong) NSString *transactionId;

- (id)initWithTransactionModel:(STNTransactionModel *)transaction;

@end
