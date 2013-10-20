//
//  EBServiceConfiguration.h
//  Moves
//
//  Created by Esteban on 10/14/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBServiceConfiguration : NSObject

typedef NS_ENUM(NSInteger, MVAuthScope) {
    MVAuthActivityScope     = 1 << 1,
    MVAuthLocationScope     = 1 << 2
};

#pragma mark - Lifecycle
+ (EBServiceConfiguration *)sharedServiceConfiguration;

#pragma mark - Auth service
/** Authenticates with Moves API */
- (BOOL)authenticate;


@end
