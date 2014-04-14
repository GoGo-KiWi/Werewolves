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
    _playerArray = [[NSMutableArray alloc] init];
    /*
    playerArray = [NSMutableArray array]; // Store the pointers of ALL players in this room
    
    _playerArray = [NSMutableArray array]; // Store the pointers of ALL players in this room
    
    _peasantArray = [NSMutableArray array];
    _wolfArray = [NSMutableArray array];
    _oracleArray = [NSMutableArray array];
    _witchArray = [NSMutableArray array];
    _moderatorArray = [NSMutableArray array];
    
    
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    /*init a moderator*/
    WerewolvesPlayer* moderatorPtr = [[WerewolvesPlayer alloc] init];
    [moderatorPtr setRole:Moderator];
    [self addPlayer:moderatorPtr];
    
    /*For DEBUG*/
    WerewolvesPlayer* witchPtr = [[WerewolvesPlayer alloc] init];
    [witchPtr setRole:Witch];
    [self addPlayer:witchPtr];
    [self printPlayers];
    return self;
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
            for (WerewolvesPlayer* curPlayer in _moderatorArray) {
                if (curPlayer == player) {
                    [_moderatorArray removeObject:curPlayer];
                }
            }
            break;
        case Peasant:
            for (WerewolvesPlayer* curPlayer in _peasantArray) {
                if (curPlayer == player) {
                    [_peasantArray removeObject:curPlayer];
                }
            }
            break;
        case Wolf:
            for (WerewolvesPlayer* curPlayer in _wolfArray) {
                if (curPlayer == player) {
                    [_wolfArray removeObject:curPlayer];
                }
            }
            break;
        case Oracle:
            for (WerewolvesPlayer* curPlayer in _oracleArray) {
                if (curPlayer == player) {
                    [_oracleArray removeObject:curPlayer];
                }
            }
            break;
        case Witch:
            for (WerewolvesPlayer* curPlayer in _witchArray) {
                if (curPlayer == player) {
                    [_witchArray removeObject:curPlayer];
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
    [self setRole:_playerArray[numModerator + numOracle - 1] :Oracle];
    [self setRole:_playerArray[numModerator + numOracle + numWitch - 1] :Witch];
    
    for (int i = numModerator + numOracle + numWitch; i < numModerator + numOracle + numWitch + numWolf; i++) {
        [self setRole:_playerArray[i] :Wolf];
    }
    
    for (int i = numModerator + numOracle + numWitch + numWolf; i < numModerator + numOracle + numWitch + numWolf + numPeasant; i++) {
        [self setRole:_playerArray[i] :Peasant];
    }
    
    free(tempArray);
    
    return 0;
}


- (void) sendPeopleInfo {
     NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
     NSError *error;
    
    /*Send enum*/
    enum MessageType messageType = SendPlayerInfo;
    NSNumber* messageTypePtr = [[NSNumber alloc] initWithInt:(int)messageType];
    NSData *dataPart1 = [NSKeyedArchiver archivedDataWithRootObject:messageTypePtr];
    [_appDelegate.peer.session sendData:dataPart1
                                toPeers:allPeers
                                withMode:MCSessionSendDataReliable
                                error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }

    /*Send player info by sending playerArray*/
    NSData *dataPart2 = [NSKeyedArchiver archivedDataWithRootObject:_playerArray];
    [_appDelegate.peer.session sendData:dataPart2
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void) createVote {
    /*Send enum*/
    enum MessageType messageType = CreateVote;
}

- (void) sendVoteResult {
    /*Send enum*/
    enum MessageType messageType = SendVoteResult;
    
    /*Send NSMutableArray of vote action*/
}

- (void) sendDeathResult {
    /*Send enum*/
    enum MessageType messageType = SendVoteResult;
    
    /*send death playerObject*/
}

- (void) sendTerminateResult {
    /*Send enum*/
    enum MessageType messageType = SendTerminateResult;
    
    /*send BOOL about who win*/
}

- (void) receiveMsg {
    /*receive player's vote dominate*/
    // check if received "SendVoteNominate"
}

/*For DEBUG*/
- (void) printPlayers {
    NSLog(@"Total Player number=%d\n", [_playerArray count]);
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
