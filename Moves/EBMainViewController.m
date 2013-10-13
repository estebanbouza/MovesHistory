//
//  EBMainViewController.m
//  Moves
//
//  Created by Esteban on 10/13/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "EBMainViewController.h"

@interface EBMainViewController () {
    UIButton *_loginButton;
    UIButton *_syncButton;
}


@end

@implementation EBMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.view addSubview:_loginButton];
    
    _syncButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_syncButton setTitle:@"Sync" forState:UIControlStateNormal];
    [self.view addSubview:_syncButton];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    _syncButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *buttonConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_loginButton][_syncButton]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_loginButton, _syncButton)];
    NSArray *buttonConstraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_loginButton]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_loginButton)];
    
    [self.view addConstraints:buttonConstraints];
    [self.view addConstraints:buttonConstraintsV];
}


#pragma mark - Buttons


@end
