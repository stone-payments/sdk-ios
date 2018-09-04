//
//  Enums.h
//  StoneSDK
//
//  Created by Stone  on 10/21/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MailTemplate
{
    DEFAULT,
    TRANSACTION,
    VOID_TRANSACTION
} MailTemplate;

typedef enum AccountType
{
    Default,
    Savings,
    Checking,
    CreditCard,
    Universal,
    Investment,
    EpurseCard,
    Cancellation,
    Listing
} AccountType;

typedef enum TransactionTypeSimplified
{
    TransactionCredit,
    TransactionDebit
} TransactionTypeSimplified;

typedef enum TransactionType
{
    CREDIT_ONLY = 1,
    DEBIT_ONLY = 2,
    CREDIT = 3,
    DEBIT = 4,
    UNKNOWN = 99
} TransactionType;

typedef enum InstalmentType
{
    INST_None,
    INST_MerchantInstalment,
    INST_Issuer
} InstalmentType;

typedef enum TransactionStatus
{
    TransactionDeclined,
    TransactionApproved,
    TransactionAutoCancel,
    TransactionTimeout,
    TransactionFailed,
    TransactionAborted
} TransactionStatus;

typedef enum InstalmentTransaction
{
    OneInstalment,
    
    // without interest first (merchant)
    TwoInstalmetsNoInterest,
    ThreeInstalmetsNoInterest,
    FourInstalmetsNoInterest,
    FiveInstalmetsNoInterest,
    SixInstalmetsNoInterest,
    SevenInstalmetsNoInterest,
    EightInstalmetsNoInterest,
    NineInstalmetsNoInterest,
    TenInstalmetsNoInterest,
    ElevenInstalmetsNoInterest,
    TwelveInstalmetsNoInterest,
    
    // with interest after (issuer)
    TwoInstalmetsWithInterest,
    ThreeInstalmetsWithInterest,
    FourInstalmetsWithInterest,
    FiveInstalmetsWithInterest,
    SixInstalmetsWithInterest,
    SevenInstalmetsWithInterest,
    EightInstalmetsWithInterest,
    NineInstalmetsWithInterest,
    TenInstalmetsWithInterest,
    ElevenInstalmetsWithInterest,
    TwelveInstalmetsWithInterest
} InstalmentTransaction;


