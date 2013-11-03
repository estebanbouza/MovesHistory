//
//  EBServiceConfiguration.h
//  Moves
//
//  Created by Esteban on 10/14/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VOUserProfile, VOStoryline;

typedef NS_ENUM(NSInteger, MVAuthScope) {
    MVAuthActivityScope     = 1 << 1,
    MVAuthLocationScope     = 1 << 2
};

typedef void (^MVRequestAccessCompletionBlock)(void);
typedef void (^MVRequestErrorBlock)(NSError *);

@interface EBMovesService : NSObject

@property (nonatomic, strong) NSString *movesClientID;
@property (nonatomic, strong) NSString *movesClientSecret;
@property (nonatomic, strong) NSString *movesRedirectURI;

#pragma mark - Lifecycle
+ (EBMovesService *)sharedService;

#pragma mark - Auth service
/** Authenticates with Moves API */
- (void)authenticate;

/** Stores the auth code locally */
- (void)storeAuthCode:(NSString *)authCode;

- (void)requestAccessWithCompletionBlock:(MVRequestAccessCompletionBlock)completionBlock;

#pragma mark - Services
- (void)requestUserProfileWithCompletionBlock:(void(^)(VOUserProfile *userProfile))userProfileBlock;

- (void)requestStorylineForDate:(NSDate *)date
         completionBlock:(void(^)(NSArray *storylines))completionBlock
              errorBlock:(MVRequestErrorBlock)erroBlock;

@end
