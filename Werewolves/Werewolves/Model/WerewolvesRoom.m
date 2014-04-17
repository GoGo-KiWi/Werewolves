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
    _playerArray = [NSMutableArray array]; // Store the pointers of ALL players in this room
    _peasantArray = [NSMutableArray array];
    _wolfArray = [NSMutableArray array];
    _oracleArray = [NSMutableArray array];
    _witchArray = [NSMutableArray array];
    _moderatorArray = [NSMutableArray array];
    /*init a moderator*/
    WerewolvesPlayer* moderatorPtr = [[WerewolvesPlayer alloc] init];
    [moderatorPtr setRole:Moderator];
    [self addPlayer:moderatorPtr];
    
    /*For DEBUG*/
    /*
    WerewolvesPlayer* undefinePtr1 = [[WerewolvesPlayer alloc] init];
    [self addPlayer:undefinePtr1];
    WerewolvesPlayer* undefinePtr2 = [[WerewolvesPlayer alloc] init];
    [self addPlayer:undefinePtr2];
    WerewolvesPlayer* undefinePtr3 = [[WerewolvesPlayer alloc] init];
    [self addPlayer:undefinePtr3];
    [self printPlayers];
     */
    return self;
}

- (void) resetArray {
    while ([_playerArray count] > 1) {
        [self removePlayerFromRoleArray:_playerArray[1]];
        [_playerArray removeObjectAtIndex:1];
    }
}

- (void) addPlayer:(WerewolvesPlayer*) player {
    [player setPlayerId:(int)[_playerArray count]];
    [_playerArray addObject:player];
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
    switch ([player role]) {
        case Moderator:
            [_moderatorArray addObject:player];
            break;
        case Peasant:
            [_peasantArray addObject:player];
            break;
        case Wolf:
            [_wolfArray addObject:player];
            break;
        case Oracle:
            [_oracleArray addObject:player];
            break;
        case Witch:
            [_witchArray addObject:player];
            break;
        default:
            break;
    }
}

- (void) removePlayerFromRoleArray:(WerewolvesPlayer*) player {
    switch ([player role]) {
        case Moderator:
            for (int i = 0; i < [_moderatorArray count]; i++) {
                if (_moderatorArray[i] == player) {
                    [_moderatorArray removeObjectAtIndex:i];
                    i--;
                }
            }
            break;
        case Peasant:
            for (int i = 0; i < [_peasantArray count]; i++) {
                if (_peasantArray[i] == player) {
                    [_peasantArray removeObjectAtIndex:i];
                    i--;
                }
            }
            break;
        case Wolf:
            for (int i = 0; i < [_wolfArray count]; i++) {
                if (_wolfArray[i] == player) {
                    [_wolfArray removeObjectAtIndex:i];
                    i--;
                }
            }
            break;
        case Oracle:
            for (int i = 0; i < [_oracleArray count]; i++) {
                if (_oracleArray[i] == player) {
                    [_oracleArray removeObjectAtIndex:i];
                    i--;
                }
            }
            break;
        case Witch:
            for (int i = 0; i < [_witchArray count]; i++) {
                if (_witchArray[i] == player) {
                    [_witchArray removeObjectAtIndex:i];
                    i--;
                }
            }
            break;
        default:
            break;
    }
}

- (NSMutableArray*) getPlayers:(enum RoleType) role {
    NSMutableArray* result = [NSMutableArray array];
    
    for (WerewolvesPlayer* player in _playerArray) { // Not sure, should I use * or ** here if array stores pointers?????
        if ([player role] == role) {
            [result addObject:player];
        }
    }
    
    return result;
}

- (WerewolvesPlayer*) getPlayer:(int) playerId {
    for (WerewolvesPlayer* player in _playerArray) {
        if ([player playerId] == playerId) {
            return player;
        }
    }
    
    return NULL;
}

