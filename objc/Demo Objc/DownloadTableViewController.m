//
//  DownloadTableViewController.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 03/03/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "DownloadTableViewController.h"

@interface DownloadTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *feedback;

@end

@implementation DownloadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Download de Tabelas";
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)performDownload:(id)sender {
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    NSLog(@"Solicitou Download de Tabelas.");
    
    /*
        Efetuando o download das tabelas.
     */
    [STNTableDownloaderProvider downLoadTables:^(BOOL succeeded, NSError *error) {
        [self.overlayView removeFromSuperview];
        if (succeeded) {
             NSLog(@"Download Realizado.");
             self.feedback.text = @"Download realizado.";
             
         } else {
             self.feedback.text = error.description;
             NSLog(@"%@", error.description);
         }
     }];
}

@end
