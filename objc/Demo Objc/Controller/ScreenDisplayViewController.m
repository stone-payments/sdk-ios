//
//  ScreenDisplayViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 13/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ScreenDisplayViewController.h"
#import "NSString+Utils.h"

@interface ScreenDisplayViewController ()
@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation ScreenDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = [kTitleDisplay localize];
    self.instructionLabel.text = [kInstructionDisplay localize];
    [self.sendButton setTitle:[kButtonSend localize] forState:UIControlStateNormal];
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)performSendMessage:(id)sender {
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    NSString *mensagem;
    mensagem = self.messageTextField.text;
    
    // Exibe a mensagem na tela do pinpad;
    [STNDisplayProvider displayMessage:mensagem withBlock:^(BOOL succeeded, NSError *error) {
        [self.overlayView removeFromSuperview];
        if (succeeded) {
            NSLog(@"%@", [kLogMessageSent localize]);
            self.feedback.text = [kLogMessageSent localize];
        } else {
            NSLog(@"%@", error.description);
            self.feedback.text = error.description;
        }
    }];
}

@end
