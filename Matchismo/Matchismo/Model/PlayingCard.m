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
// Overrides
//
////////////////////////////////////////////////////////////////////////////////

- (NSString *)contents
{
    NSArray* rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


- (int)match:(NSArray*) otherCards
{
    NSUInteger numOtherCards = [otherCards count];
    
    if ([self rankMatchesOthers:otherCards])
    {
        return powl(2, numOtherCards) * 5;
    }
    else if ([self suitMatchesOthers:otherCards])
    {
        return powl(2, numOtherCards) * 2;
    }
    else
    {
        return 0;
    }
}


////////////////////////////////////////////////////////////////////////////////
//
// Helper Methods
//
////////////////////////////////////////////////////////////////////////////////

- (BOOL) rankMatchesOthers:(NSArray*) others
{
    for (PlayingCard* curOtherCard in others)
    {
        if (curOtherCard.rank != self.rank)
        {
            return NO;
        }
    }
    
    // If we got here, all ranks match.
    return YES;
}

- (BOOL) suitMatchesOthers:(NSArray*) others
{
    for (PlayingCard* curOtherCard in others)
    {
        if (![curOtherCard.suit isEqualToString:self.suit])
        {
            return NO;
        }
    }
    
    // If we got here, all suits match.
    return YES;
}



@end
