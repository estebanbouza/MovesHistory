//
//  VOSegment.m
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "VOSegment.h"
#import "VOActivity.h"
#import "VOPlace.h"
#import "VOStoryline.h"


@implementation VOSegment

@dynamic endTime;
@dynamic startTime;
@dynamic type;
@dynamic storyline;
@dynamic places;
@dynamic activities;

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    
    self.type = [dictionary objectOrNilForKey:@"type"];
    self.startTime = [[NSDateFormatter movesLongDateFormatter] dateFromString:[dictionary objectOrNilForKey:@"startTime"]];
    self.endTime = [[NSDateFormatter movesLongDateFormatter] dateFromString:[dictionary objectOrNilForKey:@"endTime"]];
    
    if ([dictionary objectOrNilForKey:@"place"]) {
        
    }
    else if ([dictionary objectOrNilForKey:@"activities"]) {
        
    }
    
}


@end
