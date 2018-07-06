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
// Array with all paired pinpad devices
@property (strong, nonatomic) NSArray <STNPinpad*> *connectedPinpads;
@end

@implementation SelectPinpadViewController

#pragma mark - Lifecycle

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
    
    // if the selected pinpad exists update the selected row at table view
    if (selectedPinpad != nil && [_connectedPinpads containsObject:selectedPinpad]) {
        int i = (int)[_connectedPinpads indexOfObject:selectedPinpad];
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]
                                    animated:false
                              scrollPosition:UITableViewScrollPositionTop];
        
        // Update label text with the name of selected pinpad
        _feedback.text = [NSString stringWithFormat:@"Selected pinpad %@", selectedPinpad.name];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)refresh:(id)sender {
    [self findConnectedPinpads];
}

-(void)findConnectedPinpads {
    _connectedPinpads = [[STNPinPadConnectionProvider new] listConnectedPinpads];
    for (STNPinpad *pinpad in _connectedPinpads) {
        NSLog(@"\nPinpad name: %@\nPinpad identifier: %@", pinpad.name, pinpad.identifier);
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

// Set number of rows based on the numbers of available connected pinpads
- (NSInteger) tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _connectedPinpads.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pinpadCell" forIndexPath:indexPath];
    STNPinpad *pinpad = _connectedPinpads[indexPath.row];
    cell.textLabel.text = pinpad.name;
    return cell;
}

#pragma mark - UITableViewDelegate

// Connect to the selected pinpad
-(void)tableView:(UITableView *) tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Check if the row is a valid position at list of connected pinpads
    if ([_connectedPinpads count] > indexPath.row) {
        // selectPinpad will try to select the choosed pinpad
        // the return must be used to check connectivity
        BOOL hasConnected = [[STNPinPadConnectionProvider new] selectPinpad:_connectedPinpads[indexPath.row]];
        NSString *labelContent = [NSString stringWithFormat:@"pinpad %@", _connectedPinpads[indexPath.row].name];
        if (hasConnected) {
            labelContent = [@"Valid " stringByAppendingString:labelContent];
        } else {
            labelContent = [@"Invalid " stringByAppendingString:labelContent];
        }
        // Refresh label data
        [self setFeedbackMessage:labelContent];
        
        // The selected pinpad could be retrieved as below
        STNPinpad *pinpad = [[STNPinPadConnectionProvider new] selectedPinpad];
        NSLog(@"Selected pinpad %@", pinpad);
    }
}

#pragma mark - UI Update

// Setup view
-(void)setupView {
    [super viewDidLoad];
    
    self.navigationItem.title = [kTitleSelection localize];
    _instructionLabel.text = [kInstructionSelection localize];
    [_refreshButton setTitle:[kButtonRefresh localize]
                        forState:UIControlStateNormal];
    _overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _overlayView.backgroundColor = [UIColor colorWithRed:0
                                                       green:0
                                                        blue:0
                                                       alpha:0.5];
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicator.center = _overlayView.center;
    [_tableView setAllowsMultipleSelection:NO];
}

// Update UI Element
-(void)setFeedbackMessage:(NSString*)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.feedback.text = message;
    });
}

@end
