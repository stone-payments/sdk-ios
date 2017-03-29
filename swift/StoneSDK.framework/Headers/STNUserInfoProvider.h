//
//  STNUserInfoProvider.h
//  StoneSDK
//
//  Created by Jaison Vieira on 1/11/16.
//  Copyright © 2016 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNUserInfoProvider : NSObject

@property (nonatomic,strong) NSString *afKey;
@property (nonatomic,strong) NSString *documentNumber;
@property (nonatomic,strong) NSString *store;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *stonecode;

@end
