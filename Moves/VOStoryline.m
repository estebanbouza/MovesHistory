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
#import "EBAppDelegate.h"

@implementation VOStoryline

@dynamic date;
@dynamic segments;
@dynamic userProfile;

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.date = [[NSDateFormatter movesDefaultDateFormatter] dateFromString:[dictionary objectForKey:@"date"]];
    
    for (NSDictionary *segmentDict in [dictionary objectForKey:@"segments"]) {
        VOSegment *segment = [NSEntityDescription insertNewObjectForEntityForName:[[VOSegment class] description] inManagedObjectContext:MVManagedObjectContext];
        
        [segment updateWithDictionary:segmentDict];
    }
    
}

@end
