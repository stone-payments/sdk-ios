//
//  STNLoggerProvider.h
//  StoneSDK
//
//  Created by Kennedy Noia | Stone on 07/06/2018.
//  Copyright © 2018 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNBaseProvider.h"

@interface STNLoggerProvider : NSObject

/// Get all accumulated printed messages
+ (NSString *)getLog;

@end
