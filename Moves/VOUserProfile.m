//
//  VOUserProfile.m
//  Moves
//
//  Created by Esteban on 10/30/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "VOUserProfile.h"
#import "NSDateFormatter+EB.h"

@implementation VOUserProfile

@dynamic userID;
@dynamic firstDate;
@dynamic caloriesAvailable;

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.userID = [[dictionary objectForKey:@"userId"] stringValue];
    self.caloriesAvailable = [dictionary objectForKey:@"caloriesAvailable"];
    
    NSDictionary *profileDictionary = [dictionary objectForKey:@"profile"];
    
    self.firstDate = [[NSDateFormatter movesDefaultFormatter] dateFromString:[profileDictionary objectForKey:@"firstDate"]];

}

@end
