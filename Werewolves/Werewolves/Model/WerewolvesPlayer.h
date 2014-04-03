//
//  WerewolvesPlayer.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>

enum RoleType
{
    Moderator, Peasant, Wolf, FortuneTeller, Witch, Undefined
};

@interface WerewolvesPlayer : NSObject
{
@public
    BOOL alive;
    NSString *playerName;
    enum RoleType role;
    int playerId;
}

- (void) registerPlayer: (NSString*)name;
- (void) joinRoom;
- (void) sendMessage: (NSString*)msg;
- (NSString*) receiveMessage;

- (void) setDead;
- (void) setAlive;
/*
 TODO
 0. Register
 1. Join Room
 2. Send Message [Name, Vote]
 3. Receive Message
 */

@end
