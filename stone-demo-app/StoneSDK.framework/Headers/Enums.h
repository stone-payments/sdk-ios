//
//  Enums.h
//  StoneSDK
//
//  Created by Stone  on 10/21/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Enums : NSObject

@end

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
    OneInstalment, //0
    
    // without interest first (merchant) // sem juros
    TwoInstalmetsNoInterest, //1
    ThreeInstalmetsNoInterest, //2
    FourInstalmetsNoInterest, // 3
    FiveInstalmetsNoInterest, // 4
    SixInstalmetsNoInterest, // 5
    SevenInstalmetsNoInterest, // 6
    EightInstalmetsNoInterest, // 7
    NineInstalmetsNoInterest, //8
    TenInstalmetsNoInterest, // 9
    ElevenInstalmetsNoInterest, //10
    TwelveInstalmetsNoInterest,//11
    
    // with interest after (issuer) // com juros
    TwoInstalmetsWithInterest, //12
    ThreeInstalmetsWithInterest, //13
    FourInstalmetsWithInterest, //14
    FiveInstalmetsWithInterest, //15
    SixInstalmetsWithInterest, //16
    SevenInstalmetsWithInterest, //17
    EightInstalmetsWithInterest, //18
    NineInstalmetsWithInterest, // 19
    TenInstalmetsWithInterest, // 20
    ElevenInstalmetsWithInterest, // 21
    TwelveInstalmetsWithInterest //22
} InstalmentTransaction;


