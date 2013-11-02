//
//  EBMainViewController.m
//  Moves
//
//  Created by Esteban on 10/13/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "EBMainViewController.h"
#import "EBMovesService.h"

#import "VOUserProfile.h"

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
    [_loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    _syncButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_syncButton setTitle:@"Sync" forState:UIControlStateNormal];
    [_syncButton addTarget:self action:@selector(syncButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_syncButton];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    _syncButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *buttonConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_loginButton(300)]-[_syncButton(300)]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_loginButton, _syncButton)];

    NSArray *buttonConstraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_loginButton]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_loginButton)];
    
    [self.view addConstraints:buttonConstraintsH];
    [self.view addConstraints:buttonConstraintsV];
}


#pragma mark - Buttons

- (void)loginButtonPressed:(id)sender {
    DLog(@"");
    
    EBMovesService *service = [EBMovesService sharedService];
    
    [service authenticate];
}


- (void)syncButtonPressed:(id)sender {
    EBMovesService *service = [EBMovesService sharedService];
    
    [service requestUserProfileWithCompletionBlock:^(VOUserProfile *userProfile) {
        DLog(@"User Profile: %@", userProfile);
//        DLog(@"User profile is: %@, first date: %@", userProfile.userID, userProfile.firstDate);
    }];
    
}

#pragma mark - Public

- (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication {
    static NSString * const kCodeQueryParamPrefix = @"code=";
    static NSString * const kValidSourceApplication = @"com.protogeo.Moves";
    
    NSString *authCode = nil;
    
    if (![kValidSourceApplication isEqualToString:sourceApplication]) return NO;
    
    NSString *urlQuery = url.query;
    NSArray *queryParams = [urlQuery componentsSeparatedByString:@"&"];
    for (NSString *queryParam in queryParams) {
        if ([queryParam hasPrefix:kCodeQueryParamPrefix]) {
            authCode = [queryParam substringFromIndex:kCodeQueryParamPrefix.length];
            break;
        }
    }
    
    [[EBMovesService sharedService] storeAuthCode:authCode];

    [[EBMovesService sharedService] requestAccessWithCompletionBlock:^(void) {
        DLog(@"Access OK");
    }];
    
    return !!authCode;
}

@end