- (int) generateRandomRoles {
    /* This function randomly generate roles for players and update their array. Return -1 on failure and 0 on success */
    int numPlayer = (int)[_playerArray count];
    if (numPlayer < 5) {
        // Too few player, cannot proceed
        return -1;
    }
    int numModerator = 1;
    int numOracle = 1;
    int numWitch = 1;
    int numWolf = (numPlayer - numModerator - numOracle - numWitch)/2;
    int numPeasant = numPlayer - numModerator - numOracle - numWitch - numWolf;
    
    /*
    [self.peasantArray removeAllObjects];
    [self.wolfArray removeAllObjects];
    [self.oracleArray removeAllObjects];
    [self.witchArray removeAllObjects];
    
    NSMutableArray *tempArray = [self.playerArray mutableCopy];
    [tempArray removeObjectAtIndex:0];
    // Found a shuffle algorithm from stackoverflow...
    for (int i = 0; i < tempArray.count; i++) {
        int randomInt1 = arc4random() % [tempArray count];
        int randomInt2 = arc4random() % [tempArray count];
        [tempArray exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
    }
    for (int i = 0; i < numWolf; i++) {
        WerewolvesPlayer *newWolf = [tempArray objectAtIndex:i];
        [newWolf setRole:Wolf];
        [self addPlayerIntoRoleArray:newWolf];
    }
    for (int i = numWolf; i < numWolf + numPeasant; i++) {
        WerewolvesPlayer *newPeasant = [tempArray objectAtIndex:i];
        [newPeasant setRole:Peasant];
        [self addPlayerIntoRoleArray:newPeasant];
    }
    WerewolvesPlayer *newOracle = [tempArray objectAtIndex:numWolf + numPeasant];
    [newOracle setRole:Oracle];
    [self addPlayerIntoRoleArray:newOracle];
    WerewolvesPlayer *newWitch = [tempArray objectAtIndex:numWolf + numPeasant + 1];
    [newWitch setRole:Witch];
    [self addPlayerIntoRoleArray:newWitch];
    */
    
    
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
    [self setRole:_playerArray[tempArray[numModerator + numOracle - 1]] :Oracle];
    [self setRole:_playerArray[tempArray[numModerator + numOracle + numWitch - 1]] :Witch];
    
    for (int i = numModerator + numOracle + numWitch; i < numModerator + numOracle + numWitch + numWolf; i++) {
        [self setRole:_playerArray[tempArray[i]] :Wolf];
    }
    
    for (int i = numModerator + numOracle + numWitch + numWolf; i < numModerator + numOracle + numWitch + numWolf + numPeasant; i++) {
        [self setRole:_playerArray[tempArray[i]] :Peasant];
    }
    
    free(tempArray);
    
    
    return 0;
}

- (int) getVoteResult {
    /* Return vote result player's Id. Return -1 on tie or no result*/
    int resultPlayerId = -1;
    int resultCount = -1;
    BOOL isTie = NO;
    
    for (WerewolvesPlayer* candidatePlayer in _playerArray) {
        int candidateCount = 0;
        
        if ([candidatePlayer role] == Moderator) {
            continue;
        }
        
        for (WerewolvesPlayer* currentPlayer in _playerArray) {
            if ([currentPlayer role] == Moderator) {
                continue;
            }
            else {
                if ([currentPlayer voteNominate] == [candidatePlayer playerId]) {
                    candidateCount++;
                }
            }
        }
        
        if (candidateCount == resultCount) {
            isTie = YES;
        }
        else if (candidateCount > resultCount) {
            isTie = NO;
            resultPlayerId = [candidatePlayer playerId];
            resultCount = candidateCount;
        }
    }
    
    if (isTie) {
        return -1;
    }
    else {
        return resultPlayerId;
    }
}

- (void) resetVoteNominate {
    for (WerewolvesPlayer* playerPtr in _playerArray) {
        [playerPtr setVoteNominate:-1];
    }
}

- (void) setVoteNominate:(WerewolvesPlayer*) player :(int) voteNominate {
    [player setVoteNominate:voteNominate];
}

- (int) checkTerminate {
    /* Return 3 on tie. Return 2 if village win. Return 1 if wolf won. Retrun 0 if game continue*/
    int numAliveWolf = 0;
    int numAlivePeasant = 0;
    
    for (WerewolvesPlayer* playerPtr in _wolfArray) {
        if (playerPtr.alive == YES) {
            numAliveWolf++;
        }
    }
    
    for (WerewolvesPlayer* playerPtr in _peasantArray) {
        if (playerPtr.alive == YES) {
            numAlivePeasant++;
        }
    }
    
    if (numAlivePeasant > 0 && numAliveWolf > 0) {
        /*Game continue*/
        return 0;
    }
    
    if (numAliveWolf > 0) {
        /*Wolf won*/
        return 1;
    }
    
    if (numAlivePeasant > 0) {
        /*Villager win*/
        return 2;
    }
    
    /*Tie*/
    return 3;
}

/*For DEBUG*/
- (void) printPlayers {
    NSLog(@"hhh");
    for (WerewolvesPlayer* playerPtr in _playerArray) {
        NSLog(@"Player#%d %@ with role:", [playerPtr playerId], [playerPtr playerName]);
        switch ([playerPtr role]) {
            case Moderator:
                NSLog(@"Moderator");
                break;
            case Witch:
                NSLog(@"Witch");
                break;
            case Oracle:
                NSLog(@"Oracle");
                break;
            case Peasant:
                NSLog(@"Peasant");
                break;
            case Wolf:
                NSLog(@"Wolf");
                break;
            case UndefinedRole:
                NSLog(@"UndefinedRole");
                break;
            default:
                break;
        }
    }
}

@end
