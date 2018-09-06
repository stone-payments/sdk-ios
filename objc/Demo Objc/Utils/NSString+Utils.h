//
//  NSString+Utils.h
//  Demo Objc
//
//  Created by Tatiana Magdalena on 27/11/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

extern NSString *const kTitleBLE;
extern NSString *const kTitleSelection;
extern NSString *const kTitleMerchants;
extern NSString *const kTitleRefundList;
extern NSString *const kTitleTransactions;
extern NSString *const kTitleTableDownload;
extern NSString *const kTitleActivation;
extern NSString *const kTitleManageStoneCodes;
extern NSString *const kTitleSendTransaction;
extern NSString *const kTitlePosteriorCapture;
extern NSString *const kTitleUpdateTable;
extern NSString *const kTitleRefund;
extern NSString *const kTitleReceipt;
extern NSString *const kTitleValidation;
extern NSString *const kTitlePan;
extern NSString *const kTitleDisplay;

extern NSString *const kButtonScan;
extern NSString *const kButtonDisconnect;
extern NSString *const kButtonRefresh;
extern NSString *const kButtonActivate;
extern NSString *const kButtonDeactivate;
extern NSString *const kButtonSend;
extern NSString *const kButtonList;
extern NSString *const kButtonDownload;
extern NSString *const kButtonUpload;
extern NSString *const kButtonActivation;
extern NSString *const kButtonPinpadConnection;
extern NSString *const kButtonTableDownload;
extern NSString *const kButtonInternetConnection;
extern NSString *const kButtonGetPan;

extern NSString *const kInstructionBLE;
extern NSString *const kInstructionSelection;
extern NSString *const kInstructionActivation;
extern NSString *const kInstructionAmount;
extern NSString *const kInstructionCancelConfirmation;
extern NSString *const kInstructionDestinationEmail;
extern NSString *const kInstructionDisplay;

extern NSString *const kEnvironmentProduction;
extern NSString *const kEnvironmentInternalHomolog;
extern NSString *const kEnvironmentSandbox;
extern NSString *const kEnvironmentStaging;
extern NSString *const kEnvironmentCertification;

extern NSString *const kLogStartScan;
extern NSString *const kLogFind;
extern NSString *const kLogConnect;
extern NSString *const kLogDeviceAlreadyConnected;
extern NSString *const kLogDisconnect;
extern NSString *const kLogUnableToConnect;
extern NSString *const kLogSelect;
extern NSString *const kLogUnableToSelect;
extern NSString *const kLogCentralState;

extern NSString *const kLogListAllTransactions;
extern NSString *const kLogListTransactionsByCard;

extern NSString *const kLogDownloadSuccess;
extern NSString *const kLogAskDownload;

extern NSString *const kLogActivating;
extern NSString *const kLogActivated;
extern NSString *const kLogDeactivating;
extern NSString *const kLogDeactivated;

extern NSString *const kLogTransactionSuccess;

extern NSString *const kLogTablesUpdated;

extern NSString *const kLogTransactionCancelled;

extern NSString *const kLogEmailSuccess;
extern NSString *const kLogNeedTransaction;

extern NSString *const kLogIsActivated;
extern NSString *const kLogNotActivated;
extern NSString *const kLogPinpadConnected;
extern NSString *const kLogPinpadNotConnected;
extern NSString *const kLogTablesDownloaded;
extern NSString *const kLogTablesNotDownloaded;
extern NSString *const kLogInternetConnection;
extern NSString *const kLogNoInternetConnection;

extern NSString *const kLogMessageSent;

extern NSString *const kGeneralYes;
extern NSString *const kGeneralNo;
extern NSString *const kGeneralErrorTitle;
extern NSString *const kGeneralErrorMessage;
extern NSString *const kGeneralOk;
extern NSString *const kGeneralConnected;
extern NSString *const kGeneralNotConnected;
extern NSString *const kGeneralDebit;
extern NSString *const kGeneralCredit;
extern NSString *const kGeneralWithInterest;
extern NSString *const kGeneralInterestFree;
extern NSString *const kGeneralApproved;
extern NSString *const kGeneralCancelled;
extern NSString *const kGeneralAll;
extern NSString *const kGeneralByCard;
extern NSString *const kGeneralMerchant;
extern NSString *const kGeneralCustomer;
extern NSString *const kGeneralInterest;
extern NSString *const kGeneralNone;
extern NSString *const kGeneralIssuer;
extern NSString *const kActivationStoneCodeAlert;

-(NSString*)localize;

@end
