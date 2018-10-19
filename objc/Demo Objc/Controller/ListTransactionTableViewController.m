//
//  ListTransactionTableViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 06/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ListTransactionTableViewController.h"
#import "NSString+Utils.h"


@interface ListTransactionTableViewController ()

@property (strong, nonatomic) IBOutlet UIButton *listButton;

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
    self.navigationItem.title = [kTitleTransactions localize];
    
    /*
        Requisição de listagem de transações;
     */
    self.transactions = [STNTransactionListProvider listTransactions];
    [self.listButton setTitle:[kButtonList localize] forState:UIControlStateNormal];
    [self.typeTransaction setTitle:[kGeneralAll localize] forSegmentAtIndex:0];
    [self.typeTransaction setTitle:[kGeneralByCard localize] forSegmentAtIndex:1];
    
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
        case 0: NSLog(@"%@", [kLogListAllTransactions localize]); break;
        case 1: NSLog(@"%@", [kLogListTransactionsByCard localize]); break;
    }
}

- (IBAction)listTransaction:(id)sender {
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    switch (self.typeTransaction.selectedSegmentIndex) {
        case 0:
            NSLog(@"%@",  [kLogListAllTransactions localize]);
            self.transactions = [STNTransactionListProvider listTransactions];
            [self.overlayView removeFromSuperview];
            [self.transactionTableView reloadData];
            break;
        case 1:
            NSLog(@"%@", [kLogListTransactionsByCard localize]);
            [STNTransactionListProvider listTransactionsByPan:^(BOOL succeeded, NSArray *transactionsList, NSError *error) {
                [self.overlayView removeFromSuperview];
                if (succeeded) {
                    self.transactions = transactionsList;
                    [self.transactionTableView reloadData];
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
    
    STNTransactionModel *transactionModel = [self.transactions objectAtIndex:indexPath.row];
    
    // Tratamento do amount somente para exibição.
    int centsValue = [transactionModel.amount intValue];
    float realValue = centsValue*0.01;
    NSString *amount = [NSString stringWithFormat:@"%.02f", realValue];
    cell.amountLabel.text = [NSString stringWithFormat:@"%@ %@", @"R$", amount];
    
    // Tratamento do status.
    NSString *shortStatus;
    if ([transactionModel.statusString isEqual: @"Transação Aprovada"]) {
        shortStatus = [kGeneralApproved localize];
    } else if ([transactionModel.statusString isEqual:@"Transação Cancelada"]) {
        shortStatus = [kGeneralCancelled localize];
    } else {
        shortStatus = transactionModel.statusString;
    }
    
    cell.statusLabel.text = shortStatus;
    cell.dateLabel.text = transactionModel.dateString;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    STNTransactionModel *transaction = [self.transactions objectAtIndex:indexPath.row];
    
    NSLog(@"date: %@",transaction.dateString);
    NSLog(@"Amount: %@",transaction.amount);
    NSLog(@"cvm: %@",transaction.cvm);
    NSLog(@"balance: %@",transaction.balance);
    NSLog(@"instalmentAmount: %u",transaction.instalmentAmount);
    NSLog(@"type: %u",transaction.type);
    NSLog(@"instalmentType: %u",transaction.instalmentType);
    NSLog(@"initiatorTransactionKey: %@",transaction.initiatorTransactionKey);
    NSLog(@"receiptTransactionKey: %@",transaction.receiptTransactionKey);
    NSLog(@"service Code: %@",transaction.serviceCode);
}

@end
