//
//  ManageStoneCodesViewController.m
//  Demo Objc
//
//  Created by Kennedy Noia | Stone on 03/07/2018.
//  Copyright © 2018 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ManageStoneCodesViewController.h"
#import "DemoPreferences.h"
#import "NSString+Utils.h"
@import StoneSDK.STNMerchantModel;
@import StoneSDK.STNMerchantListProvider;
@import StoneSDK.STNStoneCodeActivationProvider;

@interface ManageStoneCodesViewController ()

@property(weak, nonatomic) IBOutlet UITableView *stoneCodesTableView;
@property(weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property(weak, nonatomic) IBOutlet UIButton *deactivateButton;
// Array with all activated merchants
@property(strong, nonatomic) NSArray <STNMerchantModel *> *merchants;

@end

@implementation ManageStoneCodesViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Refresh table view
    [self refreshStoneCodesTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Refresh table view
    [self refreshStoneCodesTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIButton actions

// Deactivate selected Stone Code
- (IBAction)deactivateStoneCode:(id)sender {
    // Get index from selected row
    NSIndexPath *selectedStoneCodeIndexPath = [_stoneCodesTableView indexPathForSelectedRow];
    if (selectedStoneCodeIndexPath) {
        // Get Merchant at the position of index path
        STNMerchantModel *selectedMerchant = [_merchants objectAtIndex:selectedStoneCodeIndexPath.row];
        @try {
            // Try to deactivate selected merchant
            [STNStoneCodeActivationProvider deactivateMerchant:selectedMerchant];
            // Refresh label data
            [self setFeedbackMessage:[kLogDeactivated localize]];
        } @catch (NSException *exception) {
            // Refresh label data
            [self setFeedbackMessage:@"Unable to deactivate the selected Stone Code"];
        } @finally {
            // Refresh table view
            [self refreshStoneCodesTableView];
        }
        if ([[STNMerchantListProvider listMerchants] count] == 0) {
            UIStoryboard *uiStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *viewController = [uiStoryboard instantiateViewControllerWithIdentifier:@"ActivateStoneCode"];
            [self presentViewController:viewController animated:YES completion:nil];
        }
    }
}

- (IBAction)deactivateAllStoneCode:(id)sender {
    // Get index from selected row
    @try {
        for (STNMerchantModel *merchantModel in _merchants) {
            [STNStoneCodeActivationProvider deactivateMerchant:merchantModel];
        }
        UIStoryboard *uiStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [uiStoryboard instantiateViewControllerWithIdentifier:@"ActivateStoneCode"];
        [self presentViewController:viewController animated:YES completion:nil];
    } @catch (NSException *exception) {
        // Refresh label data
        [self setFeedbackMessage:@"Error when deactivate some Stone code."];
    } @finally {
        // Refresh table view
        [self refreshStoneCodesTableView];
    }
}

#pragma mark - UITableViewDataSource

// Set a cell per merchant from list
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // Get reusable cell
    static NSString *cellIdentifier = @"StoneCodeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    if (_merchants.count > indexPath.row) {
        // Get merchant at the position of index path
        STNMerchantModel *merchant = [_merchants objectAtIndex:indexPath.row];
        // Format string with stone code and name
        NSString *merchantText = [NSString stringWithFormat:@"%@ (%@)", merchant.stonecode, merchant.merchantName];
        // Update label text of the cell
        [cell.textLabel setText:merchantText];
    }

    return cell;
}

// Set number of rows based on the numbers of activated merchants
- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.merchants count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableViewDelegate

// Select merchant from table view
- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_merchants.count > indexPath.row) {
        // Get merchant at the position of index path
        STNMerchantModel *merchant = [_merchants objectAtIndex:indexPath.row];
        // Format string with stone code and name
        NSString *merchantText = [NSString stringWithFormat:@"%@ (%@)", merchant.stonecode, merchant.merchantName];
        // Update last selected stone code to retrieve in future transactions attempts
        [DemoPreferences updateLastSelectedStoneCode:merchant.stonecode];
        // Set string to update feedback label
        NSString *labelString = [NSString stringWithFormat:@"Stone Code selected: %@", merchantText];
        [self setFeedbackMessage:labelString];
    }
}

#pragma mark - UI Update

// Update UI Element
- (void)setFeedbackMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.feedbackLabel.text = message;
    });
}

// Load merchants and reload table view
- (void)refreshStoneCodesTableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        // Get the list of all available merchants
        self.merchants = [STNMerchantListProvider listMerchants];
        // reload table view
        [self.stoneCodesTableView reloadData];

        // Retrieve the last selected stone code
        NSString *lastSelectedStoneCode = [DemoPreferences lastSelectedStoneCode];
        if (lastSelectedStoneCode) {
            for (int i = 0; i < [self.merchants count]; i++) {
                // Get merchant from selected stone code
                STNMerchantModel *merchant = [self.merchants objectAtIndex:i];
                if (merchant && [merchant.stonecode isEqualToString:lastSelectedStoneCode]) {
                    // Update selected row at table view
                    [self.stoneCodesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]
                                                          animated:YES
                                                    scrollPosition:UITableViewScrollPositionNone];
                }
            }
        }
    });
}
@end
