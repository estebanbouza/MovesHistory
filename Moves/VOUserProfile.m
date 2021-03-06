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
    self.userID = [[dictionary objectOrNilForKey:@"userId"] stringValue];
    
    NSDictionary *profileDictionary = [dictionary objectOrNilForKey:@"profile"];
    
    self.caloriesAvailable = [profileDictionary objectOrNilForKey:@"caloriesAvailable"];
    self.firstDate = [[NSDateFormatter movesDefaultDateFormatter] dateFromString:[profileDictionary objectOrNilForKey:@"firstDate"]];
    
}


@end
