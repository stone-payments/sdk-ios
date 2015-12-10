//
//  TransactionsViewController.m
//  Stone Demo
//
//  Created by Erika Bueno on 11/16/15.
//  Copyright © 2015 Stone. All rights reserved.
//
//  Somente lista as transações.
//  Se a opção escolhida for "Listar Transações por Cartão", o pinpad solicitará a inserção do cartão.
//

#import "TransactionsViewController.h"

@interface TransactionsViewController ()

@end

@implementation TransactionsViewController

    static NSString *cell;

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    cell = @"rowCell";
    [self.transactionstableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cell];
    self.transactionstableview.scrollEnabled = YES;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stone.png"]];
    
    STNDisplayProvider *displayProvider = [[STNDisplayProvider alloc] init];
    [displayProvider displayMessage:@"STONE           PAGAMENTOS"
                          withBlock:^(BOOL succeeded, NSError *error) {
                              if (succeeded)
                              {
                                  NSLog(@"Sucesso");
                              } else
                              {
                                  [self showErrorMessage:[error localizedDescription]];
                              }
                          }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.transactions count];
}



/*
    A classe STNTransactionInfoProvider tem os atributos: uniqueId, amount, status e date sendo que amount é em CENTAVOS. 
    Por esse motivo, é necessário tratar o dado antes de exibi-lo na tableview. Neste app demo, o status também foi tratado 
    para ser exibido de uma maneira mais compacta.
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:cell];
    return cells;
}



// Previne que haja delay no preenchimento do tableview que exibe as transações.

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Recebe o array das transações e exibe.
    STNTransactionInfoProvider *transactionInfoProvider = [self.transactions objectAtIndex:indexPath.row];
    
    // Tratamento do amount somente para exibição.
    int centsValue = [transactionInfoProvider.amount intValue];
    float realValue = centsValue*0.01;
    NSString *amount = [NSString stringWithFormat:@"%.02f", realValue];
    
    // Tratamento do status.
    NSString *shortStatus;
    if ([transactionInfoProvider.status isEqual: @"Transação Aprovada"])
    {
        shortStatus = @"Aprovada";
    } else if ([transactionInfoProvider.status isEqual:@"Transação Cancelada"])
    {
        shortStatus = @"Cancelada";
    }
    NSArray *transactionData = [[NSArray alloc] initWithObjects:transactionInfoProvider.date, @" - R$ ", amount, @" ", shortStatus, nil];
    NSString *final = [transactionData componentsJoinedByString:@""];
    
    cell.textLabel.text = final;
}


// Alerta de erro.

-(void)showErrorMessage: (NSString *) error
{
    
    UIAlertController *errorAlert = [UIAlertController
                                     alertControllerWithTitle:@"Erro!"
                                     message:error
                                     preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   [errorAlert dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [errorAlert addAction:okButton];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

@end