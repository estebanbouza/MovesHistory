//
//  EBMainViewController.m
//  Moves
//
//  Created by Esteban on 10/13/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "EBMainViewController.h"
#import "EBMovesService.h"
#import "NSDate-Utilities.h"

#import "VOUserProfile.h"

@interface EBMainViewController () {
    UIButton *_loginButton;
    UIButton *_syncButton;
    UIButton *_storylineButton;
    
    NSMutableArray *_buttons;
}


@end

@implementation EBMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    _buttons = [NSMutableArray new];
    
    [self insertButtonWithTitle:@"Login" action:@selector(loginButtonPressed:)];
    [self insertButtonWithTitle:@"Sync" action:@selector(syncButtonPressed:)];
    [self insertButtonWithTitle:@"Storyline" action:@selector(storylineButtonPressed:)];
    
    [self.view setNeedsUpdateConstraints];
}

- (UIButton *)insertButtonWithTitle:(NSString *)title action:(SEL)target {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:target forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button];
    [_buttons addObject:button];
    
    return button;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];

    for (NSInteger i = 0; i < _buttons.count-1; i++) {
        UIButton *btnA = _buttons[i];
        UIButton *btnB = _buttons[i+1];
        
        NSLayoutConstraint *yCenterConstraint = [NSLayoutConstraint constraintWithItem:btnA attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:btnB attribute:NSLayoutAttributeCenterY multiplier:1. constant:0.];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:btnA attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:btnB attribute:NSLayoutAttributeWidth multiplier:1. constant:0.];

        NSLayoutConstraint *spacingConstraint = [NSLayoutConstraint constraintWithItem:btnB attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:btnA attribute:NSLayoutAttributeRight multiplier:1. constant:20.];
        
        [self.view addConstraint:widthConstraint];
        [self.view addConstraint:spacingConstraint];
        [self.view addConstraint:yCenterConstraint];
    }

    NSLayoutConstraint *yMiddleConstraint = [NSLayoutConstraint constraintWithItem:_buttons[0] attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1. constant:0.];
    [self.view addConstraint:yMiddleConstraint];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_buttons[0] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1. constant:20.];
    [self.view addConstraint:leftConstraint];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_buttons[_buttons.count - 1] attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1. constant:-20.];
    [self.view addConstraint:rightConstraint];

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
    }];
    
}

- (void)storylineButtonPressed:(id)sender {

    NSDate *yesterday = [NSDate dateYesterday];
    
    EBMovesService *service = [EBMovesService sharedService];
    
    [service requestStorylineForDate:yesterday
                     completionBlock:^(NSArray *storylines) {
                         DLog(@"");
                     } errorBlock:^(NSError *error) {
                         DLog(@"");
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
