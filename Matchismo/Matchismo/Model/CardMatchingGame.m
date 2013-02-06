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
@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init ];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        NSLog(@"A match was found!");
                        NSLog(@"Making this card unplayable.");
                        card.unplayable = YES;
                        NSLog(@"Making the other card unplayable.");
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    }
                    else {
                        NSLog(@"No match found. :-(");
                        NSLog(@"Making other card face down.");
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        if (card.isFaceUp) {
            NSLog(@"Making this card face down.");
        }
        else {
            NSLog(@"Making this card face up.");
        }
        card.faceUp = !card.isFaceUp;

    }
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
