//
//  SendingVoucherEmailViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 10/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "SendingVoucherEmailViewController.h"
#import "TransactionCell.h"
#import "NSString+Utils.h"

@interface SendingVoucherEmailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UITableView *transactionsTableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray<STNTransactionModel*> *transactions;
@property (strong, nonatomic) STNTransactionModel *selectedTransaction;

@end

@implementation SendingVoucherEmailViewController

NSArray<STNTransactionModel*> *transactions;
STNTransactionModel *selectedTransaction;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.emailTextField setDelegate:self];
    [self setTexts];
    [self activityIndicatorConfig];
    
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    self.transactions = [STNTransactionListProvider listTransactions];
    if (self.transactions > 0) {
        self.selectedTransaction = self.transactions[0];
        [self.transactionsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setTexts {
    self.navigationItem.title = [kTitleReceipt localize];
    self.instructionLabel.text = [kInstructionDestinationEmail localize];
    [self.sendButton setTitle:[kButtonSend localize] forState:UIControlStateNormal];
    [self.segmentedControl setTitle:[kGeneralMerchant localize] forSegmentAtIndex:0];
    [self.segmentedControl setTitle:[kGeneralCustomer localize] forSegmentAtIndex:1];
}

- (void)activityIndicatorConfig {
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
}

-(void)showActivityIndicator {
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
}

-(void)hideActivityIndicator {
    [self.overlayView removeFromSuperview];
}

- (IBAction)performSendingEmail:(id)sender {
    
    if (self.selectedTransaction) {
        
        [self showActivityIndicator];
        
        // destinatario
        NSString *destination = self.emailTextField.text;
        
        // define o tipo da via
        STNReceiptType receiptType;
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            receiptType = STNReceiptTypeMerchant;
        }
        else {
            receiptType = STNReceiptTypeCustomer;
        }
        
        // DEPRECATED: envia email com comprovante da última transação realizada
//        [STNMailProvider sendReceiptViaEmail:STNMailTemplateTransaction transaction:self.selectedTransaction toDestination:destination displayCompanyInformation:YES withBlock:^(BOOL succeeded, NSError *error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self hideActivityIndicator];
//                if (succeeded) {
//                    NSLog(@"%@", [kLogEmailSuccess localize]);
//                    self.feedback.text = [kLogEmailSuccess localize];
//                } else {
//                    NSLog(@"%@", error.description);
//                    self.feedback.text = error.description;
//                }
//            });
//        }];
        
        // cria o modelo do recibo
        STNReceiptModel *receipt = [STNReceiptModel new];
        // define o tipo da via
        receipt.type = self.segmentedControl.selectedSegmentIndex == 0 ? STNReceiptTypeMerchant : STNReceiptTypeCustomer;
        // define a transação para enviar o recibo
        receipt.transaction = self.selectedTransaction;
        // define se o endereço será exibido no comprovante, caso seja via cliente
        receipt.displayCompanyInformation = YES;
        
        // cria o modelo de contato de quem envia (caso não seja passado, será definido como noreply@stone.com.br)
        STNContactModel *fromContact = [STNContactModel new];
        fromContact.name = @"teste";
//        fromContact.address = @"noreply@stone.com.br";
        
        // cria o modelo de contato a quem o recibo se destina
        STNContactModel *toContact = [STNContactModel new];
        toContact.address = destination;
        
        [STNMailProvider sendReceiptViaEmail:receipt from:fromContact to:toContact withBlock:^(BOOL succeeded, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideActivityIndicator];
                if (succeeded) {
                    NSLog(@"%@", [kLogEmailSuccess localize]);
                    self.feedback.text = [kLogEmailSuccess localize];
                } else {
                    NSLog(@"%@", error.description);
                    self.feedback.text = error.description;
                }
            });
        }];
    }
    else
    {
        self.feedback.text = [kLogNeedTransaction localize];
    }
}

#pragma mark - Table view

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionCell *cell = [_transactionsTableView dequeueReusableCellWithIdentifier:@"TransCell" forIndexPath:indexPath];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedTransaction = self.transactions[indexPath.row];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.emailTextField resignFirstResponder];
    return YES;
}
@end
