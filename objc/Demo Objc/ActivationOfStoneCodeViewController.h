//
//  ActivationOfStoneCodeViewController.h
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 03/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoneSDK/StoneSDK.h"

@interface ActivationOfStoneCodeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
