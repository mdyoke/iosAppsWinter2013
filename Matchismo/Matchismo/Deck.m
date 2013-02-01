//
//  Deck.m
//  Matchismo
//
//  Created by Kevin Peters on 1/31/13.
//  Copyright (c) 2013 Space Monkey Apps, Inc. All rights reserved.
//

#import "Deck.h"

//------------------------------------------------------------------------------
// Private Interface
//------------------------------------------------------------------------------
@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards;

@end


//------------------------------------------------------------------------------
// Implementation
//------------------------------------------------------------------------------
@implementation Deck

////////////////////////////////////////////////////////////////////////////////
//
// Getter for the cards property that will do lazy instantiation.
//
////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray *)cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}


////////////////////////////////////////////////////////////////////////////////
//
// addCard:atTop
//
////////////////////////////////////////////////////////////////////////////////
- (void)addCard:(id)card
          atTop:(BOOL)atTop
{
    if (atTop)
    {
        [self.cards insertObject:card atIndex:0];
    }
    else
    {
        [self.cards addObject:card];
    }
}

////////////////////////////////////////////////////////////////////////////////
//
// drawRandomCard
//
////////////////////////////////////////////////////////////////////////////////
- (Card *)drawRandomCard
{
    Card* randomCard = nil;
    
    if (self.cards.count)
    {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end