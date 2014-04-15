//
//  WerewolvesModerator.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WerewolvesPlayer.h"

@interface WerewolvesModerator : WerewolvesPlayer
{
    WerewolvesMessage* attackedByWolf;
}

@property (strong, nonatomic) WerewolvesRoom *room;

@end
