//
//  ActivityIndicatorView.h
//  Demo Objc
//
//  Created by Bruno Colombini | Stone on 05/09/18.
//  Copyright © 2018 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityIndicatorView : UIView
@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

- (id)initWithView:(UIView *)view;
- (void)startActivityIndicator;
- (void)stopActivityIndicator;

@end
