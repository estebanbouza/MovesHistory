//
//  NSDateFormatter+EB.h
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (EB)

/** Formatter with format yyyyMMdd */
+ (NSDateFormatter const *)movesDefaultDateFormatter;

/** Formatter with format "yyyyMMdd’T’HHmmssZ" */
+ (NSDateFormatter const *)movesLongDateFormatter;

@end
