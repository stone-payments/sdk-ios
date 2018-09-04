//
//  PosteriorCaptureViewController.m
//  Demo Objc
//
//  Created by Bruno Colombini | Stone on 04/09/18.
//  Copyright © 2018 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "PosteriorCaptureViewController.h"
#import "PosteriorCaptureCell.h"
#import "NSString+Utils.h"

@interface PosteriorCaptureViewController ()

@end

@implementation PosteriorCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [kTitlePosteriorCapture localize];
    [self getTransactionListCadidateToCaptureTransaction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.transactions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier;
    cellIdentifier = @"PosteriorCapture";
    PosteriorCaptureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    STNTransactionModel *transaction = [self.transactions objectAtIndex:indexPath.row];
    
    // Tratamento do amount somente para exibição.
    int centsValue = [transaction.amount intValue];
    float realValue = centsValue*0.01;
    NSString *amount = [NSString stringWithFormat:@"%.02f", realValue];
    cell.amountLabel.text = [NSString stringWithFormat:@"%@ %@", @"R$", amount];
    
    // Tratamento do status.
    NSString *shortStatus;
    if ([transaction.statusString isEqual: @"Transação Aprovada"]) {
        shortStatus = [kGeneralApproved localize];
    } else if ([transaction.statusString isEqual:@"Transação Cancelada"]) {
        shortStatus = [kGeneralCancelled localize];
    } else {
        shortStatus = transaction.statusString;
    }
    
    cell.statusLabel.text = shortStatus;
    cell.dateLabel.text = transaction.dateString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self posteriorCaputureConfirmationWith:self.transactions[indexPath.row]];
}

- (void) posteriorCaputureConfirmationWith:(STNTransactionModel *)transaction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Capture transaction" message:@"Do you sure which want do this?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Sure!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self getTransactionListCadidateToCaptureTransaction];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Puff, obvious not!" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) getTransactionListCadidateToCaptureTransaction{
    self.transactions = [STNTransactionListProvider listTransactions];
}

@end
