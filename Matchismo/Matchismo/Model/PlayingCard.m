//
//  PlayingCard.m
//  Matchismo
//
//  Created by Kevin Peters on 1/31/13.
//  Copyright (c) 2013 Space Monkey Apps, Inc. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


////////////////////////////////////////////////////////////////////////////////
//
// Class methods
//
////////////////////////////////////////////////////////////////////////////////
+ (NSArray*)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

+ (NSArray*)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}


////////////////////////////////////////////////////////////////////////////////
//
// Instance Properties
//
////////////////////////////////////////////////////////////////////////////////

- (int)match:(NSArray*)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard* otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
        else if (otherCard.rank == self.rank) {
            score = 4;
        }
    }
    
    return score;
}






// Because we provide the setter and getter for this property.
@synthesize suit = _suit;

- (NSString *)suit
{
    return _suit? _suit: @"?";
}

- (void)setSuit:(NSString*)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
        
    }
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

////////////////////////////////////////////////////////////////////////////////
//
// Instance Methods
//
////////////////////////////////////////////////////////////////////////////////
- (NSString *)contents
{
    NSArray* rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


@end
