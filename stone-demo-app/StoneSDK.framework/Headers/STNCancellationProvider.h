//
//  CancellationProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/29/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <StoneSDK/StoneSDK.h>

@interface STNCancellationProvider : NSObject

/// Cancels transaction having the transaction object as parameter.
- (void)cancelTransaction:(STNTransactionInfoProvider *)info withBlock:(void (^)(BOOL succeeded, NSError *error))block;

@end
