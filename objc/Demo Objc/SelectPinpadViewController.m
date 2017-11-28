//
//  ConnectPinpadViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 02/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "SelectPinpadViewController.h"
#import "NSString+Utils.h"

@interface SelectPinpadViewController ()

@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SelectPinpadViewController

NSArray <STNPinpad*> *connectedPinpads;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = [kTitleSelection localize];
    self.instructionLabel.text = [kInstructionSelection localize];
    [self.refreshButton setTitle:[kButtonRefresh localize] forState:UIControlStateNormal];
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    [self.tableView setAllowsMultipleSelection:NO];
    
    [self findConnectedPinpads];
    
    STNPinpad *selectedPinpad = [[STNPinPadConnectionProvider new] selectedPinpad];
    for (int i = 0; i < connectedPinpads.count; i++) {
        STNPinpad *pinpad = connectedPinpads[i];
        if (selectedPinpad != nil && [pinpad.name isEqualToString:selectedPinpad.name]) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
            self.feedback.text = [NSString stringWithFormat:@"Selected pinpad %@", pinpad.name];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)refresh:(id)sender {
    [self findConnectedPinpads];
}

-(void)findConnectedPinpads {
    connectedPinpads = [[STNPinPadConnectionProvider new] listConnectedPinpads];
    for (STNPinpad *pinpad in connectedPinpads) {
        NSLog(@"\nPinpad name: %@\nPinpad identifier: %@", pinpad.name, pinpad.identifier);
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return connectedPinpads.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pinpadCell" forIndexPath:indexPath];
    STNPinpad *pinpad = connectedPinpads[indexPath.row];
    cell.textLabel.text = pinpad.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[STNPinPadConnectionProvider new] selectPinpad:connectedPinpads[indexPath.row]];
    self.feedback.text = [NSString stringWithFormat:@"Selected pinpad %@", connectedPinpads[indexPath.row].name];
}

@end
