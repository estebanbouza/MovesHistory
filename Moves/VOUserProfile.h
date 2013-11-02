//
//  VOUserProfile.h
//  Moves
//
//  Created by Esteban on 10/30/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EBDescribedObject.h"

@interface VOUserProfile : EBDescribedObject

@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSDate * firstDate;
@property (nonatomic, retain) NSNumber * caloriesAvailable;

- (void)updateWithDictionary:(NSDictionary *)dictionary;

@end
