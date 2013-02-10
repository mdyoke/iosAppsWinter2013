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
    int score = 0;
    
    for (Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
        {
            //
            // The cards match.
            //
            score = 1;
        }
        else
        {
            //
            // The cards do not match.
            //
            score = 0;
        }
    }
    
    return score;
}

@end
