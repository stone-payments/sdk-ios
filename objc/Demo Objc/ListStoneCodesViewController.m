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
@property (strong, nonatomic) NSArray *merchants;
@end

@implementation ListStoneCodesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.merchants = [STNMerchantListProvider listMerchants];
    [self.stoneCodesTableView reloadData];
    NSLog(@"Number of merchants: %d", (int)self.merchants.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
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

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.merchants count];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"did select");
    if (_merchants.count > indexPath.row) {
        STNMerchantModel *merchant = [_merchants objectAtIndex:indexPath.row];
        NSString *merchantText = [NSString stringWithFormat:@"%@ (%@)",merchant.stonecode, merchant.merchantName];
        NSLog(@"%@", merchantText);
    }
}

#pragma mark - UIButton
- (IBAction)deactivateStoneCode:(id)sender {
}

@end
