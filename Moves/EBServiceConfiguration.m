//
//  EBServiceConfiguration.m
//  Moves
//
//  Created by Esteban on 10/14/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "EBServiceConfiguration.h"

typedef NS_ENUM(NSInteger, MVAuthScope) {
    MVAuthActivityScope     = 1 << 1,
    MVAuthLocationScope     = 1 << 2
};

@implementation EBServiceConfiguration

- (NSURL *)authBaseURL {
    return [NSURL URLWithString:@"https://api.moves-app.com/oauth/v1"];
}

- (NSURL *)authURLWithClientID:(NSString *)clientID
                   redirectURI:(NSString *)redirectURI
                         scope:(MVAuthScope)scope {

    NSURL *baseURL = [self authBaseURL];
    
    baseURL = [NSURL URLWithString:@"authorize" relativeToURL:baseURL];
    baseURL = [NSURL URLWithString:<#(NSString *)#>]
    
    return baseURL;
}


@end
