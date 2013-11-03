//
//  VOStorylineSegment.m
//  Moves
//
//  Created by Esteban on 11/3/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "VOStorylineSegment.h"
#import "VOActivity.h"
#import "VOPlace.h"
#import "VOStoryline.h"

@implementation VOStorylineSegment

@dynamic endTime;
@dynamic startTime;
@dynamic type;
@dynamic activities;
@dynamic place;
@dynamic storyline;

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    
    self.type = [dictionary objectOrNilForKey:@"type"];
    self.startTime = [[NSDateFormatter movesLongDateFormatter] dateFromString:[dictionary objectOrNilForKey:@"startTime"]];
    self.endTime = [[NSDateFormatter movesLongDateFormatter] dateFromString:[dictionary objectOrNilForKey:@"endTime"]];
    
    NSDictionary *placeDict = nil;
    NSDictionary *activitiesDict = nil;
    
    if ((placeDict = [dictionary objectOrNilForKey:@"place"])) {
        VOPlace *place = [NSEntityDescription insertNewObjectForEntityForName:[[VOPlace class] description] inManagedObjectContext:MVManagedObjectContext];
        [place updateWithDictionary:placeDict];
        place.segment = self;
        
    }
    
    else if ((activitiesDict = [dictionary objectOrNilForKey:@"activities"])) {
        
        for (NSDictionary *activityDict in activitiesDict) {
            VOActivity *activity = [NSEntityDescription insertNewObjectForEntityForName:[[VOActivity class] description] inManagedObjectContext:MVManagedObjectContext];
            [activity updateWithDictionary:activityDict];
            
            activity.segment = self;
            [self addActivitiesObject:activity];
        }
        
    }
    
}


@end
