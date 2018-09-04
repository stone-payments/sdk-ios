//
//  STNReceiptModel.h
//  StoneSDK
//
//  Created by Tatiana Magdalena on 05/12/17.
//  Copyright © 2017 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNTransactionModel.h"
#import "STNEnums.h"

@interface STNReceiptModel : NSObject

/// Whether the receipt is being send to the customer or to the merchant.
@property (nonatomic) STNReceiptType type;
/// The transaction which will provide the information to the receipt.
@property (nonatomic,strong) STNTransactionModel *transaction;
/// Whether the receipt must have the address information of the merchant.
@property (nonatomic) BOOL displayCompanyInformation;

@end
