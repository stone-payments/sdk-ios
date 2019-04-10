//
//  STNEnums.h
//  StoneSDK
//
//  Created by Jaison Vieira on 4/8/16.
//  Copyright © 2016 Stone . All rights reserved.
//

#define PINPAD_MESSAGE @"STNPinpadNTMMessage"

typedef enum _STNMailTemplate {
    STNMailTemplateDefault,
    STNMailTemplateTransaction,
    STNMailTemplateVoidTransaction

} STNMailTemplate DEPRECATED_MSG_ATTRIBUTE("Deprecated in version 2.3.0. Use STNReceiptType instead. Will be removed in the next version.");

typedef enum _STNReceiptType {
    STNReceiptTypeMerchant,
    STNReceiptTypeCustomer,

} STNReceiptType;

typedef enum _STNContentType {
    STNContentTypePlainData,
    STNContentTypeSignedData,
    STNContentTypeEnumEnvelopedData,
    STNContentTypeDigestedData,
    STNContentTypeEncryptedData,
    STNContentTypeAuthenticatedData,

} STNContentType;

typedef enum _STNAcquirer {
    STNAcquirerInvalid = -1,
    STNAcquirerElavon = 5,
    STNAcquirerStone = 16
} STNAcquirer;

typedef enum _STNEnvironment {
    STNEnvironmentProduction,
    STNEnvironmentInternalHomolog,
    STNEnvironmentSandbox,
    STNEnvironmentStaging,
    STNEnvironmentCertification

} STNEnvironment;

typedef enum _STNErrorCode {

    STNErrorCodeGenericError = 101,
    STNErrorCodeMissingParameter = 102,
    STNErrorCodeEmailMessageError = 103,
    STNErrorCodeNumberOfCharactersExceeded = 105,
    STNErrorCodeNumberOfCharactersExceededForShortName = 106,
    STNErrorCodeFncCommandError = 110,

    STNErrorCodeMissingStonecodeActivation = 201,
    STNErrorCodeStonecodeAlreadyActivated = 202,

    STNErrorCodeInvalidParameter = 202,
    STNErrorCodeInvalidAmount = 203,
    STNErrorCodeTransactionAutoCancel = 204,
    STNErrorCodeInvalidTransaction = 205,
    STNErrorCodeTransactionFailed = 206,
    STNErrorCodeTransactionTimeout = 207,
    STNErrorCodeUnknownStoneCode = 209,
    STNErrorCodeTransactionAlreadyCancelled = 210,
    STNErrorCodeTransactionRejected = 211,
    STNErrorCodeOperationCancelledByUser = 214,
    STNErrorCodeCardRemovedByUser = 215,
    STNErrorCodeMissingTableContent = 220,
    STNErrorCodeInvalidCardApplication = 221,

    STNErrorCodePinpadConnectionNotFound = 303,
    STNErrorCodeTablesNotFound = 304,
    STNErrorCodeLoadingTablesError = 305,
    STNErrorCodeNullResponse = 306,
    STNErrorCodeTableVersionNotFound = 307,
    STNErrorCodePinpadCommunicationFailed = 308,

    STNErrorCodePinpadCommandTimeout = 309,
    
    STNErrorCodePinpadNotValid = 310,
    STNErrorCodePinpadUnableToConnect = 311,
    
    STNErrorCodeBluetoothNotReady = 401,

    STNErrorCodeNotConnectedToNetwork = 601

} STNErrorCode;

typedef enum _STNAuthenticationMethodCode {
    STNAuthenticationMethodCodeBypass,
    STNAuthenticationMethodCodeManualVerification,
    STNAuthenticationMethodCodeMerchantAuthentication,
    STNAuthenticationMethodCodeOfflinePIN,
    STNAuthenticationMethodCodeOnLinePIN,
    STNAuthenticationMethodCodePaperSignature,
    STNAuthenticationMethodCodePassword,
    STNAuthenticationMethodCodeSecureCertificate,
    STNAuthenticationMethodCodeSecuredChannel,
    STNAuthenticationMethodCodeSecureNoCertificate,
    STNAuthenticationMethodCodeSignatureCapture,
    STNAuthenticationMethodCodeUnknownMethod,

} STNAuthenticationMethodCode;

