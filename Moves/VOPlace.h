//
//  VOPlace.h
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VOValueObject.h"

@class VOLocation, VOStorylineSegment;

@interface VOPlace : VOValueObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) VOStorylineSegment *segment;
@property (nonatomic, retain) VOLocation *location;

@end
