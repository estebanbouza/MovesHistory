//
//  VOLocation.h
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VOValueObject.h"

@class VOActivity, VOPlace;

@interface VOLocation : VOValueObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) VOActivity *activity;
@property (nonatomic, retain) VOPlace *place;

/** @returns a CLLocation object */
- (CLLocation *)location;

@end
