//
//  MailProvider.h
//  StoneSDK
//
//  Created by Stone  on 11/11/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNEnums.h"
#import "STNTransactionModel.h"

@interface STNMailProvider : NSObject

/// Sends email based on MailTemplate using transaction data.
+ (void)sendReceiptViaEmail:(STNMailTemplate)mailTemplate transaction:(STNTransactionModel *)transaction toDestination:(NSString *)destination displayCompanyInformation:(BOOL)displayCompanyInformation withBlock:(void (^)(BOOL succeeded, NSError *error))block;


+ (void)sendEmailFeedback:(NSString *)message withBlock:(void (^)(BOOL succeeded, NSError *error))block;

@end