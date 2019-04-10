//
//  DisplayProvider.h
//  StoneSDK
//
//  Created by Stone  on 11/25/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STNBaseProvider.h"

@interface STNDisplayProvider : STNBaseProvider

/// Send message to the Pinpad's display.
+ (void)displayMessage:(NSString *)message withBlock:(void (^)(BOOL succeeded, NSError *error))block;

@end
