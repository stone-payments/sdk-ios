//
//  PrototipalProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/9/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootProvider.h"

@interface PrototipalProvider : RootProvider

- (void)testConnection;
- (void)updateTables:(NSError **)error;

@end
