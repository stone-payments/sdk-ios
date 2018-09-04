//
//  NSString+Utils.m
//  Demo Objc
//
//  Created by Tatiana Magdalena on 27/11/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

NSString *const kTitleBLE = @"Title_BLE";
NSString *const kTitleSelection = @"Title_Selection";
NSString *const kTitleMerchants = @"Title_Merchants";
NSString *const kTitleRefundList = @"Title_Refund_List";
NSString *const kTitleTransactions = @"Title_Transactions";
NSString *const kTitleTableDownload = @"Title_Table_Download";
NSString *const kTitleActivation = @"Title_Activation";
NSString *const kTitleManageStoneCodes = @"Title_Manage_Stone_Codes";
NSString *const kTitleSendTransaction = @"Title_Send_Transaction";
NSString *const kTitlePosteriorCapture = @"Title_Posterior_Capture_Transaction";
NSString *const kTitleUpdateTable = @"Title_Update_Table";
NSString *const kTitleRefund = @"Title_Refund";
NSString *const kTitleReceipt = @"Title_Receipt";
NSString *const kTitleValidation = @"Title_Validation";
NSString *const kTitlePan = @"Title_Pan";
NSString *const kTitleDisplay = @"Title_Display";

NSString *const kButtonScan = @"Button_Scan";
NSString *const kButtonDisconnect = @"Button_Disconnect";
NSString *const kButtonRefresh = @"Button_Refresh";
NSString *const kButtonActivate = @"Button_Activate";
NSString *const kButtonDeactivate = @"Button_Deactivate";
NSString *const kButtonSend = @"Button_Send";
NSString *const kButtonList = @"Button_List";
NSString *const kButtonDownload = @"Button_Download";
NSString *const kButtonUpload = @"Button_Upload";
NSString *const kButtonActivation = @"Button_Activation";
NSString *const kButtonPinpadConnection = @"Button_Pinpad_Connection";
NSString *const kButtonTableDownload = @"Button_Table_Download";
NSString *const kButtonInternetConnection = @"Button_Internet_Connection";
NSString *const kButtonGetPan = @"Button_Get_Pan";

NSString *const kInstructionBLE = @"Instruction_BLE";
NSString *const kInstructionSelection = @"Instruction_Selection";
NSString *const kInstructionActivation = @"Instruction_Activation";
NSString *const kInstructionAmount = @"Instruction_Amount";
NSString *const kInstructionCancelConfirmation = @"Instruction_Cancel_Confirmation";
NSString *const kInstructionDestinationEmail = @"Instruction_Destination_Email";
NSString *const kInstructionDisplay = @"Instruction_Display";

NSString *const kEnvironmentProduction = @"Production";
NSString *const kEnvironmentInternalHomolog = @"InternalHomolog";
NSString *const kEnvironmentSandbox = @"Sandbox";
NSString *const kEnvironmentStaging = @"Staging";
NSString *const kEnvironmentCertification = @"Certification";

NSString *const kLogStartScan = @"Log_Start_Scan";
NSString *const kLogFind = @"Log_Find";
NSString *const kLogConnect = @"Log_Connect";
NSString *const kLogDisconnect = @"Log_Disconnect";
NSString *const kLogCentralState = @"Log_Central_State";

NSString *const kLogListAllTransactions = @"Log_List_All_Transactions";
NSString *const kLogListTransactionsByCard = @"Log_List_Transactions_By_Card";

NSString *const kLogDownloadSuccess = @"Log_Download_Sucess";
NSString *const kLogAskDownload = @"Log_Ask_Download";

NSString *const kLogActivating = @"Log_Activating";
NSString *const kLogActivated = @"Log_Activated";
NSString *const kLogDeactivating = @"Log_Deactivating";
NSString *const kLogDeactivated = @"Log_Deactivated";

NSString *const kLogTransactionSuccess = @"Log_Transaction_Success";

NSString *const kLogTablesUpdated = @"Log_Tabelas_Atualizadas";

NSString *const kLogTransactionCancelled = @"Log_Transaction_Cancelled";

NSString *const kLogEmailSuccess = @"Log_Email_Success";
NSString *const kLogNeedTransaction = @"Log_Need_Transaction";

NSString *const kLogIsActivated = @"Log_Is_Activated";
NSString *const kLogNotActivated = @"Log_Not_Activated";
NSString *const kLogPinpadConnected = @"Log_Pinpad_Connected";
NSString *const kLogPinpadNotConnected = @"Log_Pinpad_Not_Connected";
NSString *const kLogTablesDownloaded = @"Log_Tables_Downloaded";
NSString *const kLogTablesNotDownloaded = @"Log_Tables_Not_Downloaded";
NSString *const kLogInternetConnection = @"Log_Internet_Connection";
NSString *const kLogNoInternetConnection = @"Log_No_Internet_Connection";

NSString *const kLogMessageSent = @"Log_Message_Sent";

NSString *const kGeneralYes = @"YES";
NSString *const kGeneralNo = @"NO";
NSString *const kGeneralErrorTitle = @"Error_Title";
NSString *const kGeneralErrorMessage = @"Error_Message";
NSString *const kGeneralOk = @"Ok";
NSString *const kGeneralConnected = @"Connected";
NSString *const kGeneralNotConnected = @"Not_connected";
NSString *const kGeneralDebit = @"Debit";
NSString *const kGeneralCredit = @"Credit";
NSString *const kGeneralWithInterest = @"With_Interest";
NSString *const kGeneralInterestFree = @"Interest_Free";
NSString *const kGeneralApproved = @"Approved";
NSString *const kGeneralCancelled = @"Cancelled";
NSString *const kGeneralAll = @"All";
NSString *const kGeneralByCard = @"By_Card";
NSString *const kGeneralMerchant = @"Merchant";
NSString *const kGeneralCustomer = @"Customer";
NSString *const kGeneralInterest = @"Interest";
NSString *const kGeneralNone = @"None";
NSString *const kGeneralIssuer = @"Issuer";
NSString *const kActivationStoneCodeAlert = @"Activation_Stone_Code_Alert";

-(NSString*)localize
{
    return NSLocalizedString(self, nil);
}

@end
