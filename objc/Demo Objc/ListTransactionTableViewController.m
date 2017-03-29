//
//  ListTransactionTableViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 06/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ListTransactionTableViewController.h"


@interface ListTransactionTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *transactionTableView;
@property (strong, nonatomic) NSArray *transactions;
@property (strong, nonatomic) NSArray *data;

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeTransaction;
@property (weak, nonatomic) IBOutlet UITextField *numberCard;


@end

@implementation ListTransactionTableViewController

static NSString *cell;
static NSArray *exemploTransacao;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Lista de Transações";
    
    /*
        Requisição de listagem de transações;
     */
    self.transactions = [STNTransactionListProvider listTransactions];
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)changeTypeTransaction:(id)sender {
    switch (self.typeTransaction.selectedSegmentIndex) {
        case 0: NSLog(@"Listar todas as transações."); break;
        case 1: NSLog(@"Listar todas as transações de um cartão."); break;
    }
}

- (IBAction)listTransaction:(id)sender {
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    switch (self.typeTransaction.selectedSegmentIndex) {
        case 0:
            NSLog(@"Listar todas as transações.");
            self.transactions = [STNTransactionListProvider listTransactions];
            [self.overlayView removeFromSuperview];
            [self.transactionTableView reloadData];
            break;
        case 1:
            NSLog(@"Listar todas as transações de um cartão.");
            [STNTransactionListProvider listTransactionsByPan:^(BOOL succeeded, NSArray *transactionsList, NSError *error) {
                [self.overlayView removeFromSuperview];
                if (succeeded) {
                    self.transactions = transactionsList;
                    [self.transactionTableView reloadData];
                    NSLog(@"Atualizou a tabela");
                } else {
                    NSLog(@"%@", error.description);
                }
            }];
            break;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.transactions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier;
    
    cellIdentifier = @"TransCell";
    TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    STNTransactionModel *transactionInfoProvider = [self.transactions objectAtIndex:indexPath.row];
    
    // Tratamento do amount somente para exibição.
    int centsValue = [transactionInfoProvider.amount intValue];
    float realValue = centsValue*0.01;
    NSString *amount = [NSString stringWithFormat:@"%.02f", realValue];
    cell.amountLabel.text = [NSString stringWithFormat:@"%@ %@", @"R$", amount];
    
    // Tratamento do status.
    NSString *shortStatus;
    if ([transactionInfoProvider.statusString isEqual: @"Transação Aprovada"]) {
        shortStatus = @"Aprovada";
    } else if ([transactionInfoProvider.statusString isEqual:@"Transação Cancelada"]) {
        shortStatus = @"Cancelada";
    } else {
        shortStatus = transactionInfoProvider.statusString;
    }
    
    cell.statusLabel.text = shortStatus;
    cell.dateLabel.text = transactionInfoProvider.dateString;
    return cell;
}


@end
