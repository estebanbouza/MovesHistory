//
//  EBServiceConfiguration.h
//  Moves
//
//  Created by Esteban on 10/14/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VOUserProfile;

@interface EBMovesService : NSObject

typedef NS_ENUM(NSInteger, MVAuthScope) {
    MVAuthActivityScope     = 1 << 1,
    MVAuthLocationScope     = 1 << 2
};

typedef void (^MVRequestAccessCompletionBlock)(void);

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

@end
