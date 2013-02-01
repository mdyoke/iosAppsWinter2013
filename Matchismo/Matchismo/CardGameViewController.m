//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kevin Peters on 1/31/13.
//  Copyright (c) 2013 Space Monkey Apps, Inc. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"


@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck* deck;

@end

@implementation CardGameViewController

////////////////////////////////////////////////////////////////////////////////
//
// Instance Properties
//
////////////////////////////////////////////////////////////////////////////////

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount updated to %d", self.flipCount);
}

- (PlayingCardDeck*) deck
{
    if (_deck == nil) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    
    return _deck;
}


////////////////////////////////////////////////////////////////////////////////
//
// Instance Methods
//
////////////////////////////////////////////////////////////////////////////////

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    
    if (sender.selected)
    {
        NSString* cardTitle = [[self.deck drawRandomCard] contents];
        [sender setTitle:cardTitle forState:UIControlStateSelected];
    }
    
    self.flipCount++;
}

@end
