//
//  WerewolvesPlayer.m
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesPlayer.h"

@implementation WerewolvesPlayer

- (WerewolvesPlayer*) init {
    self =[super init];
    
    alive = YES;
    playerName = [[NSString alloc] init];
    role = UndefinedRole;
    playerId = -1;
    
    return  self;
}

- (void) setDead {
    self->alive = NO;
}

- (void) setAlive {
    self->alive = YES;
}

- (BOOL) isAlve {
    return self->alive;
}

- (void) setPlayerName: (NSString*) name {
    self->playerName = name;
}

- (NSString*) getPlayerName {
    return self->playerName;
}

- (void) setRole: (enum RoleType) role {
    self->role = role;
}

- (enum RoleType) getRole {
    return self->role;
}

- (void) setPlayerId: (int) playerId {
    self->playerId = playerId;
}

- (int) getPlayerId {
    return self->playerId;
}

@end
