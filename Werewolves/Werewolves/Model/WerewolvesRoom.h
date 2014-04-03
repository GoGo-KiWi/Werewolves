//
//  WerewolvesRoom.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WerewolvesPlayer.h"

@interface WerewolvesRoom : NSObject
{
    NSMutableArray *playerArray; // Store the pointers of all players in this room
}
- (void) addPlayer:(WerewolvesPlayer*) player;
- (void) setRole:(WerewolvesPlayer*) player :(enum RoleType) role;
- (NSMutableArray*) getPlayers:(enum RoleType) role;

@end
