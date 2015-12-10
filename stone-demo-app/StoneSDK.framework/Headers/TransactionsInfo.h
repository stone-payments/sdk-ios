//
//  TransactionsInfo.h
//  StoneSDK
//
//  Created by Stone  on 9/3/15.
//  Copyright (c) 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionsInfo : NSObject
{
    int _uniqueId;
    NSString *_amount;
    NSString *_status;
    NSString *_date;
    
}

@property (nonatomic, assign) int uniqueId;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *date;

- (id)initWithUniqueId:(int)uniqueId amount:(NSString *)amount status:(NSString *)status date:(NSString *)date;

@end
