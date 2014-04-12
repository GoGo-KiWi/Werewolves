//
//  WerewolvesRoom.m
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesRoom.h"

@implementation WerewolvesRoom

+ (WerewolvesRoom*) getInstance {
    if (instance == nil) {
        instance = [[WerewolvesRoom alloc] init];
    }
    return instance;
}

- (WerewolvesRoom*) init {
    self = [super init];
    instance = self;
    
    playerArray = [NSMutableArray array]; // Store the pointers of ALL players in this room
    
    peasantArray = [NSMutableArray array];
    wolfArray = [NSMutableArray array];
    oracleArray = [NSMutableArray array];
    witchArray = [NSMutableArray array];
    moderatorArray = [NSMutableArray array];
    
    return self;
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
        case Oracle:
            [oracleArray addObject:player];
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
        case Oracle:
            for (WerewolvesPlayer* curPlayer in oracleArray) {
                if (curPlayer == player) {
                    [oracleArray removeObject:curPlayer];
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

- (int) generateRandomRoles {
    /* This function randomly generate roles for players and update their array. Return -1 on failure and 0 on success */
    int numPlayer = (int)[playerArray count];
    
    if (numPlayer < 5) {
        // Too few player, cannot proceed
        return -1;
    }
    int numModerator = 1;
    int numOracle = 1;
    int numWitch = 1;
    int numWolf = (numPlayer - numModerator - numOracle - numWitch)/2;
    int numPeasant = numPlayer - numModerator - numOracle - numWitch - numWolf;
    
    
    int* tempArray = malloc(numPlayer*sizeof(int));
    
    for (int i = 0; i < numPlayer; i++) {
        tempArray[i] = i;
    }
    
    // Suppose index 0 correspons to moderator and we do not need to modify or initlize moderator. We do not change this role
    // Shuffle position from 1 to last elements
    for (int i = 2; i < numPlayer; i++) {
        int swapPos = arc4random() % (i - 1) + 1;
        int tempValue = tempArray[i];
        tempArray[i] = tempArray[swapPos];
        tempArray[swapPos] = tempValue;
    }
    
    // Assign in order for different roles excpet for the moderator, whose role should already be initlized
    [self setRole:playerArray[numModerator + numOracle - 1] :Oracle];
    [self setRole:playerArray[numModerator + numOracle + numWitch - 1] :Witch];
    
    for (int i = numModerator + numOracle + numWitch; i < numModerator + numOracle + numWitch + numWolf; i++) {
        [self setRole:playerArray[i] :Wolf];
    }
    
    for (int i = numModerator + numOracle + numWitch + numWolf; i < numModerator + numOracle + numWitch + numWolf + numPeasant; i++) {
        [self setRole:playerArray[i] :Peasant];
    }
    
    free(tempArray);
    
    return 0;
}

@end
