//
//  IntroScene.m
//  TestGame
//
//  Created by Jieming Mao on 14-7-15.
//  Copyright Jieming Mao 2014年. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "MainGameScene.h"
#import "Mosquito.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Game Title
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"FaceSlapper v2.0" fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    // Freestyle Button
    CCButton *freestyleButton = [CCButton buttonWithTitle:@"Freestyle" fontName:@"Verdana-Bold" fontSize:18.0f];
    freestyleButton.positionType = CCPositionTypeNormalized;
    freestyleButton.position = ccp(0.5f, 0.35f);
    [freestyleButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:freestyleButton];
    
    // Ranking Button
    CCButton *rankingButton = [CCButton buttonWithTitle:@"Ranking Game" fontName:@"Verdana-Bold" fontSize:18.0f];
    rankingButton.positionType = CCPositionTypeNormalized;
    rankingButton.position = ccp(0.5f, 0.3f);
    [rankingButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:rankingButton];
    
    // Mosquito Button
    CCButton *mosButton = [CCButton buttonWithTitle:@"Mosquito" fontName:@"Verdana-Bold" fontSize:18.0f];
    mosButton.positionType = CCPositionTypeNormalized;
    mosButton.position = ccp(0.5f, 0.25f);
    [mosButton setTarget:self selector:@selector(onSpinningClicked2:)];
    [self addChild:mosButton];


    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[MainGameScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

- (void)onSpinningClicked2:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[Mosquito scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