typedef enum _STNCardholderIdentificationType {
    STNCardholderIdentificationTypePassportNumber,
    STNCardholderIdentificationTypeDriversLicenseNumber,
    STNCardholderIdentificationTypeEmployeeNumber,
    STNCardholderIdentificationTypeDriverNumber,

} STNCardholderIdentificationType;

typedef enum _STNContextAttendanceCode {
    STNContextAttendanceCodeAttended,
    STNContextAttendanceCodeSemiAttended,
    STNContextAttendanceCodeUnattended,

} STNContextAttendanceCode;

typedef enum _STNTransactionEnvironmentCode {
    STNTransactionEnvironmentCodeMerchant,
    STNTransactionEnvironmentCodePrivate,
    STNTransactionEnvironmentCodePublic,

} STNTransactionEnvironmentCode;

typedef enum _STNTransactionChannelCode {
    STNTransactionChannelCodeMailOrder,
    STNTransactionChannelCodeTelephoneOrder,
    STNTransactionChannelCodeElectronicCommerce,
    STNTransactionChannelCodeTelevisionPayment,

} STNTransactionChannelCode;

typedef enum _STNPoiCardDataReadingCode {
    STNPoiCardDataReadingCodeTag,
    STNPoiCardDataReadingCodePhysical,
    STNPoiCardDataReadingCodeBarCode,
    STNPoiCardDataReadingCodeMagneticStripe,
    STNPoiCardDataReadingCodeICC,
    STNPoiCardDataReadingCodeAccountData,
    STNPoiCardDataReadingCodeProximityReader,
    STNPoiCardDataReadingCodeEMVProximityReader,

} STNPoiCardDataReadingCode;

typedef enum _STNInstalmentType {
    STNInstalmentTypeNone,
    STNInstalmentTypeMerchant,
    STNInstalmentTypeIssuer

} STNInstalmentType;

typedef enum _STNAccountType {
    STNAccountTypeDefault,
    STNAccountTypeSavings,
    STNAccountTypeChecking,
    STNAccountTypeCreditCard,
    STNAccountTypeUniversal,
    STNAccountTypeInvestment,
    STNAccountTypeEpurseCard,
    STNAccountTypeCancellation,
    STNAccountTypeListing

} STNAccountType;

typedef enum _STNPoiComponentType {
    STNPoiComponentTypeAcquirerProtocolParameters,
    STNPoiComponentTypePoiApplicationParameters,
    STNPoiComponentTypePoiTerminalParameters,
    STNPoiComponentTypePoiSecurityParameters,
    STNPoiComponentTypeServer,
    STNPoiComponentTypeTerminal,
    STNPoiComponentTypeDevice,
    STNPoiComponentTypeSecureModule,
    STNPoiComponentTypePoiPaymentApplication,
    STNPoiComponentTypeEMVKernel,
    STNPoiComponentTypeEMVLevel1,
    STNPoiComponentTypeMiddleware,
    STNPoiComponentTypeDriver,
    STNPoiComponentTypeOperatingSystem,
    STNPoiComponentTypePoiMerchantParameters

} STNPoiComponentType;

typedef enum _STNMessageFunctionCode {
    STNMessageFunctionCodeAuthorisationRequest,
    STNMessageFunctionCodeAuthorisationResponse,
    STNMessageFunctionCodeFinancialAuthorisationRequest,
    STNMessageFunctionCodeFinancialAuthorisationResponse,
    STNMessageFunctionCodeCompletionAdvice,
    STNMessageFunctionCodeCompletionAdviceResponse,
    STNMessageFunctionCodeFinancialCompletionAdvice,
    STNMessageFunctionCodeFinancialCompletionAdviceResponse,
    STNMessageFunctionCodeReversalAdvice,
    STNMessageFunctionCodeReversalAdviceResponse,
    STNMessageFunctionCodeFinancialReversalAdvice,
    STNMessageFunctionCodeFinancialReversalAdviceResponse,
    STNMessageFunctionCodeCancellationRequest,
    STNMessageFunctionCodeCancellationResponse,
    STNMessageFunctionCodeCancellationAdvice,
    STNMessageFunctionCodeCancellationAdviceResponse,
    STNMessageFunctionCodeDiagnosticRequest,
    STNMessageFunctionCodeDiagnosticResponse,
    STNMessageFunctionCodeReconciliationRequest,
    STNMessageFunctionCodeReconciliationResponse,
    STNMessageFunctionCodeAcceptorRejection,

} STNMessageFunctionCode;

