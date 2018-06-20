//
//  ListTransactionTableViewController.h
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 06/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoneSDK/StoneSDK.h"
#import "TransactionCell.h"

@interface ListTransactionTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
