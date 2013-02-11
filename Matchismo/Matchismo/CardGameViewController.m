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

////////////////////////////////////////////////////////////////////////////////
@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSegmentedControl;
@property (strong, nonatomic) UIImage* cardBackImage;

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
    
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)setMatchModeSegmentedControl:(UISegmentedControl *)matchModeSegmentedControl
{
    _matchModeSegmentedControl = matchModeSegmentedControl;
    [self updateUIMatchModeSegmentControl];
}

- (UIImage*)cardBackImage
{
    if (!_cardBackImage) {
        _cardBackImage = [UIImage imageNamed:@"wtf.jpg"];
    }
    return _cardBackImage;
}


////////////////////////////////////////////////////////////////////////////////
//
// Actions
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

- (IBAction)onMatchModeChanged:(UISegmentedControl *)sender {
    NSUInteger selectedIndex = self.matchModeSegmentedControl.selectedSegmentIndex;
    MatchMode newMatchMode = (selectedIndex == 0? MatchMode2Card: MatchMode3Card);
    self.game.matchMode = newMatchMode;
    
}

////////////////////////////////////////////////////////////////////////////////
//
// Helper Methods
//
////////////////////////////////////////////////////////////////////////////////


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


- (void)updateUI
{
    //
    // Update the state of each card button.
    //
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
        
        cardButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        
        UIImage* backImage = nil;
        if (!card.isUnplayable && !card.isFaceUp) {
            backImage = self.cardBackImage;
        }
        
        [cardButton setImage:backImage forState:UIControlStateNormal];
        
    }
    
    //
    // Update the state of the other non-card controls in the view.
    //
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.statusTextLabel.text = self.game.statusText;
    self.matchModeSegmentedControl.enabled = !self.game.isGameInProgress;
    [self updateUIMatchModeSegmentControl];
}


- (void) updateUIMatchModeSegmentControl
{
    MatchMode currentMatchMode = self.game.matchMode;
    NSUInteger selectedSegmentIndex = (currentMatchMode == MatchMode2Card? 0: 1);
    self.matchModeSegmentedControl.selectedSegmentIndex = selectedSegmentIndex;
}



@end
