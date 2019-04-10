//
//  STNCaptureTransactionProvider.h
//  StoneSDK
//
//  Created by Kennedy Noia on 17/02/2018.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNEnums.h"
#import "STNTransactionModel.h"

#import "STNEnums_old.h"
#import "STNBaseProvider.h"

@interface STNCaptureTransactionProvider : STNBaseProvider

/// Capture payment transaction.
+ (void)capture:(STNTransactionModel *)transaction withBlock:(void (^)(BOOL succeeded, NSError *error))block;

@end
