//
//  WerewolvesPlayer.m
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesPlayer.h"

@implementation WerewolvesPlayer

- (void) setDead {
    self->alive = NO;
}

- (void) setAlive {
    self->alive = YES;
}

@end
