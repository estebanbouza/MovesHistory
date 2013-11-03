//
//  VOLocation.m
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "VOLocation.h"
#import "VOActivity.h"
#import "VOPlace.h"


@implementation VOLocation

@dynamic latitude;
@dynamic longitude;
@dynamic timestamp;
@dynamic activity;
@dynamic place;

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    self.latitude = [dictionary objectOrNilForKey:@"lat"];
    self.longitude = [dictionary objectOrNilForKey:@"lon"];
    self.timestamp = [[NSDateFormatter movesLongDateFormatter] dateFromString:[dictionary objectOrNilForKey:@"time"]];
}

- (CLLocation *)location {
    return [[CLLocation alloc] initWithLatitude:self.latitude.doubleValue longitude:self.longitude.doubleValue];
}

@end
