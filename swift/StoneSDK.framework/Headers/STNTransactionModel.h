//
//  STNTransactionModel.h
//  StoneSDK
//
//  Created by Jaison Vieira on 7/5/16.
//  Copyright © 2016 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STNEnums.h"
#import "STNMerchantModel.h"
#import "STNPinpadModel.h"

@class STNMerchantModel;
@class STNPinpadModel;

NS_ASSUME_NONNULL_BEGIN

@interface STNTransactionModel : NSManagedObject

/// Credit or debit.
@property (nonatomic, assign) STNTransactionTypeSimplified type;
/// String representing the type of the transactions
@property (nonatomic, retain) NSString *typeString;
/// How many instalments the transaction will be split into.
@property (nonatomic, assign) STNTransactionInstalmentAmount instalmentAmount;
/// None, by issuer or by merchant.
@property (nonatomic, assign) STNInstalmentType instalmentType; // with interest?
/// The current state of the transaction.
@property (nonatomic, assign) STNTransactionStatus status;
/// String representing the current state of the transaction.
@property (nonatomic, retain) NSString *statusString;
/// String representing the date the transaction took place, with the format "dd/MM/yyyy - HH:mm".
@property (nonatomic, retain) NSString *dateString;
/// If the transaction must be capture or not when sent.
@property (nonatomic, assign) STNTransactionCapture capture;
/// Card brand.
@property (nonatomic, assign) STNCardBrand cardBrand;
/// String representing the card brand.
@property (nonatomic, retain) NSString *cardBrandString;
/// Whether the transaction was made by magnetic stripe (`STNTransactionEntryModeMagneticStripe`) or chip and pin (`STNTransactionEntryModeChipNPin`)
@property (nonatomic, assign) STNTransactionEntryMode entryMode;

-(STNAccountType)getAccountType;

@end

NS_ASSUME_NONNULL_END

#import "STNTransactionModel+CoreDataProperties.h"
