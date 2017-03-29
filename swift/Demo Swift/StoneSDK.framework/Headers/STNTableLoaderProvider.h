//
//  TableLoaderProvider.h
//  StoneSDK
//
//  Created by Stone  on 9/23/15.
//  Copyright (c) 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNTableLoaderProvider : NSObject

/// Loads AID and CAPK tables to the PinPad.
+ (void)loadTables:(void (^)(BOOL succeeded, NSError *error))block;

@end
