//
//  CancelListTransactionTableViewController.h
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 08/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoneSDK/StoneSDK.h"
#import "CancellationCell.h"
#import "CancellationViewController.h"

@interface CancelListTransactionTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *transactions;

@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;


@end
