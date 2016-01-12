//
//  ViewController.m
//  Stone Demo
//
//  Created by Erika Bueno on 14/11/15.
//  Copyright © 2015 Stone. All rights reserved.
//
//  Define o menu inicial do app demo, realiza o download e também atualiza as tabelas.
//

/*
 
 [STNValidationProvider validateActivation]: verifica a ativação do Stone Code.
 [STNValidationProvider validatePinpadConnection]: verifica a conexão com o pinpad.
 
 IMPORTANTE: para que o alerta consiga direcionar o usuário às Configurações/Settings do iPhone, é necessário fazer a seguinte configuração:
 (1) Nas propriedades do projeto clique em Info.
 (2) No final da tela Info, em URL Types, clique em +.
 (3) Adicione uma entrada preenchendo somente os seguintes itens:
 - URL Schemes: prefs
 - Role: Editor
 
 */


#import "ViewController.h"
#import "TransactionsViewController.h"
#import "CancelTransactionsViewController.h"
#import "EmailViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) NSArray *transactionsList;
@property (nonatomic,strong) UIView *overlayView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

static NSString *cellIdentifier;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stone.png"]];
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    
    cellIdentifier = @"rowCell";
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.data = @[@"Realizar Transação", @"Listar Todas as Transações",
                  @"Listar Transações por Cartão", @"Cancelar Transação",
                  @"Enviar Comprovante por E-mail", @"Fazer Download das Tabelas",
                  @"Atualizar Tabelas"];
    self.mainTableView.scrollEnabled = NO;
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // Verificação inicial do Stone Code.
    if ([STNValidationProvider validateActivation] == NO)
    {
        [self checkStoneCode];
    } else
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
                 [self showErrorMessage:[error localizedDescription]];
             }
         }];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
            
        case 0:
        {
            NSLog(@"Realizar Transação");
            if ([STNValidationProvider validateActivation] == NO)
            {
                [self checkStoneCode];
                
            } else if ([STNValidationProvider validatePinpadConnection] == NO)
            {
                [self checkPinPad];
                
            } else
            {
                // Direciona à outra tela para a inserção dos dados da transação.
                [self performSegueWithIdentifier:@"PerformTransaction" sender:nil];
            }
        }
            break;
            
        case 1:
        {
            NSLog(@"Listar Todas as Transações");
            
            [self.overlayView addSubview:self.activityIndicator];
            [self.activityIndicator startAnimating];
            [self.navigationController.view addSubview:self.overlayView];
            
            // Gera um array (STNTransactionListProvider) com TODAS as transações efetuadas no dispositivo.
            // Ver TransactionsViewController.
            STNTransactionListProvider *transactionListProvider = [[STNTransactionListProvider alloc] init];
            self.transactionsList = [transactionListProvider listTransactions:^(BOOL succeeded, NSError *error)
                                     {
                                         if (succeeded)
                                         {
                                             [self.overlayView removeFromSuperview];
                                             NSLog(@"Sucesso");
                                         } else
                                         {
                                             [self.overlayView removeFromSuperview];
                                             [self showErrorMessage:[error localizedDescription]];
                                         }
                                     }];
            
            // Direciona à outra tela somente para a exibição de todas as transações.
            [self performSegueWithIdentifier:@"Transactions" sender:nil];
            
        }
            break;
            
        case 2:
        {
            NSLog(@"Listar Transações por Cartão");
            
            [self.overlayView addSubview:self.activityIndicator];
            [self.activityIndicator startAnimating];
            [self.navigationController.view addSubview:self.overlayView];
            
            if ([STNValidationProvider validatePinpadConnection] == NO)
            {
                [self checkPinPad];
                
            } else
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
                         [self.overlayView removeFromSuperview];
                         [self showErrorMessage:[error localizedDescription]];
                     }
                 }];
                
                // Gera um array (STNTransactionListProvider) com TODAS as transações efetuadas no dispositivo.
                // Ver TransactionsViewController.
                STNTransactionListProvider *transactionListProvider = [[STNTransactionListProvider alloc] init];
                self.transactionsList = [transactionListProvider listTransactionsByPan:^(BOOL succeeded, NSError *error)
                                         {
                                             if (succeeded)
                                             {
                                                 [self.overlayView removeFromSuperview];
                                                 NSLog(@"Sucesso");
                                             } else
                                             {
                                                 [self.overlayView removeFromSuperview];
                                                 [self showErrorMessage:[error localizedDescription]];
                                             }
                                         }];
                
                // Direciona à outra tela somente para a exibição de todas as transações.
                [self performSegueWithIdentifier:@"Transactions" sender:nil];
            }
        }
            break;
            
        case 3:
        {
            NSLog(@"Cancelar Transação");
            
            [self.overlayView addSubview:self.activityIndicator];
            [self.activityIndicator startAnimating];
            [self.navigationController.view addSubview:self.overlayView];
            
            if ([STNValidationProvider validatePinpadConnection] == NO)
            {
                [self checkPinPad];
                
            } else
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
                         [self.overlayView removeFromSuperview];
                         [self showErrorMessage:[error localizedDescription]];
                     }
                 }];
                
                
                // Gera um array (STNTransactionListProvider) com todas as transações efetuadas no dispositivo.
                // Ver CancelTransactionsViewController.
                STNTransactionListProvider *transactionListProvider = [[STNTransactionListProvider alloc] init];
                self.transactionsList = [transactionListProvider listTransactionsByPan:^(BOOL succeeded, NSError *error)
                                         {
                                             if (succeeded)
                                             {
                                                 [self.overlayView removeFromSuperview];
                                                 NSLog(@"Sucesso");
                                             } else
                                             {
                                                 [self.overlayView removeFromSuperview];
                                                 [self showErrorMessage:[error localizedDescription]];
                                             }
                                         }];
                
                // Direciona à outra tela para a exibição das transações por cartão dando a opção de cancelar.
                [self performSegueWithIdentifier:@"CancelTransactions" sender:nil];
            }
        }
            break;
            
        case 4:
        {
            NSLog(@"Enviar Comprovante por E-mail");
            
            [self.overlayView addSubview:self.activityIndicator];
            [self.activityIndicator startAnimating];
            [self.navigationController.view addSubview:self.overlayView];
            
            // Gera um array (STNTransactionListProvider) com TODAS as transações efetuadas no dispositivo.
            // Ver TransactionsViewController.
            STNTransactionListProvider *transactionListProvider = [[STNTransactionListProvider alloc] init];
            self.transactionsList = [transactionListProvider listTransactions:^(BOOL succeeded, NSError *error)
                                     {
                                         if (succeeded)
                                         {
                                             [self.overlayView removeFromSuperview];
                                             NSLog(@"Sucesso");
                                         } else
                                         {
                                             [self.overlayView removeFromSuperview];
                                             [self showErrorMessage:[error localizedDescription]];
                                         }
                                     }];
            
            // Direciona à tela para exibição das transações por cartão dando a opção de enviar o comprovante.
            [self performSegueWithIdentifier:@"SendEmail" sender:nil];
        }
            break;
            
        case 5:
        {
            NSLog(@"Fazer Download das Tabelas");
            
            [self.overlayView addSubview:self.activityIndicator];
            [self.activityIndicator startAnimating];
            [self.navigationController.view addSubview:self.overlayView];
            
            // Efetua o download das tabelas.
            STNTableDownloaderProvider *tableDownloaderProvider = [[STNTableDownloaderProvider alloc] init];
            [tableDownloaderProvider downLoadTables:^(BOOL succeeded, NSError *error)
             {
                 if (succeeded)
                 {
                     [self loadingTables];
                     
                 } else
                 {
                     [self.overlayView removeFromSuperview];
                     [self showErrorMessage:[error localizedDescription]];
                 }
             }];
        }
            break;
            
        case 6:
        {
            NSLog(@"Atualizar Tabelas");
            
            [self.overlayView addSubview:self.activityIndicator];
            [self.activityIndicator startAnimating];
            [self.navigationController.view addSubview:self.overlayView];
            
            if ([STNValidationProvider validatePinpadConnection] == NO)
            {
                [self checkPinPad];
                
            } else
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
                         [self.overlayView removeFromSuperview];
                         [self showErrorMessage:[error localizedDescription]];
                     }
                 }];
                
                
                // Atualiza as tabelas do pinpad. É necessário baixar as tabelas primeiro!
                STNTableLoaderProvider *tableLoaderProvider = [[STNTableLoaderProvider alloc] init];
                [tableLoaderProvider loadTables:^(BOOL succeeded, NSError *error)
                 {
                     if (succeeded)
                     {
                         [self updatedTables];
                         
                     } else
                     {
                         [self.overlayView removeFromSuperview];
                         [self showErrorMessage:[error localizedDescription]];
                     }
                 }];
                
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
        }
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    return cell;
}

