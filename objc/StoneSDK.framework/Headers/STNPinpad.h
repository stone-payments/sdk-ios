//
//  STNPinpadProvider.h
//  StoneSDK
//
//  Created by Jaison Vieira on 25/08/17.
//  Copyright © 2017 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNPinpad : NSObject

/// Device name.
@property (nonatomic, readonly, strong) NSString *name;
/// the UUID for BLE devices or serial number for classic devices.
@property (nonatomic, readonly, strong) NSString *identifier;
/// Custom name.
@property (nonatomic, strong) NSString *alias;

/// A CBPeripheral if device is Bluetooth Low Energy, or an EAAccessory otherwise.
@property (nonatomic, readonly, retain) id device;

/// Initialize with a CBPeripheral or EAAccessory object.
-(instancetype)initWithDevice:(id)device;

/// Initialize with an identifier. All other properties are initialized with nil value.
-(instancetype)initWithIdentifier:(NSString*)identifier;

@end
