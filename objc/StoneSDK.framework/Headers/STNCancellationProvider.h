//
//  CancellationProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/29/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNTransactionModel.h"
#import "STNBaseProvider.h"

@interface STNCancellationProvider : STNBaseProvider

/// Cancels transaction having the transaction object as parameter.
+ (void)cancelTransaction:(STNTransactionModel *)transaction withBlock:(void (^)(BOOL succeeded, NSError *error))block;

@end
