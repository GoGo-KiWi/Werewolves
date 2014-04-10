//
//  WerewolvesRoom.m
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesRoom.h"

@implementation WerewolvesRoom

- (void) initArray {
    playerArray = [NSMutableArray array]; // Store the pointers of ALL players in this room
    
    peasantArray = [NSMutableArray array];
    wolfArray = [NSMutableArray array];
    fortuneTellerArray = [NSMutableArray array];
    witchArray = [NSMutableArray array];
    moderatorArray = [NSMutableArray array];
}

- (void) addPlayer:(WerewolvesPlayer*) player {
    [playerArray addObject:player];
    [self addPlayerIntoRoleArray:player];
//    [self performSelector:@selector(addPlayerIntoRoleArray:) withObject:player];
}

- (void) setRole:(WerewolvesPlayer*) player :(enum RoleType) role {
//    [self performSelector:@selector(removePlayerFromRoleArray:) withObject:player];
    [self removePlayerFromRoleArray:player];
    [player setRole:role];
    [self addPlayerIntoRoleArray:player];
//    [self performSelector:@selector(addPlayerIntoRoleArray:) withObject:player];
}

- (void) addPlayerIntoRoleArray:(WerewolvesPlayer*) player {
    switch ([player getRole]) {
        case Moderator:
            [moderatorArray addObject:player];
            break;
        case Peasant:
            [peasantArray addObject:player];
            break;
        case Wolf:
            [wolfArray addObject:player];
            break;
        case FortuneTeller:
            [fortuneTellerArray addObject:player];
            break;
        case Witch:
            [witchArray addObject:player];
            break;
        default:
            break;
    }
}

- (void) removePlayerFromRoleArray:(WerewolvesPlayer*) player {
    switch ([player getRole]) {
        case Moderator:
            for (WerewolvesPlayer* curPlayer in moderatorArray) {
                if (curPlayer == player) {
                    [moderatorArray removeObject:curPlayer];
                }
            }
            break;
        case Peasant:
            for (WerewolvesPlayer* curPlayer in peasantArray) {
                if (curPlayer == player) {
                    [peasantArray removeObject:curPlayer];
                }
            }
            break;
        case Wolf:
            for (WerewolvesPlayer* curPlayer in wolfArray) {
                if (curPlayer == player) {
                    [wolfArray removeObject:curPlayer];
                }
            }
            break;
        case FortuneTeller:
            for (WerewolvesPlayer* curPlayer in fortuneTellerArray) {
                if (curPlayer == player) {
                    [fortuneTellerArray removeObject:curPlayer];
                }
            }
            break;
        case Witch:
            for (WerewolvesPlayer* curPlayer in witchArray) {
                if (curPlayer == player) {
                    [witchArray removeObject:curPlayer];
                }
            }
            break;
        default:
            break;
    }
}

- (NSMutableArray*) getPlayers:(enum RoleType) role {
    NSMutableArray* result = [NSMutableArray array];
    
    for (WerewolvesPlayer* player in playerArray) { // Not sure, should I use * or ** here if array stores pointers?????
        if ([player getRole] == role) {
            [result addObject:player];
        }
    }
    
    return result;
}

- (WerewolvesPlayer*) getPlayer:(int) playerId {
    for (WerewolvesPlayer* player in playerArray) {
        if ([player getPlayerId] == playerId) {
            return player;
        }
    }
    
    return NULL;
}

- (void) generateRandomRoles {
    int numPlayer = (int)[playerArray count];
    int numModerator = 1;
    int numFortuneTeller = 1;
    int numWitch = 1;
    int numWolf = (numPlayer - numModerator - numFortuneTeller - numWitch)/2;
    int numPeasant = numPlayer - numModerator - numFortuneTeller - numWitch - numWolf;
    
    /*
    NSMutableArray* tempArray = [NSMutableArray arrayWithCapacity:numPlayer];
    
    for (NSInteger i = 0; i < numPlayer; i++) {
        [tempArray addObject:i];
    }
    */
    
}

@end
