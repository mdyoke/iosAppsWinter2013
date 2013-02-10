//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kevin Peters on 2/5/13.
//  Copyright (c) 2013 Space Monkey Apps, Inc. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSString* statusText;
@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame


- (NSMutableArray *) cards
{
    if (!_cards)
    {
        _cards = [[NSMutableArray alloc] init ];
    }
    return _cards;
}


- (NSString*) statusText
{
    if (!_statusText)
    {
        _statusText = @" ";
    }
    
    return _statusText;
}


#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1


- (void)flipCardAtIndex:(NSUInteger)index
{
    //
    // Clear the status text.
    //
    self.statusText = @" ";
    
    //
    // Check the parameters.
    //
    Card *card = [self cardAtIndex:index];
    if (!card)
    {
        //
        // No card at the specified index.
        // todo:  Assert false here.
        //
        return;
    }
    
    if (card.isUnplayable)
    {
        //
        // The card is unplayable.
        // todo:  Assert false here.
        //
        return;
    }
    
    if (card.isFaceUp)
    {
        //
        // The card is currently face-up.  All we have to do it turn it face-down.
        //
        card.faceUp = NO;
        return;
    }
    
    //
    // At this point we know that the card is playable and face-down.
    //
    for (Card *otherCard in self.cards) {
        if (otherCard.isFaceUp && !otherCard.isUnplayable) {
            int matchScore = [card match:@[otherCard]];
            if (matchScore)
            {
                //
                // A match was found.
                //
                card.unplayable = YES;
                otherCard.unplayable = YES;
                NSUInteger points = matchScore * MATCH_BONUS;
                self.score += points;
                self.statusText = [NSString stringWithFormat:@"Matched %@ and %@ for %d points!", card.contents, otherCard.contents, points];
            }
            else
            {
                //
                // No match found.
                //
                otherCard.faceUp = NO;
                NSUInteger points = MISMATCH_PENALTY;
                self.score -= points;
                self.statusText = [NSString stringWithFormat:@"%@ and %@ do not match!  %d point penalty!", card.contents, otherCard.contents, points];
            }
            break;
        }
    }
    self.score -= FLIP_COST;
    card.faceUp = YES;
}


- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            }
            else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}


@end
