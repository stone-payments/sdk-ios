//
//  STNMerchantModel.h
//  StoneSDK
//
//  Created by Jaison Vieira on 7/5/16.
//  Copyright © 2016 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STNAddressModel.h"
#import "STNTransactionModel.h"

@class STNAddressModel;
@class STNTransactionModel;

NS_ASSUME_NONNULL_BEGIN

@interface STNMerchantModel : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "STNMerchantModel+CoreDataProperties.h"
