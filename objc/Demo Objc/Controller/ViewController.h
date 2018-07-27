//
//  ViewController.h
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 23/02/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoneSDK/StoneSDK.h"

@interface ViewController : UITableViewController

//Array where you can found the connected devices with your iOS Device
@property (strong, nonatomic) NSArray <STNPinpad*> *connectedPinpads;

@property(nonatomic, strong) NSArray *optionsList;

@end

