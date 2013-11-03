//
//  VOStoryline.h
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VOValueObject.h"

@class VOStorylineSegment, VOUserProfile;

@interface VOStoryline : VOValueObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *segments;
@property (nonatomic, retain) VOUserProfile *userProfile;
@end

@interface VOStoryline (CoreDataGeneratedAccessors)

- (void)addSegmentsObject:(VOStorylineSegment *)value;
- (void)removeSegmentsObject:(VOStorylineSegment *)value;
- (void)addSegments:(NSSet *)values;
- (void)removeSegments:(NSSet *)values;

@end