// Verifica o usuário ativou o Stone Code.

- (void)checkStoneCode {
    
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
                                         STNStoneCodeActivationProvider *stoneCodeActivationProvider = [[STNStoneCodeActivationProvider alloc] init];
                                         [stoneCodeActivationProvider activateStoneCode:stoneCode
                                                                              withBlock:^(BOOL succeeded, NSError *error)
                                          {
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

// Informa que o Stone Code foi ativado com sucesso.

-(void)stoneCodeActivated
{
    [self.overlayView removeFromSuperview];
    
    UIAlertController *stoneCodeActivatedAlert = [UIAlertController
                                             alertControllerWithTitle:@"Stone Code ativado com sucesso!"
                                             message:nil
                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   [stoneCodeActivatedAlert dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [stoneCodeActivatedAlert addAction:okButton];
    [self presentViewController:stoneCodeActivatedAlert animated:YES completion:nil];
}

// Verifica o bluetooth e o pinpad.

-(void)checkPinPad {
    
    [self.overlayView removeFromSuperview];
    
    UIAlertController *pinpadAlert = [UIAlertController
                                      alertControllerWithTitle:@"Não foi possível detectar o pinpad!"
                                      message:@"Clique em Configurações para verificar se o Bluetooth está ativado e faça o pareamento com o pinpad."
                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *settingsButton = [UIAlertAction actionWithTitle:@"Configurações"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action)
                                     {
                                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Settings"]];
                                         [pinpadAlert dismissViewControllerAnimated:YES completion:nil];
                                     }];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancelar"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action)
                                   {
                                       [pinpadAlert dismissViewControllerAnimated:YES completion:nil];
                                   }];
    
    [pinpadAlert addAction:settingsButton];
    [pinpadAlert addAction:cancelButton];
    [self presentViewController:pinpadAlert animated:YES completion:nil];
    
}

// Informa que o download das tabelas foi concluído.

-(void)loadingTables
{
    
    UIAlertController *loadTablesAlert = [UIAlertController
                                          alertControllerWithTitle:@"Download das tabelas concluído com sucesso!"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   [self.overlayView removeFromSuperview];
                                   [loadTablesAlert dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [loadTablesAlert addAction:okButton];
    [self presentViewController:loadTablesAlert animated:YES completion:nil];
}

//    Informa que as tabelas foram atualizadas.

-(void)updatedTables
{
    [self.overlayView removeFromSuperview];
    
    UIAlertController *updatedTablesAlert = [UIAlertController
                                             alertControllerWithTitle:@"Tabelas atualizadas com sucesso!"
                                             message:nil
                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   [updatedTablesAlert dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [updatedTablesAlert addAction:okButton];
    [self presentViewController:updatedTablesAlert animated:YES completion:nil];
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

// Prepara os dados sobre as transações para serem exibidos na próxima tela.

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"Transactions"])
    {
        TransactionsViewController * destination = segue.destinationViewController;
        destination.transactions = self.transactionsList;
        
    } else if ([segue.identifier isEqualToString:@"CancelTransactions"])
    {
        CancelTransactionsViewController * destination = segue.destinationViewController;
        destination.transactions = self.transactionsList;
        
    } else if ([segue.identifier isEqualToString:@"SendEmail"])
    {
        EmailViewController * destination = segue.destinationViewController;
        destination.transactions = self.transactionsList;
        
    }
    
}

@end