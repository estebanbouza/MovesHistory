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

+ (EBMovesService *)sharedService {
    static dispatch_once_t onceToken;
    static EBMovesService *instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

+ (AFHTTPRequestOperationManager *)sharedHTTPRequestOperationManager {
    static dispatch_once_t onceToken;
    static AFHTTPRequestOperationManager *operationManager;
    
    dispatch_once(&onceToken, ^{
        operationManager = [AFHTTPRequestOperationManager manager];
    });
    
    return operationManager;
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

- (NSString *)redirectURI {
    return @"ebmoves://logincallback";
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


#pragma mark - Services
#pragma mark Auth

- (BOOL)authenticateWithRedirectURI:(NSString *)redirectURI
                              scope:(MVAuthScope)scope {
    
    NSURL *url = [self appAuthURLWithRedirectURI:redirectURI scope:scope];
    
    return [[UIApplication sharedApplication] openURL:url];
}

- (void)authenticate {
    [self authenticateWithRedirectURI:[self redirectURI] scope:MVAuthLocationScope | MVAuthActivityScope];
}

- (void)storeAuthCode:(NSString *)authCode {
    self.authCode = authCode;
}


- (void)requestAccessWithCompletionBlock:(MVRequestAccessCompletionBlock)completionBlock {
    
    AFHTTPRequestOperationManager *manager = [EBMovesService sharedHTTPRequestOperationManager];
    
    NSDictionary *requestParameters = @{@"grant_type" : @"authorization_code",
                                        @"code" : self.authCode,
                                        @"client_id" : MOVES_CLIENT_ID,
                                        @"client_secret" : MOVES_CLIENT_SECRET,
                                        @"redirect_uri" : [self redirectURI]};
    
    AFHTTPRequestOperation * operation = [manager POST:@"https://api.moves-app.com/oauth/v1/access_token" parameters:requestParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"Response Object: %@", responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"The error was: %@", error);
    }];
    
    [operation start];
}

@end



