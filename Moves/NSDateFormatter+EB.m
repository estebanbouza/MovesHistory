//
//  NSDateFormatter+EB.m
//  Moves
//
//  Created by Esteban on 11/2/13.
//  Copyright (c) 2013 Esteban. All rights reserved.
//

#import "NSDateFormatter+EB.h"

@implementation NSDateFormatter (EB)

+ (NSDateFormatter const *)movesDefaultDateFormatter {

    static NSDateFormatter const *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyyMMdd";
    });
    
    return dateFormatter;
}

+ (NSDateFormatter const *)movesLongDateFormatter {
    static dispatch_once_t onceToken;
    static NSDateFormatter const *dateFormatter;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyyMMdd’T’HHmmssZ";
    });
    
    return dateFormatter;
}

@end
