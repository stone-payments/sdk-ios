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

@property (nonatomic, assign) STNTransactionTypeSimplified type; // credit or debit
@property (nonatomic, assign) STNTransactionInstalmentAmount instalmentAmount; // instalments
@property (nonatomic, assign) STNInstalmentType instalmentType; // with interest?
@property (nonatomic, assign) STNTransactionStatus status;
@property (nonatomic, retain) NSString *statusString;
@property (nonatomic, retain) NSString *typeString;
@property (nonatomic, retain) NSString *dateString;
@property (nonatomic, assign) STNTransactionCapture capture;

-(STNAccountType)getAccountType;

@end

NS_ASSUME_NONNULL_END

#import "STNTransactionModel+CoreDataProperties.h"
