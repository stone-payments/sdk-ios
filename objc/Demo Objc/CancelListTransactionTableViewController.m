//
//  CancelListTransactionTableViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 08/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "CancelListTransactionTableViewController.h"
#import "NSString+Utils.h"

@interface CancelListTransactionTableViewController ()

@end

@implementation CancelListTransactionTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = [kTitleRefundList localize];
    
    /*
        Requisição de listagem de transações;
     */
    self.transactions = [STNTransactionListProvider listTransactions];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.transactions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier;
    cellIdentifier = @"CancelCell";
    CancellationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"segueCancellationViewController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CancellationViewController *cancellationViewCotroller = [segue destinationViewController];
    cancellationViewCotroller.transaction = [self.transactions objectAtIndex:[self.tableView indexPathForSelectedRow].row];
}

@end
