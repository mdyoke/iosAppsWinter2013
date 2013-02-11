//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kevin Peters on 2/5/13.
//  Copyright (c) 2013 Space Monkey Apps, Inc. All rights reserved.
//

#import "CardMatchingGame.h"


////////////////////////////////////////////////////////////////////////////////
@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSString* statusText;
@property (strong, nonatomic) NSMutableArray* cards; // of Card
@property (nonatomic, getter=isGameInProgress) BOOL gameInProgress;
@end


////////////////////////////////////////////////////////////////////////////////
@implementation CardMatchingGame


//
// Designated initializer.
//
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self)
    {
        //
        // Initialize self.cards.
        //
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                self.cards[i] = card;
            }
            else
            {
                // Could not draw a card from the deck.
                // todo: Assert here.
                self = nil;
                break;
            }
        }
        
        //
        // No flips have happened yet.
        //
        self.gameInProgress = NO;
        
        //
        // The default match mode will be 2 cards.
        //
        self.matchMode = MatchMode2Card;
    }
    
    return self;
}


////////////////////////////////////////////////////////////////////////////////
//
// Property Accessors
//
////////////////////////////////////////////////////////////////////////////////

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


////////////////////////////////////////////////////////////////////////////////
//
// Methods
//
////////////////////////////////////////////////////////////////////////////////


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
    // If the game wasn't started before, it certainly has now.
    //
    self.gameInProgress = YES;
    
    //
    // At this point, we know that the specified card is playable and face-down.
    // Let's turn it over.
    //
    card.faceUp = YES;
    self.score -= FLIP_COST;
    
    NSMutableArray* faceUpCards = [[NSMutableArray alloc] init];
    NSMutableArray* faceUpCardsContents = [[NSMutableArray alloc] init];
    for (Card* curCard in self.cards)
    {
        if (curCard.isFaceUp && !curCard.isUnplayable)
        {
            [faceUpCards addObject:curCard];
            [faceUpCardsContents addObject:curCard.contents];
        }
    }
    NSString* faceUpCardsString = [faceUpCardsContents componentsJoinedByString:@", "];
    
    NSUInteger faceUpCardsNeeded = (self.matchMode == MatchMode2Card? 2: 3);
    
    if (faceUpCardsNeeded == [faceUpCards count]) {
        
        // Remove a single card from the container of face-up cards.  This card will be responsible
        // for evaluating the match.
        Card* lastCard = faceUpCards[faceUpCards.count - 1];
        [faceUpCards removeLastObject];
        NSUInteger matchScore = [lastCard match:faceUpCards];
        if (matchScore > 0)
        {
            // A match was found.
            
            // Make all cards involved unplayable.
            lastCard.unplayable = YES;
            for (Card* otherCard in faceUpCards) {
                otherCard.unplayable = YES;
            }
            
            // Update the score.
            NSUInteger points = matchScore * MATCH_BONUS;
            self.score += points;
            
            // Set the status text.
            self.statusText = [NSString stringWithFormat:@"Matched for %d points: %@.", points, faceUpCardsString];
        }
        else
        {
            // No match was found.
            
            // Make all other cards face-down.
            for (Card* otherCard in faceUpCards) {
                otherCard.faceUp = NO;
            }
            
            // Update the score.
            NSUInteger points = MISMATCH_PENALTY;
            self.score -= points;
            
            // Set the status text.
            self.statusText = [NSString stringWithFormat:@"No match!  %d point penalty: %@", points, faceUpCardsString];
        }
    }    
}


- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


@end
