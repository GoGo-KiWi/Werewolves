//
//  WerewolvesRoom.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WerewolvesPlayer.h"
#import "WerewolvesAppDelegate.h"

@class WerewolvesPlayer;

@interface WerewolvesRoom : NSObject
@property NSMutableArray *playerArray; // Store the pointers of ALL players in this room
@property NSMutableArray* peasantArray;
@property NSMutableArray* wolfArray;
/* For function parameter type consistency, I use array for single roles. by Cary*/
@property NSMutableArray* oracleArray;
@property NSMutableArray* witchArray;
@property NSMutableArray* moderatorArray;
@property (nonatomic, strong) WerewolvesAppDelegate *appDelegate;

+ (WerewolvesRoom*) getInstance;

- (WerewolvesRoom*) init;

- (void) initArray;
- (void) addPlayer:(WerewolvesPlayer*) player;
- (void) setRole:(WerewolvesPlayer*) player :(enum RoleType) role;
- (NSMutableArray*) getPlayers:(enum RoleType) role;
- (WerewolvesPlayer*) getPlayer:(int) playerId;
- (int) generateRandomRoles;
- (int) getVoteResult;

/*Message send methods*/
- (void) sendPeopleInfo;

- (void) createVote;
- (void) sendVoteResult;

- (void) sendDeathResult;
- (void) sendTerminateResult;

/*Message receive methods*/
- (void) receiveMsg;

/*For DEBUG*/
/*Print all player list*/
- (void) printPlayers;
@end

static WerewolvesRoom* instance = nil;