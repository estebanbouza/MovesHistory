//
//  VOUserProfile.h
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VOStoryline;

@interface VOUserProfile : NSManagedObject

@property (nonatomic, retain) NSNumber * caloriesAvailable;
@property (nonatomic, retain) NSDate * firstDate;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSSet *storylines;
@end

@interface VOUserProfile (CoreDataGeneratedAccessors)

- (void)addStorylinesObject:(VOStoryline *)value;
- (void)removeStorylinesObject:(VOStoryline *)value;
- (void)addStorylines:(NSSet *)values;
- (void)removeStorylines:(NSSet *)values;

- (void)updateWithDictionary:(NSDictionary *)dictionary;

@end
