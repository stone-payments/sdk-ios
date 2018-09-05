//
//  ActivityIndicatorView.m
//  Demo Objc
//
//  Created by Bruno Colombini | Stone on 05/09/18.
//  Copyright © 2018 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "ActivityIndicatorView.h"

@implementation ActivityIndicatorView

- (id)initWithView:(UIView *)view{
    self.mainView = view;
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    return self;
}

- (void)startActivityIndicator{
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.mainView addSubview:self.overlayView];
}

- (void)stopActivityIndicator{
    [self.overlayView removeFromSuperview];
}
@end
