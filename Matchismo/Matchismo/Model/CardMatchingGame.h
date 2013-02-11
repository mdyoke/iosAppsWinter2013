//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Kevin Peters on 2/5/13.
//  Copyright (c) 2013 Space Monkey Apps, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

typedef enum {
    MatchMode2Card,
    MatchMode3Card
    
} MatchMode;


@interface CardMatchingGame : NSObject

////////////////////////////////////////
// Instance Properties
////////////////////////////////////////
@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString* statusText;
@property (readonly, nonatomic, getter=isGameInProgress) BOOL gameInProgress;
@property (nonatomic) MatchMode matchMode;

////////////////////////////////////////
// Instance Methods
////////////////////////////////////////

// Designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;


- (void)flipCardAtIndex:(NSUInteger)index;


- (Card *)cardAtIndex:(NSUInteger)index;

@end
