//
//  ActivationOfStoneCodeViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 03/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ActivationOfStoneCodeViewController.h"
#import "NSString+Utils.h"
#import "DemoPreferences.h"

@interface ActivationOfStoneCodeViewController ()

@property (strong, nonatomic) IBOutlet UILabel *informationLabel;
@property (strong, nonatomic) IBOutlet UIButton *activateButton;
@property (strong, nonatomic) IBOutlet UITextField *txtStoneCode;
@property (strong, nonatomic) IBOutlet UILabel *feedback;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
//List with all available environments
@property (strong, nonatomic) NSArray *environments;

@end

@implementation ActivationOfStoneCodeViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    // Setup UI components
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIButton actions

// Activate Stone Code
- (IBAction)performActivation:(id)sender {
    [_overlayView addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    [self.navigationController.view addSubview:_overlayView];
    
    // Get Stone Code from text field
    NSString *stoneCode = _txtStoneCode.text;
    NSLog(@"%@", [kLogActivating localize]);

    // Activate Stone Code
    [STNStoneCodeActivationProvider activateStoneCode:stoneCode withBlock:^(BOOL succeeded, NSError *error) {
        // Remove overlay
        [self.overlayView removeFromSuperview];
        // Check activation
        if (succeeded) {
            NSLog(@"%@", [kLogActivated localize]);
            // Refresh label data
            self.feedback.text = [kLogActivated localize];
        } else {
            NSLog(@"%@", error.description);
            // Refresh label data
            self.feedback.text = error.description;
        }
    }];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// Set number of rows based on the numbers of available environment
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return _environments.count;
}

// Set a title per environment from list
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    return _environments[row];
}

#pragma mark - UIPickerViewDelegate

// Select environment
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    STNEnvironment environment;
    switch (row) {
        case 0:
            environment = STNEnvironmentProduction;
            break;
        case 1:
            environment = STNEnvironmentInternalHomolog;
            break;
        case 2:
            environment = STNEnvironmentSandbox;
            break;
        case 3:
            environment = STNEnvironmentStaging;
            break;
        case 4:
            environment = STNEnvironmentCertification;
            break;
        default:
            environment = STNEnvironmentSandbox;
            break;
    }
    [DemoPreferences updateEnvironment:environment];
}

#pragma mark - UI Update

// Setup view
- (void)setupView {
    [super viewDidLoad];
    self.navigationItem.title = [kTitleActivation localize];
    _informationLabel.text = [kInstructionActivation localize];
    [_activateButton setTitle:[kButtonActivate localize]
                         forState:UIControlStateNormal];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                     initWithTarget:self.view
                                     action:@selector(endEditing:)]];
    
    _overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _overlayView.backgroundColor = [UIColor colorWithRed:0
                                                       green:0
                                                        blue:0
                                                       alpha:0.5];
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicator.center = _overlayView.center;
    
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    _environments = @[[kEnvironmentProduction localize],
                      [kEnvironmentInternalHomolog localize],
                      [kEnvironmentSandbox localize],
                      [kEnvironmentStaging localize],
                      [kEnvironmentCertification localize]];
    
    STNEnvironment env = [DemoPreferences lastSelectedEnvironment];
    
    [_pickerView selectRow:(int)env
                   inComponent:0
                      animated:NO];
}
@end
