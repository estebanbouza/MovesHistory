//
//  VOActivity.h
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VOValueObject.h"

@class VOLocation, VOStorylineSegment;

@interface VOActivity : VOValueObject

@property (nonatomic, retain) NSString * activityType;
@property (nonatomic, retain) NSNumber * calories;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * steps;
@property (nonatomic, retain) VOStorylineSegment *segment;
@property (nonatomic, retain) VOLocation *location;

@end
