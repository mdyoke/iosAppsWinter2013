//
//  Card.m
//  Matchismo
//
//  Created by Kevin Peters on 1/31/13.
//  Copyright (c) 2013 Space Monkey Apps, Inc. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{    
    for (Card* curCard in otherCards) {
        if (![curCard.contents isEqualToString:self.contents]) {
            // The current other card is not equal to this card.  Award 0 points.
            return 0;
        }
    }
    
    // If we got here, then the contents of all cards are equal.
    // Award 1 point.
    return 1;
}

@end
