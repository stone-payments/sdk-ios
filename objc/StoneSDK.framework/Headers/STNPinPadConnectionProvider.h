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
/// Get scanned pinpads.
- (void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didFindPinpad:(STNPinpad *)pinpad;
/// Tell if it started scanning successfully.
- (void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didStartScanning:(BOOL)success error:(NSError *_Nullable)error;
/// Give the pinpad object once it is connected.
- (void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didConnectPinpad:(STNPinpad *)pinpad error:(NSError *_Nullable)error;
/// Give the pinpad object once it is disconnected.
- (void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didDisconnectPinpad:(STNPinpad *)pinpad;
/// Get central state (CBManagerState) changes.
- (void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didChangeCentralState:(CBManagerState)state;
@end

@interface STNPinPadConnectionProvider : NSObject <STNBluetoothConnectionDelegate>

@property (nonatomic, weak) id <STNPinPadConnectionDelegate> _Nullable delegate;
/// Boolean value indicating if scan is currently in progress.
@property (nonatomic, assign, readonly) BOOL isScanning;
/// Current central state.
@property (nonatomic, assign, readonly) STNCentralState centralState;

/**
 Estabilishes session when connected to Pinpad. Use for single connection to non-BLE pinpads.

 @param block Callback with connection result. If connection is successfull, succeeded will be `YES` and error will be nil. If not, succeded will be `NO` and error will contain the error information.
 */
+ (void)connectToPinpad:(void (^_Nullable)(BOOL succeeded, NSError * _Nullable error))block;

/**
 List all connected pinpads (BLE or classic).

 @return An array of STNPinpad objects, containing the connected pinpads.
 */
- (NSArray <STNPinpad *> *)listConnectedPinpads;

/**
 Tell if a pinpad is already connected.

 @param pinpad The model representing the pinpad.
 @return `YES` if pinpad is connect, `NO` otherwise.
 */
- (BOOL)isPinpadConnected:(STNPinpad *)pinpad;

/**
 Connect to a Bluetooth Low Energy pinpad.

 @param pinpad The model representing the pinpad. You can get the pinpad instance by scanning for pinpads.
 */
- (void)connectToPinpad:( STNPinpad *)pinpad;

/**
 Disconnect from a connected Bluetooth Low Energy pinpad. Other kind of pinpad must be disconnected from the iOS Settings.

 @param pinpad The model representing the pinpad. You can get the pinpad instance by using `listConnectedPinpads`.
 @return `YES` if disconnection was successfull, `NO` if it was not connected at first place, or if pinpad is not Bluetooth Low Energy.
 */
- (BOOL)disconnectPinpad:(STNPinpad *)pinpad;

/**
 Select a already connected pinpad for use.

 @param pinpad The model representing the pinpad. You can get the pinpad instance by using `listConnectedPinpads`.
 @return `YES` if selection was successfull, `NO` if not.
 */
- (BOOL)selectPinpad:(STNPinpad *)pinpad;

/**
 List connected BLE pinpads that matches the given UUIDs identifiers.

 @param identifiers An array of NSString representing the UUIDs of the BLE pinpads.
 @return A list of connected STNPinpad with UUIDs matching the ones passed.
 */
- (NSArray <STNPinpad *> *)listPinpadsWithIdentifiers:(NSArray <NSString *> *)identifiers;

/**
 Get the currently selected pinpad.

 @return The STNPinpad object representing the currently selected pinpad.
 */
- (STNPinpad *_Nullable)selectedPinpad;

/**
 Start scanning for Bluetooth Low Energy pinpads.
 */
- (void)startScan;

/**
 Stop Bluetooth Low Energy pinpad scanning.
 */
- (void)stopScan;

/**
 Start the Bluetooth Low Energy central manager.
 */
- (void)startCentral;

@end

NS_ASSUME_NONNULL_END
