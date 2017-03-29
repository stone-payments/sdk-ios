//
//  CancellationViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 10/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "CancellationViewController.h"

@interface CancellationViewController ()

@end

@implementation CancellationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Cancelar Transação";
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;

    
    // Tratamento do amount
    int centsValue = [self.transaction.amount intValue];
    float realValue = centsValue*0.01;
    NSString *amount = [NSString stringWithFormat:@"%.02f", realValue];
    self.amountLabel.text = [NSString stringWithFormat:@"%@ %@", @"R$", amount];
    
    // Tratamento do status;
    NSString *shortStatus;
    if ([self.transaction.statusString isEqual: @"Transação Aprovada"]) {
        shortStatus = @"Aprovada";
    } else if ([self.transaction.statusString isEqual:@"Transação Cancelada"]) {
        shortStatus = @"Cancelada";
    } else {
        shortStatus = self.transaction.statusString;
    }
    self.statusLabel.text = shortStatus;
    
    // Tratamento do date
    self.dateLabel.text = self.transaction.dateString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performCencellation:(id)sender {
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    [STNCancellationProvider cancelTransaction:self.transaction withBlock:^(BOOL succeeded, NSError *error) {
        [self.overlayView removeFromSuperview];
        if (succeeded) {
            NSLog(@"Transação cancelada.");
            self.feedback.text = @"Transação cancelada.";
        } else {
            NSLog(@"%@", error.description);
            self.feedback.text = error.description;
        }
    }];
    
    
}

@end
