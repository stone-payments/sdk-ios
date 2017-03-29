//
//  ListMerchantViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 08/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ListMerchantViewController.h"

@interface ListMerchantViewController ()

@property (weak, nonatomic) IBOutlet UITableView *merchantTableView;
@property (strong, nonatomic) NSArray *merchants;

@end

@implementation ListMerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Lista de Lojistas";
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)performListMerchant:(id)sender {
    
    /*
        Abaixo o exemplo de carregamento de lojistas
     */
    self.merchants = [STNMerchantListProvider listMerchants];
    [self.merchantTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.merchants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier;
    cellIdentifier = @"MerchantCell";
    MerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    STNMerchantModel *merchant = [self.merchants objectAtIndex:indexPath.row];
    cell.nameLabel.text = merchant.merchantName;
    cell.documentLabel.text = merchant.documentNumber;
    cell.affiliationLabel.text = merchant.saleAffiliationKey;
    return cell;
}


@end
