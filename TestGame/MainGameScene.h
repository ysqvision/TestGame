//
//  MainGameScene.h
//  TestGame
//
//  Created by Jieming Mao on 14-7-15.
//  Copyright 2014年 Jieming Mao. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>


@interface MainGameScene : CCScene

+ (MainGameScene *)scene;
- (id)init;

@property (strong, nonatomic) CMMotionManager *motionManager;

@property (assign) SystemSoundID faceSlapSound;

@end
