//
//  EBModel.h
//  Moves
//
//  Created by Esteban on 11/3/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MVManagedObjectContext [[EBModel sharedModel] managedObjectContext]


@interface EBModel : NSObject

+ (EBModel *)sharedModel;

- (void)saveContext;
- (NSManagedObjectContext *)managedObjectContext;

@end
