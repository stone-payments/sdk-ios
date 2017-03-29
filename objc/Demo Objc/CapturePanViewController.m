//
//  CapturePanViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 13/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "CapturePanViewController.h"

@interface CapturePanViewController ()
@property (weak, nonatomic) IBOutlet UILabel *feedback;

@end

@implementation CapturePanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Captura de PAN";
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performCapture:(id)sender {
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    [STNCardProvider getCardPan:^(BOOL succeeded, NSString *pan, NSError *error) {
        [self.overlayView removeFromSuperview];
        // verifica se a requisição ocorreu com sucesso
        if (succeeded) {
            NSLog(@"**** **** **** %@", pan);
            self.feedback.text =  [NSString stringWithFormat:@"Os 4 ultimos digitos são: %@", pan];
        } else {
            NSLog(@"%@", error.description);
            self.feedback.text = error.description;
        }
    }];
}

@end
