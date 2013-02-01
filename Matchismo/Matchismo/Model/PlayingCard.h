//
//  PlayingCard.h
//  Matchismo
//
//  Created by Kevin Peters on 1/31/13.
//  Copyright (c) 2013 Space Monkey Apps, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface PlayingCard : Card

+ (NSArray*)validSuits;
+ (NSUInteger)maxRank;

@property (strong, nonatomic) NSString* suit;
@property (nonatomic) NSUInteger rank;

@end
