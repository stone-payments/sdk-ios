//
//  CancelTransactionsViewController.m
//  Stone Demo
//
//  Created by Erika Bueno on 11/23/15.
//  Copyright © 2015 Stone. All rights reserved.
//
//  Exibe as transações e permite o cancelamento somente das que ainda não foram canceladas.
//  O pinpad solicitará a inserção do cartão.
//

#import "CancelTransactionsViewController.h"

@interface CancelTransactionsViewController ()

@property (nonatomic,strong) UIView *overlayView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation CancelTransactionsViewController

static NSString *cell;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = NO;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stone.png"]];
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    cell = @"rowCell";
    [self.canceltransactionstableview registerClass:[UITableViewCell class] forCellReuseIdentifier:cell];
    self.canceltransactionstableview.scrollEnabled = YES;
    
    STNDisplayProvider *displayProvider = [[STNDisplayProvider alloc] init];
    [displayProvider displayMessage:@"STONE           PAGAMENTOS" withBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSLog(@"Sucesso");
        } else
        {
            [self showErrorMessage:[error localizedDescription]];
        }
    }];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // Abre a sessão com o pinpad.
    STNPinPadConnectionProvider *pinpadConnection = [[STNPinPadConnectionProvider alloc] init];
    [pinpadConnection connectToPinpad:^(BOOL succeeded, NSError *error) {
        if (succeeded == NO) {
            NSLog(@"%@", error.description);
        }
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.transactions count];
}



/*
 A classe TransactionsInfo tem os atributos: uniqueId, amount, status e date
 sendo que amount é em CENTAVOS. Por esse motivo, é necessário tratar o dado
 antes de exibi-lo na tableview. Neste app demo, o status também foi tratado
 para ser exibido de uma maneira mais compacta.
 */



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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:cell];
    return cells;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Abre a sessão com o pinpad.
    STNPinPadConnectionProvider *pinPadConnectionProvider = [[STNPinPadConnectionProvider alloc] init];
    [pinPadConnectionProvider connectToPinpad:^(BOOL succeeded, NSError *error)
     {
         if (succeeded)
         {
             NSLog(@"Pinpad conectado.");
         } else
         {
             NSLog(@"%@", error.description);
         }
     }];
    
    // Pega as transações existentes para aquele cartão.
    STNTransactionInfoProvider *transactionInfoProvider = [self.transactions objectAtIndex:indexPath.row];
    
    // Cria o objeto do cancelamento.
    STNCancellationProvider *cancellationProvider = [[STNCancellationProvider alloc] init];
    
    if ([transactionInfoProvider.status isEqualToString:@"Transação Aprovada"]) {
        
        UIAlertController *cancelAlert = [UIAlertController
                                          alertControllerWithTitle:@"Atenção!"
                                          message:@"Deseja cancelar esta transação?"
                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"Sim"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                    {
                                        [self.overlayView addSubview:self.activityIndicator];
                                        [self.activityIndicator startAnimating];
                                        [self.navigationController.view addSubview:self.overlayView];
                                        
                                        // Efetua o cancelamento com as informações da transação selecionada.
                                        [cancellationProvider cancelTransaction:transactionInfoProvider
                                                                      withBlock:^(BOOL succeeded, NSError *error)
                                         {
                                             
                                             if (succeeded)
                                             {
                                                 [self.overlayView removeFromSuperview];
                                                 [self cancelConfirmation];
                                                 
                                             } else
                                             {
                                                 NSLog(@"%li", (long)error.code);
                                                 if (error.code == 4001)
                                                 {
                                                     [self.overlayView removeFromSuperview];
                                                     [cancelAlert dismissViewControllerAnimated:YES completion: nil];
                                                 }
                                             }
                                             
                                         }];
                                        
                                    }];
        
        UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"Não"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                   {
                                       [cancelAlert dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [cancelAlert addAction:yesButton];
        [cancelAlert addAction:noButton];
        
        [self presentViewController:cancelAlert animated:YES completion:nil];
        
    } else
    {
        
        UIAlertController *cancelAlert = [UIAlertController
                                          alertControllerWithTitle:@"Atenção!"
                                          message:@"Esta transação já foi cancelada."
                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                   {
                                       [cancelAlert dismissViewControllerAnimated:YES completion: nil];
                                   }];
        
        
        [cancelAlert addAction:okButton];
        
        [self presentViewController:cancelAlert animated:YES completion:nil];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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



// Alerta de confirmação do cancelamento.

- (void)cancelConfirmation
{
    
    UIAlertController *cancelConfirmationAlert = [UIAlertController
                                                  alertControllerWithTitle:@"Transação Cancelada"
                                                  message:nil
                                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                               {
                                   [self.overlayView removeFromSuperview];
                                   [self performSegueWithIdentifier:@"BackToMain" sender:nil];
                                   [cancelConfirmationAlert dismissViewControllerAnimated:YES completion: nil];
                               }];
    
    [cancelConfirmationAlert addAction:okButton];
    
    [self presentViewController:cancelConfirmationAlert animated:YES completion:nil];
    
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