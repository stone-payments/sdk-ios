//
//  ConnectBLEViewController.h
//  Demo Objc
//
//  Created by Tatiana Magdalena on 24/10/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

@import UIKit;
@import StoneSDK;

@interface ConnectBLEViewController : UIViewController <STNPinPadConnectionDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;
@property (strong, nonatomic) IBOutlet UIButton *scanButton;
@property (strong, nonatomic) IBOutlet UIButton *disconnectButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *feedback;

@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

// Array with all Low Energy pinpad devices found
@property (strong, nonatomic) NSMutableArray <STNPinpad *> *peripherals;
// Pinpad Central Manager
@property (strong, nonatomic) STNPinPadConnectionProvider *connection;

@end
