//
//  VOStorylineSegment.h
//  Moves
//
//  Created by Esteban on 11/3/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VOValueObject.h"

@class VOActivity, VOPlace, VOStoryline;

@interface VOStorylineSegment : VOValueObject

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *activities;
@property (nonatomic, retain) VOPlace *place;
@property (nonatomic, retain) VOStoryline *storyline;
@end

@interface VOStorylineSegment (CoreDataGeneratedAccessors)

- (void)addActivitiesObject:(VOActivity *)value;
- (void)removeActivitiesObject:(VOActivity *)value;
- (void)addActivities:(NSSet *)values;
- (void)removeActivities:(NSSet *)values;

@end
