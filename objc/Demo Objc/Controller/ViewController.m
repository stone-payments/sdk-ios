//
//  ViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 23/02/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Utils.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *optionsList;

@end

@implementation ViewController

static NSString *cellIdentifier;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Stone Demo";
    
    self.optionsList = @[[kTitleSelection localize],
                         [kTitleBLE localize],
                         [kTitleActivation localize],
                         [kTitleTableDownload localize],
                         [kTitleUpdateTable localize],
                         [kTitleSendTransaction localize],
                         [kTitleTransactions localize],
                         [kTitleMerchants localize],
                         [kTitleRefundList localize],
                         [kTitleReceipt localize],
                         [kTitleValidation localize],
                         [kTitlePan localize],
                         [kTitleDisplay localize]];
    
    // Verificamos se já foi definido um Stone Code;
    if ([STNValidationProvider validateActivation] == NO) {
        NSLog(@"No stonecode was found.");
    } else {
        // Abre a sessão com o pinpad.
        [STNPinPadConnectionProvider connectToPinpad:^(BOOL succeeded, NSError *error) {
             if (succeeded) {
                 NSLog(@"%@", [kGeneralConnected localize]);
             } else {
                 NSLog(@"%@", [kGeneralNotConnected localize]);
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
    
    cellIdentifier = @"cell";
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
        case 0: { [self performSegueWithIdentifier:@"SelectPinpad" sender:nil]; break; }
        case 1: { [self performSegueWithIdentifier:@"ConnectBLE" sender:nil]; break; }
        case 2: { [self performSegueWithIdentifier:@"ActivationOfStoneCode" sender:nil]; break; }
        case 3: { [self performSegueWithIdentifier:@"DownloadTable" sender:nil]; break; }
        case 4: { [self performSegueWithIdentifier:@"RefreshTables" sender:nil]; break; }
        case 5: { [self performSegueWithIdentifier:@"PerformTransaction" sender:nil]; break; }
        case 6: { [self performSegueWithIdentifier:@"ListTransaction" sender:nil]; break; }
        case 7: { [self performSegueWithIdentifier:@"MerchantList" sender:nil]; break; }
        case 8: { [self performSegueWithIdentifier:@"CancelTransaction" sender:nil]; break; }
        case 9: { [self performSegueWithIdentifier:@"SendingVoucherEmail" sender:nil]; break; }
        case 10: { [self performSegueWithIdentifier:@"testValidation" sender:nil]; break; }
        case 11: { [self performSegueWithIdentifier:@"CapturePan" sender:nil]; break; }
        case 12: { [self performSegueWithIdentifier:@"ScreenDisplay" sender:nil]; break; }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
