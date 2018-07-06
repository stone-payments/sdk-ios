//
//  ListStoneCodesViewController.m
//  Demo Objc
//
//  Created by Kennedy Noia | Stone on 03/07/2018.
//  Copyright © 2018 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ListStoneCodesViewController.h"
@import StoneSDK.STNMerchantListProvider;
@import StoneSDK.STNMerchantModel;

@interface ListStoneCodesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *stoneCodesTableView;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (weak, nonatomic) IBOutlet UIButton *deactivateButton;
// Array with all activated merchants
@property (strong, nonatomic) NSArray *merchants;

@end

@implementation ListStoneCodesViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Update activated merchants
    self.merchants = [STNMerchantListProvider listMerchants];
    [self.stoneCodesTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

// Set a cell for merchant from list
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"StoneCodeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (_merchants.count > indexPath.row) {
        STNMerchantModel *merchant = [_merchants objectAtIndex:indexPath.row];
        NSString *merchantText = [NSString stringWithFormat:@"%@ (%@)",merchant.stonecode, merchant.merchantName];
        [cell.textLabel setText:merchantText];
    }
    
    return cell;
}

// Set number of rows based on the numbers of activated merchants
- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.merchants count];
}

#pragma mark - UITableViewDelegate

// Select merchant from table view
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_merchants.count > indexPath.row) {
        STNMerchantModel *merchant = [_merchants objectAtIndex:indexPath.row];
        NSString *merchantText = [NSString stringWithFormat:@"%@ (%@)",merchant.stonecode, merchant.merchantName];
        NSLog(@"%@", merchantText);
    }
}

#pragma mark - UIButton

// Deactivate selected Stone Code
- (IBAction)deactivateStoneCode:(id)sender {
}

@end
