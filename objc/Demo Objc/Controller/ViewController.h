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

@property (strong, nonatomic) NSArray <STNPinpad*> *connectedPinpads;

@end

