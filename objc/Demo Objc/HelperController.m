//
//  HelperController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 02/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "HelperController.h"

@implementation HelperController

- (void) getStoneCode {
    
    UIAlertController *stoneCodeAlert = [UIAlertController
                                         alertControllerWithTitle:@"Atenção!"
                                         message:@"Seu Stone Code não está ativado."
                                         preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *activateButton = [UIAlertAction actionWithTitle:@"Ativar"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action)
                                     {
                                         [self.overlayView addSubview:self.activityIndicator];
                                         [self.activityIndicator startAnimating];
                                         [self.navigationController.view addSubview:self.overlayView];
                                         
                                         NSString *stoneCode = ((UITextField *)[stoneCodeAlert.textFields objectAtIndex:0]).text;
                                         
                                         [STNStoneCodeActivationProvider activateStoneCode:stoneCode withBlock:^(BOOL succeeded, NSError * error){
                                             if (succeeded) {
                                                 [self.overlayView removeFromSuperview];
                                                 [self stoneCodeActivated];
                                             } else
                                             {
                                                 [self.overlayView removeFromSuperview];
                                                 [self showErrorMessage:[error localizedDescription]];
                                             }
                                         }];
                                     }];
    
    [stoneCodeAlert addAction:activateButton];
    [stoneCodeAlert addTextFieldWithConfigurationHandler:^(UITextField *stoneCodeField)
     {
         stoneCodeField.placeholder = @"Digite seu Stone Code";
     }];
    
    [self presentViewController:stoneCodeAlert animated:YES completion:nil];
    
}


@end
