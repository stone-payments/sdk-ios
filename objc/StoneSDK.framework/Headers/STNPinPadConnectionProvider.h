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
#import "STNBaseProvider.h"

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

@interface STNPinPadConnectionProvider : STNBaseProvider <STNBluetoothConnectionDelegate>

@property (nonatomic, weak) id <STNPinPadConnectionDelegate> _Nullable delegate;
/// Boolean value indicating if scan is currently in progress.
@property (nonatomic, assign, readonly) BOOL isScanning;
/// Current central state.
@property (nonatomic, assign, readonly) STNCentralState centralState;

/**
 Estabilishes session when connected to Pinpad. Use it for single connection to non-BLE pinpads.

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
- (void)connectToPinpad:( STNPinpad *)pinpad __deprecated_msg("use connectToPinpad: withBlock: instead.");

/**
 Connect to a Bluetooth Low Energy pinpad.
 
 @param pinpad The model representing the pinpad. You can get the pinpad instance by scanning for pinpads.
 @param block With parameters within: succeeded returning `YES` if device was able for connection or `NO` and a specific NSError for treatment
 */
- (void)connectToPinpad:( STNPinpad *)pinpad withBlock:(void (^)(BOOL succeeded, NSError *error))block;

/**
 Disconnect from a connected Bluetooth Low Energy pinpad. Other kind of pinpad must be disconnected from the iOS Settings.

 @param pinpad The model representing the pinpad. You can get the pinpad instance by using `listConnectedPinpads`.
 @return `YES` if disconnection was successfull, `NO` if it was not connected at first place, or if pinpad is not Bluetooth Low Energy.
 */
- (BOOL)disconnectPinpad:(STNPinpad *)pinpad;

/**
 Select an already connected pinpad for use.
 
 @param pinpad The model representing the pinpad. You can get the pinpad instance by using `listConnectedPinpads`.
 @return `YES` if selection was successfull, `NO` if not.
 */
- (BOOL)selectPinpad:(STNPinpad *)pinpad __deprecated_msg("use selectPinpad: withBlock: instead.");;

/**
 Select an already connected pinpad for use.
 
 @param pinpad The model representing the pinpad. You can get the pinpad instance by using `listConnectedPinpads`.
 @param block With parameters within: succeeded returning `YES` if device was able for selection or `NO` and a specific NSError for treatment
 */
- (void)selectPinpad:(STNPinpad *)pinpad withBlock:(void (^)(BOOL succeeded, NSError *error))block;

/**
 Check if pinpad device has a valid KEY.
 
 @return `YES` if a Stone key index was found 
 */
- (BOOL)isValid;
/**
 List connected BLE pinpads that matches the given UUIDs identifiers.

 @param identifiers An array of NSUUID representing the UUIDs of the BLE pinpads.
 @return A list of connected STNPinpad with UUIDs matching the ones passed.
 */
- (NSArray <STNPinpad *> *)listPinpadsWithIdentifiers:(NSArray <NSUUID *> *)identifiers;


/**
 Creates or get a pinpad instance that matches the provided identifier.

 @param identifier The UUID for BLE pinpad or the serial number for Classic Bluetooth pinpads.
 @return The STNPinpad object representing the pinpad with the provided identifier. If this identifier doesn't have a corresponding connected device, only the identifier property will be filled. This object can be used further for connection.
 */
- (STNPinpad *)pinpadWithIdentifier:(NSString*)identifier;

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
