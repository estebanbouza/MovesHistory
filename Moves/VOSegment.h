//
//  VOSegment.h
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VOActivity, VOPlace, VOStoryline;

@interface VOSegment : NSManagedObject

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) VOStoryline *storyline;
@property (nonatomic, retain) NSSet *places;
@property (nonatomic, retain) NSSet *activities;
@end

@interface VOSegment (CoreDataGeneratedAccessors)

- (void)addPlacesObject:(VOPlace *)value;
- (void)removePlacesObject:(VOPlace *)value;
- (void)addPlaces:(NSSet *)values;
- (void)removePlaces:(NSSet *)values;

- (void)addActivitiesObject:(VOActivity *)value;
- (void)removeActivitiesObject:(VOActivity *)value;
- (void)addActivities:(NSSet *)values;
- (void)removeActivities:(NSSet *)values;

@end
