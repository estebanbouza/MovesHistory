//
//  VOValueObject.h
//  Moves
//
//  Created by Esteban on 11/3/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "EBDescribedObject.h"
#import "EBModel.h"


@interface VOValueObject : NSManagedObject

- (void)updateWithDictionary:(NSDictionary *)dictionary;

@end
