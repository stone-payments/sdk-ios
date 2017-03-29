//
//  ConnectPinpadViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 02/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ConnectPinpadViewController.h"

@interface ConnectPinpadViewController ()

@end

@implementation ConnectPinpadViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Sessão com Pinpad";
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    
    if ([STNValidationProvider validatePinpadConnection] == NO) {
        NSLog(@"Pinpad não conectado.");
        self.feedback.text = @"Desconectado";
    } else {
        NSLog(@"Pinpad conectado.");
        self.feedback.text = @"Conectado";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)performConnectPinpad:(id)sender {
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    NSLog(@"Efetuando conexão com pinpad.");
    
    // Efetua a conexão com o pinpad
    [STNPinPadConnectionProvider connectToPinpad:^(BOOL succeeded, NSError *error) {
        
        [self.overlayView removeFromSuperview];
        
        if (succeeded) {
            NSLog(@"Conectado com sucesso!");
            self.feedback.text = @"Conectado";
        } else {
            self.feedback.text = error.description;
            NSLog(@"%@", error.description);
        }
    }];
}

@end
