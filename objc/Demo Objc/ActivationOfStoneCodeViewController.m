//
//  ActivationOfStoneCodeViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 03/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ActivationOfStoneCodeViewController.h"

@interface ActivationOfStoneCodeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtStoneCode;
@property (weak, nonatomic) IBOutlet UILabel *feedback;


@end

@implementation ActivationOfStoneCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Ativar Stone Code";
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/*
    Veja aqui exemplo de desativação do Stone Code;
 */
- (IBAction)performDesactivation:(id)sender {
    NSString *stoneCode = self.txtStoneCode.text;
    NSLog(@"Desativando Stone Code.");
    @try {
        [STNStoneCodeActivationProvider deactivateMerchantWithStoneCode:stoneCode];
        self.feedback.text = @"Stone Code Desativado.";
        NSLog(@"Stone Code Desativado.");
    } @catch (NSError *error) {
        NSLog(@"%@", error.description);
        self.feedback.text = @"Ocorreu um erro.";
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
    NSLog(@"Ativando Stone Code.");

    // Ativando o Stone Code;
    [STNStoneCodeActivationProvider activateStoneCode:stoneCode withBlock:^(BOOL succeeded, NSError *error) {
        [self.overlayView removeFromSuperview];
        if (succeeded) {
            NSLog(@"Stone Code ativado com sucesso.");
            self.feedback.text = @"Stone Code Ativado";
        } else {
            NSLog(@"%@", error.description);
            self.feedback.text = error.description;
        }
    }];
}

@end
