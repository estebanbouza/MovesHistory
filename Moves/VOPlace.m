//
//  VOPlace.m
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "VOPlace.h"
#import "VOLocation.h"
#import "VOStorylineSegment.h"

@implementation VOPlace

@dynamic identifier;
@dynamic segment;
@dynamic location;

- (void)updateWithDictionary:(NSDictionary *)dictionary {
 
    self.identifier = [dictionary objectOrNilForKey:@"id"];
    self.location = [NSEntityDescription insertNewObjectForEntityForName:[[VOLocation class] description] inManagedObjectContext:MVManagedObjectContext];
    [self.location updateWithDictionary:[dictionary objectForKey:@"location"]];
    self.location.place = self;
}

@end
