//
//  STNCardProvider.h
//  StoneSDK
//
//  Created by Jaison Vieira on 1/22/16.
//  Copyright © 2016 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNCardProvider : NSObject

/// Asks user to insert card and gets its last 4 digits
+ (void)getCardPan:(void (^)(BOOL succeeded, NSString *pan, NSError *error))block;

@end
