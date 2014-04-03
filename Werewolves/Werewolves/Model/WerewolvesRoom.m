//
//  WerewolvesRoom.m
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesRoom.h"

@implementation WerewolvesRoom

- (void) addPlayer:(WerewolvesPlayer*) player {
    [playerArray addObject:player];
}

- (void) setRole:(WerewolvesPlayer*) player :(enum RoleType) role {
    player->role = role;
}

- (NSMutableArray*) getPlayers:(enum RoleType) role {
    NSMutableArray* result = [NSMutableArray array];
    
    for (WerewolvesPlayer* player in playerArray) { // Not sure, should I use * or ** here if array stores pointers?????
        if (player->role == role) {
            [result addObject:player];
        }
    }
    
    return result;
}


@end