typedef enum _STNEventResultCode {
    STNEventResultCodeAccessDenied,
    STNEventResultCodeConnectionError,
    STNEventResultCodeFormatError,
    STNEventResultCodeInvalidContent,
    STNEventResultCodeLengthError,
    STNEventResultCodeMemoryOverflow,
    STNEventResultCodeMissingFile,
    STNEventResultCodeNotSupported,
    STNEventResultCodeSignatureError,
    STNEventResultCodeSuccess,
    STNEventResultCodeSyntaxError,
    STNEventResultCodeTimeOut,
    STNEventResultCodeUnknownData,
    STNEventResultCodeUnknowKeyReference

} STNEventResultCode;

typedef enum _STNRequestActionType {
    STNRequestActionTypeActivate,
    STNRequestActionTypeDeactivate,
    STNRequestActionTypeDelete,
    STNRequestActionTypeDownload,
    STNRequestActionTypeInstall,
    STNRequestActionTypeRestart,
    STNRequestActionTypeUpload

} STNRequestActionType;

typedef enum _STNDataSetCategoryCode {
    STNDataSetCategoryCodeAcquirerParameters = 1,
    STNDataSetCategoryCodeApplicationParameters = 2,
    STNDataSetCategoryCodeBatchCapture = 3,
    STNDataSetCategoryCodeCaptureResponse = 4,
    STNDataSetCategoryCodeDelegationData = 5,
    STNDataSetCategoryCodeManagementPlan = 6,
    STNDataSetCategoryCodeMerchantParameters = 7,
    STNDataSetCategoryCodeSecurityParameters = 8,
    STNDataSetCategoryCodeSoftwareModule = 9,
    STNDataSetCategoryCodeStatusReport = 10,
    STNDataSetCategoryCodeTerminalParameters = 11,
    STNDataSetCategoryCodeVendorParameters = 12,

} STNDataSetCategoryCode;

typedef enum _STNPartyType {
    STNPartyTypeAcceptor,
    STNPartyTypeOriginatingPOI,
    STNPartyTypeMerchant,
    STNPartyTypeAcquirer,
    STNPartyTypeIntermediaryAgent,
    STNPartyTypeMasterTerminalManager,
    STNPartyTypeTerminalManager

} STNPartyType;

typedef enum _STNInitiatingPartyType {
    STNInitiatingPartyTypeInvalid,
    STNInitiatingPartyTypeOriginatingPOI,
    STNInitiatingPartyTypeMerchant,
    STNInitiatingPartyTypeAcceptor,
    STNInitiatingPartyTypeIntermediaryAgent,
    STNInitiatingPartyTypeAcquirer,
    STNInitiatingPartyTypeCard,
    STNInitiatingPartyTypeDelegate,

} STNInitiatingPartyType;

typedef enum _STNInitiatingPartyIssuer {
    STNInitiatingPartyIssuerInvalid,
    STNInitiatingPartyIssuerOriginatingPOI,
    STNInitiatingPartyIssuerMerchant,
    STNInitiatingPartyIssuerAcceptor,
    STNInitiatingPartyIssuerIntermediaryAgent,
    STNInitiatingPartyIssuerAcquirer,
    STNInitiatingPartyIssuerCard,
    STNInitiatingPartyIssuerDelegate,

} STNInitiatingPartyIssuer;

typedef enum _STNActionType {
    STNActionTypeBusy,
    STNActionTypeCaptureCard,
    STNActionTypeDisplayMessage,
    STNActionTypeForbidOverride,
    STNActionTypeIdentificationRequired,
    STNActionTypePINLastTry,
    STNActionTypePINRetry,
    STNActionTypePrintMessage,
    STNActionTypeReferral,
    STNActionTypeRequestData,

} STNActionType;

