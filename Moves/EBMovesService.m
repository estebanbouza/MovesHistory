//
//  EBServiceConfiguration.m
//  Moves
//
//  Created by Esteban on 10/14/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "EBMovesService.h"
#import "EBMovesConfiguration.h"

@interface EBMovesService ()

@property (nonatomic, strong) NSString *authCode;

@end

@implementation EBMovesService

#pragma mark - Lifecycle

+ (EBMovesService *)sharedServiceConfiguration {
    static dispatch_once_t onceToken;
    static EBMovesService *instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark - Utils

+ (NSString *)descriptionForScope:(MVAuthScope)scope {
    NSString *desc = [NSString string];
    
    if (scope & MVAuthLocationScope) {
        desc = [desc stringByAppendingString:@" location"];
    }
    if (scope & MVAuthActivityScope) {
        desc = [desc stringByAppendingString:@" activity"];
    }
    
    desc = [desc stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    desc = [desc stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    return desc;
}

#pragma mark - URLs
- (NSURL *)authBaseURL {
    return [NSURL URLWithString:@"https://api.moves-app.com/oauth/v1"];
}

- (NSURL *)appAuthURLWithRedirectURI:(NSString *)redirectURI
                               scope:(MVAuthScope)scope {
    NSString const * movesClientID = MOVES_CLIENT_ID;
    NSString *scopeString = [EBMovesService descriptionForScope:scope];
    
    NSString *urlString = [NSString stringWithFormat:@"moves://app/authorize?client_id=%@&redirect_uri=%@&scope=%@",
                           movesClientID,
                           redirectURI,
                           scopeString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    DLog(@"%@", url);
    
    return url;
}

- (NSURL *)requestAccessTokenURLWithAuthCode:(NSString *)authCode
                                 redirectURI:(NSString *)redirectURI
{
    /*
     https://api.moves-app.com/oauth/v1/access_token?grant_type=authorization_code&code=<code>&client_id=<client_id>&client_secret=<client_secret>&redirect_uri=<redirect_uri>
     */
    NSString *urlString = [NSString stringWithFormat:@"https://api.moves-app.com/oauth/v1/access_token?grant_type=authorization_code&code=%@&client_id=%@&client_secret=%@", authCode, MOVES_CLIENT_ID, MOVES_CLIENT_SECRET];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    return url;
}

#pragma mark - Services
#pragma mark Auth

- (BOOL)authWithRedirectURI:(NSString *)redirectURI
                      scope:(MVAuthScope)scope {
    
    NSURL *url = [self appAuthURLWithRedirectURI:redirectURI scope:scope];
    
    return [[UIApplication sharedApplication] openURL:url];
}

- (BOOL)authenticate {
    return [self authWithRedirectURI:@"ebmoves://asdf" scope:MVAuthLocationScope | MVAuthActivityScope];
}

- (void)storeAuthCode:(NSString *)authCode {
    self.authCode = authCode;
}

@end
