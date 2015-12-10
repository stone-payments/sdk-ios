//
//  MailProvider.h
//  StoneSDK
//
//  Created by Stone  on 11/11/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNTransactionInfoProvider.h"
#import "STNEnums.h"

@interface STNMailProvider : NSObject

/// Sends email based on MailTemplate using transaction data.
- (void)sendReceiptViaEmail:(MailTemplate)mailTemplate transactionInfo:(STNTransactionInfoProvider *)transactionInfo toDestination:(NSString *)destination displayCompanyInformation:(BOOL)displayCompanyInformation withBlock:(void (^)(BOOL succeeded, NSError *error))block;

@end