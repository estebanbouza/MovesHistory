//
//  VOUserProfile.m
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "VOUserProfile.h"
#import "VOStoryline.h"
#import "NSDateFormatter+EB.h"

@implementation VOUserProfile

@dynamic caloriesAvailable;
@dynamic firstDate;
@dynamic userID;
@dynamic storylines;

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.userID = [[dictionary objectForKey:@"userId"] stringValue];
    
    NSDictionary *profileDictionary = [dictionary objectForKey:@"profile"];
    
    self.caloriesAvailable = [profileDictionary objectForKey:@"caloriesAvailable"];
    self.firstDate = [[NSDateFormatter movesDefaultDateFormatter] dateFromString:[profileDictionary objectForKey:@"firstDate"]];
    
}


@end
