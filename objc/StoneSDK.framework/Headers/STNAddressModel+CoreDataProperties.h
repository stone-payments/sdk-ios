//
//  STNAddressModel+CoreDataProperties.h
//  StoneSDK
//
//  Created by Jaison Vieira on 7/13/16.
//  Copyright © 2016 Stone . All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "STNAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STNAddressModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *complement;
@property (nullable, nonatomic, retain) NSString *district;
@property (nullable, nonatomic, retain) NSString *doorNumber;
@property (nullable, nonatomic, retain) NSString *neighborhood;
@property (nullable, nonatomic, retain) NSString *street;
@property (nullable, nonatomic, retain) NSString *zipCode;
@property (nullable, nonatomic, retain) STNMerchantModel *merchant;

@end

NS_ASSUME_NONNULL_END
