//
//  WerewolvesPlayer.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WerewolvesMessage.h"

enum RoleType
{
    Moderator, Peasant, Wolf, FortuneTeller, Witch, Undefined
};

@interface WerewolvesPlayer : NSObject
{
    BOOL alive;
    NSString *playerName;
    enum RoleType role;
    int playerId;
}

- (void) registerPlayer: (NSString*)name;
- (void) joinRoom;
- (void) sendMessage: (WerewolvesMessage*) msg;
- (WerewolvesMessage*) receiveMessage;

- (void) setDead;
- (void) setAlive;
- (BOOL) isAlve;

- (void) setPlayerName: (NSString*) name;
- (NSString*) getPlayerName;

- (void) setRole: (enum RoleType) role;
- (enum RoleType) getRole;

- (void) setPlayerId: (int) playerId;
- (int) getPlayerId;

/*
 TODO
 0. Register
 1. Join Room
 2. Send Message [Name, Vote]
 3. Receive Message
 */

@end
