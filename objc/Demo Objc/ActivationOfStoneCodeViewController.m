//
//  ActivationOfStoneCodeViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 03/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ActivationOfStoneCodeViewController.h"
#import "NSString+Utils.h"

@interface ActivationOfStoneCodeViewController ()
{
    NSArray *environments;
}

@property (strong, nonatomic) IBOutlet UILabel *informationLabel;
@property (strong, nonatomic) IBOutlet UIButton *activateButton;
@property (strong, nonatomic) IBOutlet UIButton *deactivateButton;

@property (weak, nonatomic) IBOutlet UITextField *txtStoneCode;
@property (weak, nonatomic) IBOutlet UILabel *feedback;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation ActivationOfStoneCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [kTitleActivation localize];
    self.informationLabel.text = [kInstructionActivation localize];
    [self.activateButton setTitle:[kButtonActivate localize] forState:UIControlStateNormal];
    [self.deactivateButton setTitle:[kButtonDeactivate localize] forState:UIControlStateNormal];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;

    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    environments = @[[kEnvironmentProduction localize], [kEnvironmentInternalHomolog localize], [kEnvironmentSandbox localize], [kEnvironmentStaging localize], [kEnvironmentCertification localize]];
    
    [self.pickerView selectRow:[STNConfig environment] inComponent:0 animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/*
    Veja aqui exemplo de desativação do Stone Code;
 */
- (IBAction)performDesactivation:(id)sender {
    NSString *stoneCode = self.txtStoneCode.text;
    NSLog(@"%@", [kLogDeactivating localize]);
    @try {
        [STNStoneCodeActivationProvider deactivateMerchantWithStoneCode:stoneCode];
        self.feedback.text = [kLogDeactivated localize];
        NSLog(@"%@", [kLogDeactivated localize]);
    } @catch (NSError *error) {
        NSLog(@"%@", error.description);
        self.feedback.text =[kGeneralErrorMessage localize];
    }
}

/*
    Veja aqui o exemplo de ativação de Stone Code;
 */

- (IBAction)performActivation:(id)sender {
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    // Recebendo o Stone Code do textField;
    NSString *stoneCode = self.txtStoneCode.text;
    NSLog(@"%@", [kLogActivating localize]);

    // Ativando o Stone Code;
    [STNStoneCodeActivationProvider activateStoneCode:stoneCode withBlock:^(BOOL succeeded, NSError *error) {
        [self.overlayView removeFromSuperview];
        if (succeeded) {
            NSLog(@"%@", [kLogActivated localize]);
            self.feedback.text = [kLogActivated localize];
        } else {
            NSLog(@"%@", error.description);
            self.feedback.text = error.description;
        }
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return environments.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return environments[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (row) {
        case 0: [STNConfig setEnvironment:STNEnvironmentProduction]; break;
        case 1: [STNConfig setEnvironment:STNEnvironmentInternalHomolog]; break;
        case 2: [STNConfig setEnvironment:STNEnvironmentSandbox]; break;
        case 3: [STNConfig setEnvironment:STNEnvironmentStaging]; break;
        case 4: [STNConfig setEnvironment:STNEnvironmentCertification]; break;
            
        default:
            break;
    }
}

@end
