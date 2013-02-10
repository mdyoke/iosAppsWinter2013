//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kevin Peters on 1/31/13.
//  Copyright (c) 2013 Space Monkey Apps, Inc. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;


- (void)startNewGame;

@end

@implementation CardGameViewController


////////////////////////////////////////////////////////////////////////////////
//
// Instance Properties
//
////////////////////////////////////////////////////////////////////////////////

- (CardMatchingGame*)game
{
    if (!_game)
    {
        [self startNewGame];
    }
    return _game;
}


- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount updated to %d", self.flipCount);
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton* cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];

        // Set the title of the card for the selected and disabled states.
        NSString* cardContents = card.contents;
        [cardButton setTitle:cardContents
                    forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setTitle:cardContents
                    forState:UIControlStateSelected];
        [cardButton setTitle:cardContents
                    forState:UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.statusTextLabel.text = self.game.statusText;
}

////////////////////////////////////////////////////////////////////////////////
//
// Instance Methods
//
////////////////////////////////////////////////////////////////////////////////

- (IBAction)flipCard:(UIButton *)sender
{
    int indexOfSender = [self.cardButtons indexOfObject:sender];
    [self.game flipCardAtIndex:indexOfSender];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)dealNewGame:(UIButton *)sender {
    //
    // Don't bother confirming this action with the user.  Assume that they know
    // what they are doing.
    //
    
    //
    // Just allocate a new game object rather than trying to reset the current one's
    // state.
    //
    [self startNewGame];
    [self updateUI];
}

- (void) startNewGame
{
    PlayingCardDeck* newDeck = [[PlayingCardDeck alloc] init];
    NSUInteger cardCount = [self.cardButtons count];
    
    _game = [[CardMatchingGame alloc] initWithCardCount:cardCount
                                              usingDeck:newDeck];
    
    //
    // Reset all state that is held in this controller.
    //
    self.flipCount = 0;
}

@end
