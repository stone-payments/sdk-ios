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
#import "STNReceiptModel.h"
#import "STNContactModel.h"
#import "STNBaseProvider.h"

@interface STNMailProvider : NSObject

/**
 Sends email based on Receipt Type using transaction data.

 @param receipt (required) Receipt model containing all receipt needed information.
 @param from (optional) Email contact model which will appear as the email sender. If nil, or if it's address isn't set, a Stone noreply email will be set.
 @param destination (required) Destination contact model.
 @param block Return callback. If receipt was successfully sent, `succeeded` will be YES and error nil. If not, `succeeded` will be NO and `error` will provide the error information.
 */
+ (void)sendReceiptViaEmail:(STNReceiptModel*)receipt
                       from:(STNContactModel*)from
                         to:(STNContactModel*)destination
                  withBlock:(void (^)(BOOL succeeded, NSError *error))block;



//--------------------
// DEPRECATED
//--------------------

/// Sends email based on MailTemplate using transaction data. DEPRECATED: It will only send Customer Type receipts.
+ (void)sendReceiptViaEmail:(STNMailTemplate)mailTemplate
                transaction:(STNTransactionModel *)transaction
              toDestination:(NSString *)destination
  displayCompanyInformation:(BOOL)displayCompanyInformation
                  withBlock:(void (^)(BOOL succeeded, NSError *error))block DEPRECATED_MSG_ATTRIBUTE("Deprecated in version 2.3.0. Use sendReceiptViaEmail:to:withBlock instead. Will be removed in the next version.");

@end
