//
//  STNMerchantModel+CoreDataProperties.h
//  StoneSDK
//
//  Created by Jaison Vieira on 8/31/16.
//  Copyright © 2016 Stone. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "STNMerchantModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STNMerchantModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *documentNumber;
@property (nullable, nonatomic, retain) NSString *merchantName;
@property (nullable, nonatomic, retain) NSString *saleAffiliationKey;
@property (nullable, nonatomic, retain) NSString *stonecode;
@property (nullable, nonatomic, retain) STNAddressModel *address;
@property (nullable, nonatomic, retain) NSOrderedSet<STNTransactionModel *> *transactions;

@end

NS_ASSUME_NONNULL_END
