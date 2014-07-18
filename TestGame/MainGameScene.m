//
//  MainGameScene.m
//  TestGame
//
//  Created by Jieming Mao on 14-7-15.
//  Copyright 2014年 Jieming Mao. All rights reserved.
//

#import "MainGameScene.h"
#import "IntroScene.h"


@implementation MainGameScene
{
    CCSprite *_sprite;
}

+ (MainGameScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Add a sprite
    _sprite = [CCSprite spriteWithImageNamed:@"mama.png"];
    _sprite.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:_sprite];
    
    // Animate sprite with action
    CCActionRotateBy* actionSpin = [CCActionRotateBy actionWithDuration:0.5f angle:360];
    [_sprite runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
    
    // Animate sprite with scale
    CCActionScaleTo* scaleBig=[CCActionScaleTo actionWithDuration:20.0f scale:2];
    CCActionScaleTo* scaleSmall=[CCActionScaleTo actionWithDuration:20.0f scale:1];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    // Add sound
    NSString *faceSlapPath = [[NSBundle mainBundle] pathForResource:@"face_slap_sound_effect" ofType:@"wav"];
	NSURL *faceSlapURL = [NSURL fileURLWithPath:faceSlapPath];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)faceSlapURL, &_faceSlapSound);

    // Test Acceleration
    __block BOOL readyToSlap = true;
    __block BOOL previousDirection = true;
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = .2;
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        
        //user acceleration
        double zAcce = motion.userAcceleration.z;
        
        NSLog(@"Z Accer = %f", zAcce);
        if (!readyToSlap) {
            BOOL currentDirection = (zAcce >= 0);
            if (currentDirection != previousDirection) {
                previousDirection = currentDirection;
                readyToSlap = true;
            }
        }
        if (readyToSlap) {
            NSLog(@"inside ready to slap");
            if (fabs(zAcce) > 0.2) {
                
                readyToSlap = false;
                [_sprite runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
                AudioServicesPlaySystemSound(self.faceSlapSound);
                NSLog(@"slapped!!");
                previousDirection = (zAcce >= 0);
                
            }
        }
        if(error){
            NSLog(@"%@", error);
        }
    }];

    //done
	return self;
}

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    // Log touch location
    CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
    // Move our sprite to touch location
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchLoc];
    [_sprite runAction:actionMove];
}

@end