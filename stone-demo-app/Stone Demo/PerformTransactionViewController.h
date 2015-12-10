//
//  PerformTransactionViewController.h
//  Stone Demo
//
//  Created by Erika Bueno on 11/16/15.
//  Copyright © 2015 Stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoneSDK/StoneSDK.h"

@interface PerformTransactionViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

-(void)showErrorMessage: (NSString*) error;

@property (strong, nonatomic) NSArray *pickerMenu;
@property (weak, nonatomic) NSString *instalmentString;
@property (weak, nonatomic) IBOutlet UIPickerView *instalmentPicker;

@end