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

@property (nullable, nonatomic, retain) NSString *aid;
@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSString *arqc;
@property (nullable, nonatomic, retain) NSString *authorisationCode;
@property (nullable, nonatomic, retain) NSString *cardHolderName;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *cardBrand;
@property (nullable, nonatomic, retain) NSString *initiatorTransactionKey;
@property (nullable, nonatomic, retain) NSString *pan;
@property (nullable, nonatomic, retain) NSNumber *rawInstalmentAmount;
@property (nullable, nonatomic, retain) NSNumber *rawInstalmentType;
@property (nullable, nonatomic, retain) NSNumber *rawStatus;
@property (nullable, nonatomic, retain) NSNumber *rawType;
@property (nullable, nonatomic, retain) NSNumber *rawCapture;
@property (nullable, nonatomic, retain) NSString *receiptTransactionKey;
@property (nullable, nonatomic, retain) NSString *reference;
@property (nullable, nonatomic, retain) NSString *shortName;
@property (nullable, nonatomic, retain) STNMerchantModel *merchant;
@property (nullable, nonatomic, retain) STNPinpadModel *pinpad;

@end

NS_ASSUME_NONNULL_END
