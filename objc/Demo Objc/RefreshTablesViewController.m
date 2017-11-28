//
//  RefreshTableViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 02/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "RefreshTablesViewController.h"
#import "NSString+Utils.h"

@interface RefreshTablesViewController ()

@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UILabel *feedback;


@end

@implementation RefreshTablesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [kTitleUpdateTable localize];
    [self.uploadButton setTitle:[kButtonUpload localize] forState:UIControlStateNormal];
    
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
            NSLog(@"%@", [kGeneralConnected localize]);
            
        } else {
            // Erro ao conectar com o pinpad;
            NSLog(@"%@. [%@]", [kGeneralErrorMessage localize], error.description);
            self.feedback.text = [kGeneralErrorMessage localize];
        }
    }];
    
    // Agora vamos fazer o carregamento das tabelas;
    [STNTableLoaderProvider loadTables:^(BOOL succeeded, NSError *error) {
        [self.overlayView removeFromSuperview];
        if (succeeded) {
            NSLog(@"%@", [kLogTablesUpdated localize]);
            self.feedback.text = [kLogTablesUpdated localize];
        } else {
            NSLog(@"%@", [kGeneralErrorMessage localize]);
            NSLog(@"%@", error.description);
            self.feedback.text = [kGeneralErrorMessage localize];
        }
    }];
}

@end