typedef enum _STNUserInterfaceCode {
    STNUserInterfaceCodeCardholderDisplay,
    STNUserInterfaceCodeCardholderReceipt,
    STNUserInterfaceCodeMerchantDisplay,
    STNUserInterfaceCodeMerchantReceipt,

} STNUserInterfaceCode;

typedef enum _STNResponseCode {
    STNResponseCodeDeclined,
    STNResponseCodeApproved,
    STNResponseCodePartialApproved,
    STNResponseCodeTechnicalError,

} STNResponseCode;

typedef enum _STNAmountType {
    STNAmountTypeCashback,
    STNAmountTypeGratuity,
    STNAmountTypeFees,
    STNAmountTypeRebates,
    STNAmountTypeValueAddedTax,

} STNAmountType;

typedef enum _STNTransactionStatus {
    STNTransactionStatusUnknown,
    STNTransactionStatusDeclined,
    STNTransactionStatusApproved,
    STNTransactionStatusPartialApproved,
    STNTransactionStatusTechnicalError,
    STNTransactionStatusCancelled,
    STNTransactionStatusInvalid,
    STNTransactionStatusTimeout,
    STNTransactionStatusFailed,
    STNTransactionStatusAborted,
    STNTransactionStatusDeclinedByCard

} STNTransactionStatus;

typedef enum _STNTransactionTypeSimplified {
    STNTransactionTypeSimplifiedCredit,
    STNTransactionTypeSimplifiedDebit

} STNTransactionTypeSimplified;

typedef enum _STNTransactionType {
    STNTransactionTypeCreditOnly = 1,
    STNTransactionTypeDebitOnly = 2,
    STNTransactionTypeCredit = 3,
    STNTransactionTypeDebit = 4,
    STNTransactionTypeUnknown = 99

} STNTransactionType;

typedef enum _STNTransactionInstalmentAmount {
    STNTransactionInstalmentAmountInvalid = 0,
    STNTransactionInstalmentAmountOne = 1,
    STNTransactionInstalmentAmountTwo = 2,
    STNTransactionInstalmentAmountThree = 3,
    STNTransactionInstalmentAmountFour = 4,
    STNTransactionInstalmentAmountFive = 5,
    STNTransactionInstalmentAmountSix = 6,
    STNTransactionInstalmentAmountSeven = 7,
    STNTransactionInstalmentAmountEight = 8,
    STNTransactionInstalmentAmountNine = 9,
    STNTransactionInstalmentAmountTen = 10,
    STNTransactionInstalmentAmountEleven = 11,
    STNTransactionInstalmentAmountTwelve = 12,

} STNTransactionInstalmentAmount;

typedef enum _STNTransactionCapture {
    STNTransactionCaptureYes,
    STNTransactionCaptureNo

} STNTransactionCapture;

typedef enum _STNTransactionEntryMode {
    STNTransactionEntryModeUnknown,
    STNTransactionEntryModeMagneticStripe,
    STNTransactionEntryModeChipNPin

} STNTransactionEntryMode;

typedef enum _STNCardBrand {
    STNCardBrandMasterCard,
    STNCardBrandVisa,
    STNCardBrandTicket,
    STNCardBrandVR,
    STNCardBrandElo,
    STNCardBrandSodexo,
    STNCardBrandAlelo,
    STNCardBrandUnknown,
    STNCardBrandHipercard,
    STNCardBrandHiper,
    STNCardBrandAmex

} STNCardBrand;

typedef enum STNTransactionMessage {
    STNTransactionMessageInvalid,
    STNTransactionMessageDeclined,
    STNTransactionMessageProcessing,
    STNTransactionMessageDeclinedCard,
    STNTransactionMessageDeclinedIssuer,
    STNTransactionMessageApproved,
    STNTransactionMessageCancelled,
    STNTransactionMessageTimeout,
    STNTransactionMessageFailed,
    STNTransactionMessageCardRemoved,
    STNTransactionMessageEMVCard,
    STNTransactionMessageInvalidCard,
    STNTransactionMessageIccProblem,
    STNTransactionMessageTableNotFound,
    STNTransactionMessageBlockedCard,

} STNTransactionMessage;

