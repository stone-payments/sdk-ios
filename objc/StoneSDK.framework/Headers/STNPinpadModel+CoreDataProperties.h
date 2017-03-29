//
//  STNPinpadModel+CoreDataProperties.h
//  StoneSDK
//
//  Created by Jaison Vieira on 8/19/16.
//  Copyright © 2016 Stone. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "STNPinpadModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STNPinpadModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) NSString *serialNumber;
@property (nullable, nonatomic, retain) STNTransactionModel *transaction;

@end

NS_ASSUME_NONNULL_END
