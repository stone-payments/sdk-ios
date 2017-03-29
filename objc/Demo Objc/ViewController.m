//
//  ViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 23/02/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *optionsList;

@end

@implementation ViewController

static NSString *cellIdentifier;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Stone Demo";
    
    self.optionsList = @[@"Estabelece Sessão Com Pinpad",
                         @"Ativação do Stone Code",
                         @"Download das Tabelas",
                         @"Carregamento das Tabelas",
                         @"Realizar Transação",
                         @"Listar Transações",
                         @"Listar Lojistas",
                         @"Cancelar Transações",
                         @"Envio de comprovante por email",
                         @"Testando Validações",
                         @"Captura de PAN",
                         @"Exibe Mensagem no Display"];
    
    
    // Verificamos se já foi definido um Stone Code;
    if ([STNValidationProvider validateActivation] == NO) {
        NSLog(@"Sem Stone Code Definido.");
    } else {
        // Abre a sessão com o pinpad.
        [STNPinPadConnectionProvider connectToPinpad:^(BOOL succeeded, NSError *error) {
             if (succeeded) {
                 NSLog(@"Pinpad conectado.");
             } else {
                 NSLog(@"Pinpad não conectado.");
             }
         }];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_optionsList count];
}



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier;
    UITableViewCell *cell;
    
    cellIdentifier = @"simpleTableCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [_optionsList objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: { [self performSegueWithIdentifier:@"ConnectPinpad" sender:nil]; break; }
        case 1: { [self performSegueWithIdentifier:@"ActivationOfStoneCode" sender:nil]; break; }
        case 2: { [self performSegueWithIdentifier:@"DownloadTable" sender:nil]; break; }
        case 3: { [self performSegueWithIdentifier:@"RefreshTables" sender:nil]; break; }
        case 4: { [self performSegueWithIdentifier:@"PerformTransaction" sender:nil]; break; }
        case 5: { [self performSegueWithIdentifier:@"ListTransaction" sender:nil]; break; }
        case 6: { [self performSegueWithIdentifier:@"MerchantList" sender:nil]; break; }
        case 7: { [self performSegueWithIdentifier:@"CancelTransaction" sender:nil]; break; }
        case 8: { [self performSegueWithIdentifier:@"SendingVoucherEmail" sender:nil]; break; }
        case 9: { [self performSegueWithIdentifier:@"testValidation" sender:nil]; break; }
        case 10: { [self performSegueWithIdentifier:@"CapturePan" sender:nil]; break; }
        case 11: { [self performSegueWithIdentifier:@"ScreenDisplay" sender:nil]; break; }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