typedef enum STNCentralState {
    STNCentralStateUnknown,
    STNCentralStateOn,
    STNCentralStateOff

} STNCentralState;

typedef enum STNStreamReadingState {
    STNStreamReadingStateIdle,
    STNStreamReadingStateBytesAvailable,
    STNStreamReadingStateBusy
} STNStreamReadingState;


typedef enum STNResponseCommandStatus {
    STNResponseCommandSuccess = 0,

    STNErrorNoSecureCommunication = 3,
    STNPressFunction1 = 4,
    STNPressFunction2 = 5,
    STNPressFunction3 = 6,
    STNPressFunction4 = 7,
    STNPressBackspace = 8,

    /**
    * Decoding error data received by secure communicate
    * @enum: STNErrorDecodingData
    **/
    STNErrorDecodingData = 9,

    STNInvalidFunctionOrUnknownCommand = 10,
    STNErrorInvalidParameters = 11,

    STNErrorTimeOut = 12,
    STNErrorOperationCancelledByUser = 13,

    STNErrorOPNNotCalled = 15,
    STNErrorParametersNotSendBySPE = 19,

    STNErrorTableVersion = 20,

    STNInternalErrorPinpad = 40,
    STNErrorMagStripRead = 41,

    STNErrorMkDukptNotFound = 42,
    STNErrorNoICCOrCTLS = 43,

    /**
     * Pinpad can`t capture more transactions for security reasons.
     * @enum: STNErrorPinpadBusy
     * @example: When the capture limit is reached after a specific time interval
     **/
    STNErrorPinpadBusy = 44,
    STNErrorResponseDataBiggerThanLimit = 45,


    STNErrorCommunicationOrNoSam = 51,
    STNErrorIccNotFound = 60,
    STNErrorCommunicationIccOrCtlsError = 61,

    STNErrorCardInvalidated = 67,
    STNErrorIccWithProblem = 68,
    STNErrorIccWithInvalidData = 69,
    STNErrorIccEmvWithNoAvailableApplication = 70,

    /**
     * FallBack error
     * @enum: STNErrorIccToMag
     * @example: When an error occurs with icc for three times and needs to swipe the magnetic stripe.
     **/
    STNErrorIccToMag = 76,
    STNErrorMultipleCtlsConnected = 80,
    STNErrorCtlsCommunication = 81,
    STNErrorInvalidCtls = 82,

    /**
     * When many errors occurs in CTLS processing
     * @enum: STNErrorCtlsProblems
     * @example: When the CTLS doesn`t behaves as expected the transaction needs to be cancelled
     */
    STNErrorCtlsProblems = 83,
    STNErrorCtlsWithApplicationCondiction = 84,
    STNErrorCtlsApplicationShouldNotUsed = 85,
    STNErrorMultimediaFileUnexistent = 100,
    STNErrorMultimediaInvalidFormat = 101,
    STNErrorMultimediaFileDataLoad = 102,


} STNResponseCommandStatus;

typedef enum STNResponseCommandFncDecision {
    STNResponseCommandFncDecisionApproved,
    STNResponseCommandFncDecisionDeniedByCard,
    STNResponseCommandFncDecisionDeniedByNet,
    STNResponseCommandFncDecisionCommunicationError,


} STNResponseCommandFncDecision ;


typedef enum STNCardholderVerificationMethod {
    STNCardholderVerificationMethodFail = 0,
    STNCardholderVerificationMethodPlainPinByIcc = 1,
    STNCardholderVerificationMethodEncryptedPinOnline = 2,
    STNCardholderVerificationMethodPlainPinByIccPlusSignature = 3,
    STNCardholderVerificationMethodEncryptedPinByIcc = 4,
    STNCardholderVerificationMethodEncryptedPinByIccPlusSignature = 5,
    STNCardholderVerificationMethodSignature = 30,
    STNCardholderVerificationMethodNoCvmRequired = 31

} STNCardholderVerificationMethod;


typedef enum STNPdmError {
    STNPdmMerchantNotActivated,
    STNPdmVersionOutdated,
    STNPdmVersionVerificationAlreadyInCourse,

} STNPdmError;