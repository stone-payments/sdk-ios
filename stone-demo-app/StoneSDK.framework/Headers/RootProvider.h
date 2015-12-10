//
//  RootProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/14/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProviderDelegate;
//@protocol StoneNetworkDelegate;
//@protocol DownloadTablesDelegate;

@interface RootProvider : NSObject

@property (nonatomic, weak) id <ProviderDelegate> delegate;

@end


@protocol ProviderDelegate <NSObject>

@optional
/// Delegate executes this method in case of error.
- (void)onError:(NSError *)error;
/// Delegate executes this method when task is completed successfully.
- (void)onSuccess;
@end


//@protocol StoneNetworkDelegate <NSObject>
//
//@optional
///// Delegate executes this method in case of failure on connection to internet.
//- (void)onConnectionFailure;
//
//@end
//
//@protocol DownloadTablesDelegate <NSObject>
//
//@optional
///// Delegate executes this method in case of failure on connection to internet.
//- (void)onConnectionFailure;
//
//@end