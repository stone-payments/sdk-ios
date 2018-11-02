//
//  STNTransactionModel+CoreDataProperties.h
//  StoneSDK
//
//  Created by Jaison Vieira on 8/31/16.
//  Copyright © 2016 Stone. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "STNTransactionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STNTransactionModel (CoreDataProperties)

/// AID code.
@property (nullable, nonatomic, retain) NSString *aid;
/// Transaction value without decimal separators (eg.: for R$ 10.00 it will be 1000).
@property (nullable, nonatomic, retain) NSNumber *amount;
/// Balance amount for vouchers (eg.: Ticket, Sodexo).
@property (nullable, nonatomic, retain) NSNumber *balance;
/// ARQC code.
@property (nullable, nonatomic, retain) NSString *arqc;
/// Stone ID.
@property (nullable, nonatomic, retain) NSString *authorisationCode;
/// Card holder name.
@property (nullable, nonatomic, retain) NSString *cardHolderName;
/// Masked pan number, with format `123456*******1234`.
@property (nullable, nonatomic, retain) NSString *cardHolderNumber;
/// 4 last digits of the card used in the transaction.
@property (nullable, nonatomic, retain) NSString *pan;
/// The date the transaction was sent.
@property (nullable, nonatomic, retain) NSDate *date;
/// ID thant can be set by user.
@property (nullable, nonatomic, retain) NSString *initiatorTransactionKey;
/// Transaction ID.
@property (nullable, nonatomic, retain) NSString *receiptTransactionKey;
/// Transaction reference number.
@property (nullable, nonatomic, retain) NSString *reference;
/// Custom name for the customer's invoice.
@property (nullable, nonatomic, retain) NSString *shortName;
/// Binary image of the cardholder signature
@property (nullable, nonatomic, retain) NSData *signature;
/// The cardholder verification method, as a string representing the hex value sent by the pinpad (only for EMV chip transactions)
@property (nullable, nonatomic, retain) NSString *cvm;
// The aplication label from card
@property (nullable, nonatomic, retain) NSString *applicationLabel;
/// Indicates what types of charges can be accepted, saved as a string representing the hex value sent by the pinpad (gathered on both EMV and magnetic stripe transactions)
@property (nullable, nonatomic, retain) NSString *serviceCode;
/// ICC related data.
@property (nullable, nonatomic, retain) NSString *iccRelatedData;
/// Merchant used in the transaction.
@property (nullable, nonatomic, retain) STNMerchantModel *merchant;
/// Pinpad used in the transaction.
@property (nullable, nonatomic, retain) STNPinpadModel *pinpad;
/// Authorisation response code.
@property (nullable, nonatomic, retain) NSString *actionCode;
@property (nullable, nonatomic, retain) NSString *subMerchantCategoryCode;
@property (nullable, nonatomic, retain) NSString *subMerchantAddress;
@property (nullable, nonatomic, retain) NSString *subMerchantCity;
@property (nullable, nonatomic, retain) NSString *subMerchantPostalAddress;
@property (nullable, nonatomic, retain) NSString *subMerchantTaxIdentificationNumber;
@property (nullable, nonatomic, retain) NSString *subMerchantRegisteredIdentifier;
// is fallback
@property (nullable, nonatomic, retain) NSNumber *isFallbackTransaction;

@property (nullable, nonatomic, retain) NSNumber *rawInstalmentAmount;
@property (nullable, nonatomic, retain) NSNumber *rawInstalmentType;
@property (nullable, nonatomic, retain) NSNumber *rawCardBrand;
@property (nullable, nonatomic, retain) NSNumber *rawStatus;
@property (nullable, nonatomic, retain) NSNumber *rawType;
@property (nullable, nonatomic, retain) NSNumber *rawCapture;
@property (nullable, nonatomic, retain) NSNumber *rawEntryMode;

@end

NS_ASSUME_NONNULL_END
