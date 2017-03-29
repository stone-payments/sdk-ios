//
//  SendingVoucherEmailViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 10/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "SendingVoucherEmailViewController.h"

@interface SendingVoucherEmailViewController ()

@end

@implementation SendingVoucherEmailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Enviar Comprovante";
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)performSendingEmail:(id)sender {
    
    
    NSArray *transactions = [STNTransactionListProvider listTransactions];
    
    if ([transactions count] > 0) {
        
        [self.overlayView addSubview:self.activityIndicator];
        [self.activityIndicator startAnimating];
        [self.navigationController.view addSubview:self.overlayView];
        
        // destinatario
        NSString *destination = self.emailTextField.text;
        
        // envia email com comprovante da última transação realizada
        [STNMailProvider sendReceiptViaEmail:STNMailTemplateTransaction transaction:transactions[0] toDestination:destination displayCompanyInformation:YES withBlock:^(BOOL succeeded, NSError *error) {
            [self.overlayView removeFromSuperview];
            if (succeeded) {
                NSLog(@"E-mail enviado com sucesso.");
                self.feedback.text = @"E-mail enviado com sucesso.";
            } else {
                NSLog(@"%@", error.description);
                self.feedback.text = error.description;
            }
        }];
    } else
    {
        self.feedback.text = @"Efetue ao menos uma transação.";
    }
    
    
    
    
}

@end
