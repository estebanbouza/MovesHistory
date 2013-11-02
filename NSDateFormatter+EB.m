//
//  NSDateFormatter+EB.m
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "NSDateFormatter+EB.h"

@implementation NSDateFormatter (EB)

+ (NSDateFormatter const *)movesDefaultFormatter {

    static NSDateFormatter const *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyMMdd";
    });
    
    return dateFormatter;
}

@end
