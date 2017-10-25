//
//  STNBluetoothConnectionProtocol.h
//  StoneSDK
//
//  Created by Jaison Vieira on 21/08/17.
//  Copyright © 2017 Stone. All rights reserved.
//

//#ifndef STNBluetoothConnectionProtocol_h
//#define STNBluetoothConnectionProtocol_h

#import "STNPinpad.h"
#import "STNEnums.h"

@protocol STNBluetoothConnectionDelegate <NSObject>

@optional
- (void)didFindPeripheral:(STNPinpad *)pinpad;
- (void)didStartScanning:(BOOL)success error:(NSError*)error;
- (void)didConnectPeripheral:(STNPinpad *)pinpad error:(NSError*)error;
- (void)didDisconnectPeripheral:(STNPinpad *)pinpad;
- (void)didChangeCentralState:(CBManagerState)state;

@end

//#endif /* STNBluetoothConnectionProtocol_h */
