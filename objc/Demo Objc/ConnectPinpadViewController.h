//
//  ConnectPinpadViewController.h
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 02/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoneSDK/StoneSDK.h"

@interface ConnectPinpadViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *feedback;
@property (weak, nonatomic) IBOutlet UIButton *btnConnect;

@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
