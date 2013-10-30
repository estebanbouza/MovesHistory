//
//  VOUserProfile.m
//  Moves
//
//  Created by Esteban on 10/30/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "VOUserProfile.h"


@implementation VOUserProfile

@dynamic userID;
@dynamic firstDate;
@dynamic caloriesAvailable;

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.userID = [[dictionary objectForKey:@"userId"] stringValue];
}

@end
