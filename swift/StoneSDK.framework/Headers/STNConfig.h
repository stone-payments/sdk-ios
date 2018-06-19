//
//  STNConfig.h
//  StoneSDK
//
//  Created by Jaison Vieira on 23/08/17.
//  Copyright © 2017 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNEnums.h"

@interface STNConfig : NSObject

@property (class, nonatomic, assign) STNAcquirer acquirer;
@property (class, nonatomic, assign) STNEnvironment environment;
@property (class, nonatomic, strong) NSDictionary *transactionMessages;

@property (class, nonatomic, readonly) NSString *stoneSdkVersion;

@end
