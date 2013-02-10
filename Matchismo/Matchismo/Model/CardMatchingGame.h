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

@interface CardMatchingGame : NSObject

// designated initializer (must be called)
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString* statusText;


@end
