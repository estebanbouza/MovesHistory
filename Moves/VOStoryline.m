//
//  VOStoryline.m
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "VOStoryline.h"
#import "VOUserProfile.h"
#import "EBModel.h"
#import "VOStorylineSegment.h"

@implementation VOStoryline

@dynamic date;
@dynamic segments;
@dynamic userProfile;

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.date = [[NSDateFormatter movesDefaultDateFormatter] dateFromString:[dictionary objectOrNilForKey:@"date"]];
    
    for (NSDictionary *segmentDict in [dictionary objectOrNilForKey:@"segments"]) {
        VOStorylineSegment *segment = [NSEntityDescription insertNewObjectForEntityForName:[[VOStorylineSegment class] description] inManagedObjectContext:MVManagedObjectContext];
        
        segment.storyline = self;
        
        [segment updateWithDictionary:segmentDict];
    }
    
}

@end
