//
//  PinPadConnectionProvider.h
//  StoneSDK
//
//  Created by Stone  on 10/2/15.
//  Copyright © 2015 Stone . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "STNBluetoothConnectionDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class STNPinPadConnectionProvider;

@protocol STNPinPadConnectionDelegate <NSObject>

@optional
- (void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didFindPinpad:(STNPinpad *)pinpad;
- (void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didStartScanning:(BOOL)success error:(NSError *_Nullable)error;
- (void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didConnectPinpad:(STNPinpad *)pinpad error:(NSError *_Nullable)error;
- (void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didDisconnectPinpad:(STNPinpad *)pinpad;
- (void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didChangeCentralState:(CBManagerState)state;

@end

@interface STNPinPadConnectionProvider : NSObject <STNBluetoothConnectionDelegate>

@property (nonatomic, weak) id <STNPinPadConnectionDelegate> _Nullable delegate;
@property (nonatomic, assign, readonly) BOOL isScanning;
@property (nonatomic, assign, readonly) STNCentralState centralState;

/// Estabilishes session when connected to Pinpad.
+ (void)connectToPinpad:(void (^_Nullable)(BOOL succeeded, NSError * _Nullable error))block;
- (NSArray <STNPinpad *> *)listConnectedPinpads;
- (BOOL)isPinpadConnected:(STNPinpad *)pinpad;
- (void)connectToPinpad:( STNPinpad *)pinpad;
- (BOOL)disconnectPinpad:(STNPinpad *)pinpad;
- (BOOL)selectPinpad:(STNPinpad *)pinpad;
- (NSArray <STNPinpad *> *)listPinpadsWithIdentifiers:(NSArray <NSString *> *)identifiers;
- (STNPinpad *_Nullable)selectedPinpad;
- (void)startScan;
- (void)stopScan;
- (void)startCentral;

@end

NS_ASSUME_NONNULL_END
