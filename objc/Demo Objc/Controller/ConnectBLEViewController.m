//
//  ConnectBLEViewController.m
//  Demo Objc
//
//  Created by Tatiana Magdalena on 24/10/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ConnectBLEViewController.h"
#import "NSString+Utils.h"

@interface ConnectBLEViewController ()

@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;
@property (strong, nonatomic) IBOutlet UIButton *scanButton;
@property (strong, nonatomic) IBOutlet UIButton *disconnectButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *feedback;
@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
// Array with all Low Energy pinpad devices found
@property (strong, nonatomic) NSMutableArray <STNPinpad *> *peripherals;
// Pinpad Central Manager
@property (strong, nonatomic) STNPinPadConnectionProvider *connection;

@end

@implementation ConnectBLEViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    // Setup UI components
    [self setupView];
    
    // Initialize the Central Manager
    _connection = [[STNPinPadConnectionProvider alloc] init];
    // Set delegate for BLE session implementation
    _connection.delegate = self;
    [_connection startCentral];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIButton actions

// Start scanning BLE devices
- (IBAction)startScanning:(id)sender {
    [_connection startScan];
}

// Disconnect all Bluetooth Low Energy pinpads
- (IBAction)disconnectAllBLE:(id)sender {
    // Fetch all connected pinpads
    NSArray<STNPinpad*>* connectedPinpads = [_connection listConnectedPinpads];
    for (STNPinpad* pinpad in connectedPinpads) {
        // Disconnect each one
        [_connection disconnectPinpad:pinpad];
    }
}

#pragma mark - UITableViewDataSource

// Set number of rows based on the numbers of available peripherals
-(NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    return _peripherals.count;
}

// Set a cell for peripheral from list
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Set cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"peripheralCell" forIndexPath:indexPath];
    if ([_peripherals count] > indexPath.row) {
        cell.textLabel.text = _peripherals[indexPath.row].name;
    }
    cell.textLabel.text = _peripherals[indexPath.row].name;
    return cell;
}

#pragma mark - UITableViewDataDelegate

// Connect to the selected pinpad and stop scanning
-(void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Stabilish connection with selected pinpad
    [_connection connectToPinpad:_peripherals[indexPath.row]];
    // Stop scanning
    [_connection stopScan];
}

#pragma mark - STNPinPadConnectionDelegate Delegate

// Start scanning
-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider
               didStartScanning:(BOOL)success
                          error:(NSError *)error {
    // The param success informs if its actually scanning
    NSLog(@"%@: %@", [kLogStartScan localize], success ? [kGeneralYes localize] : [kGeneralNo localize]);
    // You could check and treat the error
    if (error) {
        NSLog(@"Error: %@", error.description);
    }
    // Refresh label data
    [self setFeedbackMessage:[kLogStartScan localize]];
}

// Did find pinpad
-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider
                  didFindPinpad:(STNPinpad *)pinpad {
    // Initialize peripherals if needed
    if(_peripherals == nil) {
        _peripherals = [[NSMutableArray alloc] init];
    }
    // If the peripherals did not contains the found pinpad, make the inclusion
    if(![_peripherals containsObject:pinpad]) {
        // You can access the pinpad data
        NSLog(@"%@: %@", [kLogFind localize], pinpad.name);
        // Add the new pinpad to the peripherals list
        [_peripherals addObject:pinpad];
        // Refresh table view content
        [self refreshTableViewContent];
    }
}

// Did connect pinpad
-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider
               didConnectPinpad:(STNPinpad *)pinpad
                          error:(NSError * _Nullable)error {
    //  You can access the pinpad data
    NSLog(@"%@: %@", [kLogConnect localize], pinpad.name);
    //  Refresh label data
    [self setFeedbackMessage:[kLogConnect localize]];
    //[connection disconnectPinpad:pinpad];
    
    //  Use this specific pinpad in the future transactions
    [_connection selectPinpad:pinpad];
}

// Did disconnect pinpad
-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider
            didDisconnectPinpad:(STNPinpad *)pinpad {
    //  You can access the pinpad data
    NSLog(@"%@: %@", [kLogDisconnect localize], pinpad.name);
    //  Refresh label data
    [self setFeedbackMessage: [kLogDisconnect localize]];
}

// Access the actually central state
-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider
          didChangeCentralState:(CBManagerState)state {
    
    NSString *stateString = @"";
    
    // Central states
    switch (state) {
        case 0: stateString = @"Unknown"; break;
        case 1: stateString = @"Resetting"; break;
        case 2: stateString = @"Unsupported"; break;
        case 3: stateString = @"Unauthorized"; break;
        case 4: stateString = @"Powered off"; break;
        case 5: stateString = @"Powered on"; break;
        default:
            break;
    }
    
    NSLog(@"%@: %@", [kLogCentralState localize], stateString);
}

#pragma mark - UI Update

// Setup view
- (void)setupView {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.navigationItem.title = [kTitleBLE localize];
    _instructionLabel.text = [kInstructionBLE localize];
    [_scanButton setTitle:[kButtonScan localize]
                     forState:UIControlStateNormal];
    [_disconnectButton setTitle:[kButtonDisconnect localize]
                           forState:UIControlStateNormal];
    _overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _overlayView.backgroundColor = [UIColor colorWithRed:0
                                                       green:0
                                                        blue:0
                                                       alpha:0.5];
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicator.center = _overlayView.center;
}

// Update UI Element
-(void)setFeedbackMessage:(NSString*)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.feedback.text = message;
    });
}

// Refresh Table View
-(void) refreshTableViewContent {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
@end
