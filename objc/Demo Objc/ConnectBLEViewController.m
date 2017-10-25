//
//  ConnectBLEViewController.m
//  Demo Objc
//
//  Created by Tatiana Magdalena on 24/10/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ConnectBLEViewController.h"


@interface ConnectBLEViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *feedback;

@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation ConnectBLEViewController

NSMutableArray <STNPinpad *> *peripherals;
STNPinPadConnectionProvider *connection;

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"Conexão com BLE";
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    
    if ([STNValidationProvider validatePinpadConnection] == NO) {
        NSLog(@"Pinpad não conectado.");
        self.feedback.text = @"Desconectado";
    } else {
        NSLog(@"Pinpad conectado.");
        self.feedback.text = @"Conectado";
    }

    connection = [[STNPinPadConnectionProvider alloc] init];
    connection.delegate = self;
    [connection startCentral];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons actions

- (IBAction)startScanning:(id)sender
{
    [connection startScan];
}

- (IBAction)disconnectAllBLE:(id)sender
{
    NSArray<STNPinpad*>* connectedPinpads = [connection listConnectedPinpads];
    
    for (STNPinpad* pinpad in connectedPinpads) {
        [connection disconnectPinpad:pinpad];
    }
}

#pragma mark - Tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return peripherals.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"peripheralCell" forIndexPath:indexPath];
    cell.textLabel.text = peripherals[indexPath.row].name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [connection connectToPinpad:peripherals[indexPath.row]];
    [connection stopScan];
}

#pragma mark - Pinpad Connection Delegate

-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didStartScanning:(BOOL)success error:(NSError *)error
{
    NSLog(@"$Did start scanning: %@", success ? @"true" : @"false");
    [self setFeedbackMessage:@"Começou a escanear"];
}

-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didFindPinpad:(STNPinpad *)pinpad
{
    if(peripherals == nil) {
        peripherals = [[NSMutableArray alloc] init];
    }
    
    if(![peripherals containsObject:pinpad]) {
        NSLog(@"$Did find pinpad: %@", pinpad.name);
        [peripherals addObject:pinpad];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didConnectPinpad:(STNPinpad *)pinpad error:(NSError * _Nullable)error
{
    NSLog(@"$Did connect to pinpad: %@", pinpad.name);
    [self setFeedbackMessage:@"Conectou ao pinpad"];
    //[connection disconnectPinpad:pinpad];
    
    [connection selectPinpad:pinpad];
}

-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didDisconnectPinpad:(STNPinpad *)pinpad
{
    NSLog(@"$Did disconnect from pinpad: %@", pinpad.name);
    [self setFeedbackMessage:@"Desconectou do pinpad"];
}

-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider *)provider didChangeCentralState:(CBManagerState)state
{
    NSString *stateString = @"";
    
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
    
    NSLog(@"$Did change central state: %@", stateString);
}

-(void)setFeedbackMessage:(NSString*)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.feedback.text = message;
    });
}

@end
