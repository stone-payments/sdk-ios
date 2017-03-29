//
//  DownloadTablesProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/14/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNTableDownloaderProvider : NSObject

/// Downloads AID and CAPK tables from server.
+ (void)downLoadTables:(void (^)(BOOL succeeded, NSError *error))block;

@end
