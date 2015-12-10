//
//  CancellationProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/29/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <StoneSDK/StoneSDK.h>

@interface CancellationProvider : RootProvider

/// Cancels transaction having the transaction object as parameter.
- (void)cancelTransaction:(TransactionsInfo *)info;

@end
