//
//  TestValidationViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 10/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "TestValidationViewController.h"
#import "NSString+Utils.h"

@interface TestValidationViewController ()

@property (strong, nonatomic) IBOutlet UIButton *activationButton;
@property (strong, nonatomic) IBOutlet UIButton *pinpadConnectionButton;
@property (strong, nonatomic) IBOutlet UIButton *tableDownloadButton;
@property (strong, nonatomic) IBOutlet UIButton *internetConnectionButton;

@end

@implementation TestValidationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [kTitleValidation localize];
    [self.activationButton setTitle:[kButtonActivation localize] forState:UIControlStateNormal];
    [self.pinpadConnectionButton setTitle:[kButtonPinpadConnection localize] forState:UIControlStateNormal];
    [self.tableDownloadButton setTitle:[kButtonTableDownload localize] forState:UIControlStateNormal];
    [self.internetConnectionButton setTitle:[kButtonInternetConnection localize] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)performActivation:(id)sender {
    if ([STNValidationProvider validateActivation] == YES) {
        NSLog(@"%@", [kLogIsActivated localize]);
        self.feedback.text = [kLogIsActivated localize];
    } else {
        NSLog(@"%@", [kLogNotActivated localize]);
        self.feedback.text = [kLogNotActivated localize];
    }
}

- (IBAction)performPinpadConnection:(id)sender {
    if ([STNValidationProvider validatePinpadConnection] == YES) {
        NSLog(@"%@", [kLogPinpadConnected localize]);
        self.feedback.text = [kLogPinpadConnected localize];
    } else {
        NSLog(@"%@", [kLogPinpadNotConnected localize]);
        self.feedback.text = [kLogPinpadNotConnected localize];
    }
}

- (IBAction)PerfomTablesDownloaded:(id)sender {
    if ([STNValidationProvider validateTablesDownloaded] == YES) {
        NSLog(@"%@", [kLogTablesDownloaded localize]);
        self.feedback.text = [kLogTablesDownloaded localize];
    } else {
        NSLog(@"%@", [kLogTablesNotDownloaded localize]);
        self.feedback.text = [kLogTablesNotDownloaded localize];
    }
}

- (IBAction)performConnectionNetwork:(id)sender {
    if ([STNValidationProvider validateConnectionToNetWork] == YES) {
        NSLog(@"%@", [kLogInternetConnection localize]);
        self.feedback.text = [kLogInternetConnection localize];
    } else {
        NSLog(@"%@", [kLogNoInternetConnection localize]);
        self.feedback.text = [kLogNoInternetConnection localize];
    }
}

@end
