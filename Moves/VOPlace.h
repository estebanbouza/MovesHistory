//
//  VOPlace.h
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VOLocation, VOSegment;

@interface VOPlace : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) VOSegment *segment;
@property (nonatomic, retain) VOLocation *location;

@end
