//
//  EBServiceConfiguration.m
//  Moves
//
//  Created by Esteban on 10/14/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "EBMovesService.h"
#import "EBModel.h"

#import "VOUserProfile.h"
#import "VOStoryline.h"

#import "EBAppDelegate.h"

@class VOUserProfile, VOStoryline;

static NSString *kKeychainAuthenticationKey = @"auth_key";
static NSString *kKeychainAccessTokenKey = @"access_token";
static NSString *kKeychainAccessTokenExpirationDateKey = @"access_token_expiration";
static NSString *kKeychainRefreshTokenKey = @"refresh_token";


@interface EBMovesService ()

@property (nonatomic, strong) NSString *authCode;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *refreshToken;

@end

@implementation EBMovesService

#pragma mark - Lifecycle

+ (EBMovesService *)sharedService {
    static dispatch_once_t onceToken;
    static EBMovesService *instance;
    
    dispatch_once(&onceToken, ^{
        instance = [self new];
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

- (AFHTTPSessionManager *)authHTTPSessionManager {
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *sessionManager;
    
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{@"Authorization" : [NSString stringWithFormat:@"Bearer %@", self.accessToken]};
        
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.moves-app.com/api/v1"] sessionConfiguration:sessionConfiguration];
        
    });
    
    return sessionManager;
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
    NSString const * movesClientID = self.movesClientID;
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

- (void)storeAuthCode:(NSString *)authCode {
    self.authCode = authCode;
}

- (BOOL)authenticateWithRedirectURI:(NSString *)redirectURI
                              scope:(MVAuthScope)scope {
    
    NSURL *url = [self appAuthURLWithRedirectURI:redirectURI scope:scope];
    
    return [[UIApplication sharedApplication] openURL:url];
}

- (void)authenticate {
    [self authenticateWithRedirectURI:self.movesRedirectURI scope:MVAuthLocationScope | MVAuthActivityScope];
}


- (NSMutableData *)dictionaryDataForExpirationDate:(NSDate *)expirationDate refreshToken:(NSString *)refreshToken accessToken:(NSString *)accessToken {
    NSDictionary *storeDict = @{kKeychainAccessTokenKey : accessToken,
                                kKeychainRefreshTokenKey : refreshToken,
                                kKeychainAccessTokenExpirationDateKey : expirationDate};
    NSMutableData *storeData = [NSMutableData new];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:storeData];
    [archiver encodeObject:storeDict forKey:kKeychainAuthenticationKey];
    [archiver finishEncoding];
    return storeData;
}

- (void)storeAuthData:(NSMutableData *)storeData {
    NSDictionary *queryDeletePreviousAccessToken = @{(__bridge id)kSecClass : (__bridge id)kSecClassKey};
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)queryDeletePreviousAccessToken);
    if (status != noErr) {
        NSAssert(0, @"Error deleting from keychain");
    }
    
    NSDictionary *accessTokenDict = @{(__bridge id)kSecClass : (__bridge id)kSecClassKey,
                                      (__bridge id)kSecAttrLabel : kKeychainAuthenticationKey,
                                      (__bridge id)kSecValueData : storeData
                                      };
    
    status = SecItemAdd((__bridge CFDictionaryRef)accessTokenDict, NULL);
    if (status != noErr) {
        NSAssert(0, @"Error storing in keychain");
    }
}

- (NSDictionary *)cachedAuthData {
    NSDictionary *queryDict = @{(__bridge id)kSecClass : (__bridge id)kSecClassKey,
                                (__bridge id)kSecAttrLabel : kKeychainAccessTokenKey,
                                (__bridge id)kSecReturnData : (id)kCFBooleanTrue };
    CFDataRef dataRef;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)queryDict, (CFTypeRef *)&dataRef);
    NSDictionary *authData = nil;
    
    if (status == noErr) {
        NSData *data = (__bridge NSData *)dataRef;
        
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        authData = [unarchiver decodeObjectForKey:kKeychainAuthenticationKey];
        
    }
    
    return authData;
}

- (void)requestAccessWithCompletionBlock:(MVRequestAccessCompletionBlock)completionBlock {
    
    AFHTTPRequestOperationManager *manager = [EBMovesService sharedHTTPRequestOperationManager];
    
    NSDictionary *requestParameters = @{@"grant_type" : @"authorization_code",
                                        @"code" : self.authCode,
                                        @"client_id" : self.movesClientID,
                                        @"client_secret" : self.movesClientSecret,
                                        @"redirect_uri" : self.movesRedirectURI};
    
    AFHTTPRequestOperation * operation = [manager POST:@"https://api.moves-app.com/oauth/v1/access_token" parameters:requestParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"Response Object: %@", responseObject);
        
        NSString *accessToken = [responseObject objectOrNilForKey:@"access_token"];
        NSString *refreshToken = [responseObject objectOrNilForKey:@"refresh_token"];
        NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:[[responseObject objectForKey:@"expires_in"] doubleValue]];
        
        NSMutableData *storeData;
        storeData = [self dictionaryDataForExpirationDate:expirationDate refreshToken:refreshToken accessToken:accessToken];
        
        [self storeAuthData:storeData];
        
        completionBlock();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"The error was: %@", error);
    }];
    
    [operation start];
}


- (void)requestUserProfileWithCompletionBlock:(void(^)(VOUserProfile *userProfile))completionBlock {
    
    AFHTTPSessionManager *authManager = [self authHTTPSessionManager];
    
    [authManager GET:@"user/profile" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        VOUserProfile *userProfile = [NSEntityDescription insertNewObjectForEntityForName:[[VOUserProfile class] description]
                                                                   inManagedObjectContext:MVManagedObjectContext];
        [userProfile updateWithDictionary:responseObject];
        
        completionBlock(userProfile);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"%@", error);
    }];
    
}


- (void)requestStorylineForDate:(NSDate *)date
                completionBlock:(void (^)(NSArray *))completionBlock
                     errorBlock:(MVRequestErrorBlock)erroBlock
{
    
    NSString *url = @"user/storyline/daily/";
    url = [url stringByAppendingString:[[NSDateFormatter movesDefaultDateFormatter] stringFromDate:date]];
    
    AFHTTPSessionManager *authManager = [self authHTTPSessionManager];
    
    [authManager GET:url
          parameters:@{@"trackPoints" : @"true"}
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 DLog(@"Response Object %@", responseObject);
                 
                 NSMutableArray *storylines = [NSMutableArray new];
                 
                 for (NSDictionary *storylineDict in responseObject) {
                     VOStoryline *storyline = [NSEntityDescription insertNewObjectForEntityForName:[[VOStoryline class] description] inManagedObjectContext:MVManagedObjectContext];
                     [storyline updateWithDictionary:storylineDict];
                     [storylines addObject:storyline];
                 }
                 
                 DLog(@"Parsed storyline: %@", storylines);
                 
                 completionBlock(storylines);
             }
     
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 DLog(@"%@", error);
                 erroBlock(error);
             }];
    
}



@end






