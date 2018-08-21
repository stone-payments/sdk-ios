//
//  CustomAlertController.m
//  Demo Objc
//
//  Created by Bruno Colombini | Stone on 21/08/18.
//  Copyright © 2018 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "CustomAlertViewController.h"

@implementation CustomAlertViewController

NSArray *merchantListProviders;

- (void)viewDidLoad {
    [super viewDidLoad];
    merchantListProviders = [STNMerchantListProvider listMerchants];
    [self setPreferredContentSize:CGSizeMake(250., 200.)];

    UIPickerView *pickerView = [[UIPickerView new] initWithFrame:CGRectMake(0, 0, 250., 200)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    NSLayoutConstraint *centreHorizontallyConstraint = [NSLayoutConstraint
                                                        constraintWithItem:pickerView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                        attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                        constant:0];
    [self.view addConstraint:centreHorizontallyConstraint];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [merchantListProviders count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    STNMerchantModel *merchantModel = merchantListProviders[row];
    return [merchantModel stonecode];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"Teste Selected");
}

@end


