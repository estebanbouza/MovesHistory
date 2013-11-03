//
//  VOStoryline.m
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "VOStoryline.h"
#import "VOSegment.h"
#import "VOUserProfile.h"
#import "EBModel.h"

@implementation VOStoryline

@dynamic date;
@dynamic segments;
@dynamic userProfile;

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.date = [[NSDateFormatter movesDefaultDateFormatter] dateFromString:[dictionary objectForKeyOrNil:@"date"]];
    
    for (NSDictionary *segmentDict in [dictionary objectForKeyOrNil:@"segments"]) {
        VOSegment *segment = [NSEntityDescription insertNewObjectForEntityForName:[[VOSegment class] description] inManagedObjectContext:MVManagedObjectContext];
        
        segment.storyline = self;
        
        [segment updateWithDictionary:segmentDict];
    }
    
}

@end
