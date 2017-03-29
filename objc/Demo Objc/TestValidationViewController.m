//
//  TestValidationViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 10/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "TestValidationViewController.h"

@interface TestValidationViewController ()

@end

@implementation TestValidationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Teste Validações";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)performActivation:(id)sender {
    if ([STNValidationProvider validateActivation] == YES) {
        NSLog(@"Stone Code está ativado!");
        self.feedback.text = @"Stone Code está ativado.";
    } else {
        NSLog(@"Stone Code não ativado.");
        self.feedback.text = @"Stone Code não ativado.";
    }
}

- (IBAction)performPinpadConnection:(id)sender {
    if ([STNValidationProvider validatePinpadConnection] == YES) {
        NSLog(@"O pinpad está pareado com o dispositivo iOS!");
        self.feedback.text = @"O pinpad está pareado com o dispositivo iOS!";
    } else {
        NSLog(@"O pinpad não pareado com o dispositivo iOS!");
        self.feedback.text = @"O pinpad não pareado com o dispositivo iOS!";
    }
}

- (IBAction)PerfomTablesDownloaded:(id)sender {
    if ([STNValidationProvider validateTablesDownloaded] == YES) {
        NSLog(@"As tabelas já foram baixadas para o dispositivo iOS!");
        self.feedback.text = @"As tabelas já foram baixadas para o dispositivo iOS!";
    } else {
        NSLog(@"As tabelas ainda não foram baixadas para o dispositivo iOS!");
        self.feedback.text = @"As tabelas ainda não foram baixadas para o dispositivo iOS!";
    }
}

- (IBAction)performConnectionNetwork:(id)sender {
    if ([STNValidationProvider validateConnectionToNetWork] == YES) {
        NSLog(@"A conexão com a internet está ativa!");
        self.feedback.text = @"A conexão com a internet está ativa!";
    } else {
        NSLog(@"A conexão com a internet está inativa!");
        self.feedback.text = @"A conexão com a internet está inativa!";
    }
}

@end
