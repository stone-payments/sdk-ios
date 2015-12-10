//
//  DownloadTablesProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/14/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootProvider.h"

@interface TableDownloaderProvider : RootProvider

/// Downloads AID and CAPK tables from server.
- (void)downLoadTables;

@end
