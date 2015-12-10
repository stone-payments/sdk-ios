//
//  EmailViewController.m
//  Stone Demo
//
//  Created by Erika Bueno on 11/30/15.
//  Copyright © 2015 Stone. All rights reserved.
//
//  Lista as transações já realizadas - canceladas ou não - e permite o envio do comprovante por e-mail.

#import "EmailViewController.h"

@interface EmailViewController ()

@property (nonatomic,strong) UIView *overlayView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation EmailViewController

static NSString *cell;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = NO;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stone.png"]];
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    cell = @"rowCell";
    [self.sendEmailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell];
    self.sendEmailTableView.scrollEnabled = YES;
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    STNTransactionInfoProvider *transactionInfoProvider = [self.transactions objectAtIndex:indexPath.row];
    
    UIAlertController *emailAlert = [UIAlertController
                                     alertControllerWithTitle:@"Envio de Comprovante"
                                     message:@"Digite o endereço de e-mail do destinatário:"
                                     preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                    {
                                        // Pega o e-mail do destinatário.
                                        NSString *emailAddress = ((UITextField *)[emailAlert.textFields objectAtIndex:0]).text;
                                        
                                        STNMailProvider *mailProvider = [[STNMailProvider alloc] init];
                                        
                                        if ([transactionInfoProvider.status isEqualToString:@ "Transação Cancelada"]) {
                                            
                                            [self.overlayView addSubview:self.activityIndicator];
                                            [self.activityIndicator startAnimating];
                                            [self.navigationController.view addSubview:self.overlayView];
                                            
                                            [mailProvider sendReceiptViaEmail:VOID_TRANSACTION transactionInfo:transactionInfoProvider toDestination:emailAddress
                                                    displayCompanyInformation:YES
                                                                    withBlock:^(BOOL succeeded, NSError *error)
                                             {
                                                 [self.overlayView removeFromSuperview];
                                                 if (succeeded)
                                                 {
                                                     [self emailSent];
                                                 } else
                                                 {
                                                     NSLog(@"%@", error.description);
                                                     [self showErrorMessage:[error localizedDescription]];
                                                 }
                                                 
                                             }];
                                            
                                        } else {
                                            
                                            [self.overlayView addSubview:self.activityIndicator];
                                            [self.activityIndicator startAnimating];
                                            [self.navigationController.view addSubview:self.overlayView];
                                            
                                            [mailProvider sendReceiptViaEmail:TRANSACTION transactionInfo:transactionInfoProvider toDestination:emailAddress
                                                    displayCompanyInformation:YES
                                                                    withBlock:^(BOOL succeeded, NSError *error)
                                             {
                                                 [self.overlayView removeFromSuperview];
                                                 if (succeeded)
                                                 {
                                                     [self emailSent];
                                                 } else
                                                 {
                                                     NSLog(@"%@", error.description);
                                                     [self showErrorMessage:[error localizedDescription]];
                                                 }
                                                 
                                             }];
                                        }
                                        
                                    }];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancelar"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                   {
                                       [emailAlert dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
    
    
    [emailAlert addAction:defaultAction];
    [emailAlert addAction:cancelButton];
    
    [emailAlert addTextFieldWithConfigurationHandler:^(UITextField *emailField)
     {
         emailField.placeholder = @"Digite o e-mail";
     }];
    
    [self presentViewController:emailAlert animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// Alerta de e-mail enviado.

- (void)emailSent {
    UIAlertController *cancelConfirmationAlert = [UIAlertController
                                                  alertControllerWithTitle:@"Comprovante enviado com sucesso!"
                                                  message:nil
                                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                               {
                                   [cancelConfirmationAlert dismissViewControllerAnimated:YES completion: nil];
                               }];
    
    [cancelConfirmationAlert addAction:okButton];
    
    [self presentViewController:cancelConfirmationAlert animated:YES completion:nil];
    
}

// Alerta de erro.

-(void)showErrorMessage: (NSString *) error
{
    
    UIAlertController *errorAlert = [UIAlertController
                                     alertControllerWithTitle:@"Erro"
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
