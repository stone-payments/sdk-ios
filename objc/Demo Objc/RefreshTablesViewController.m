//
//  RefreshTableViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 02/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "RefreshTablesViewController.h"

@interface RefreshTablesViewController ()

@property (weak, nonatomic) IBOutlet UILabel *feedback;


@end

@implementation RefreshTablesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Carregamento das Tabelas";
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
    Efetuando o carregamento das tabelas para o pinpad.
    
 */
- (IBAction)performRefreshTable:(UIButton *)sender {
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    /* Antes de efetivar o carregamento das tabelas é necessário
     que seja efetivado a conexão com o pinpad. */
    
    [STNPinPadConnectionProvider connectToPinpad:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // Pinpad conectado com sucesso;
            NSLog(@"Pinpad conectado com sucesso.");
            
        } else {
            // Erro ao conectar com o pinpad;
            NSLog(@"Erro ao conectar com pinpad. [%@]", error.description);
            self.feedback.text = @"Erro ao conectar com pinpad";
        }
    }];
    
    // Agora vamos fazer o carregamento das tabelas;
    [STNTableLoaderProvider loadTables:^(BOOL succeeded, NSError *error) {
        [self.overlayView removeFromSuperview];
        if (succeeded) {
            NSLog(@"Tabelas atualizadas.");
            self.feedback.text = @"Tabelas atualizadas!";
        } else {
            NSLog(@"Ocorreu um erro.");
            NSLog(@"%@", error.description);
            self.feedback.text = @"Ocorreu um erro.";
        }
    }];
}

@end
