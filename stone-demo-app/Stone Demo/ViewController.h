//
//  ViewController.h
//  Stone Demo
//
//  Created by Erika Bueno on 14/11/15.
//  Copyright © 2015 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoneSDK/StoneSDK.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

-(void)showErrorMessage: (NSString*) error;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end