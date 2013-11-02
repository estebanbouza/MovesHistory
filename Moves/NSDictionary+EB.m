//
//  NSDictionary+EB.m
//  Moves
//
//  Created by Esteban on 10/30/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "NSDictionary+EB.h"

@implementation NSDictionary (EB)

- (id)objectForKeyOrNil:(id)aKey {
    return [[self objectForKey:aKey] isKindOfClass:[NSNull class]] ? [self objectForKey:aKey] : nil;
}

@end
