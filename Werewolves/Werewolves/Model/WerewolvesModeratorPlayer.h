//
//  WerewolvesModeratorPlayer.h
//  Werewolves
//
//  Created by Zijia Lu on 14-4-18.
//  Copyright (c) 2014年 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WerewolvesMessage.h"
#import "WerewolvesModeratorPlayer.h"
#import "WerewolvesUtility.h"
#import "WerewolvesAppDelegate.h"

@interface WerewolvesModeratorPlayer : NSObject



@property BOOL alive;
@property NSString* playerName;
@property enum RoleType role;
@property int playerId;
@property MCPeerID* peerId;
@property int voteNominate; /* playerId dominated by this player*/
@property NSMutableArray* playerArray;
@property (nonatomic, strong) WerewolvesAppDelegate *appDelegate;

+ (WerewolvesModeratorPlayer*) getInstance;

- (WerewolvesModeratorPlayer*) initWithCoder:(NSCoder *) decoder;
- (void)encodeWithCoder:(NSCoder *) encoder;

- (WerewolvesModeratorPlayer*) init;
- (void) registerPlayer:(NSString*)name;
- (void) joinRoom;
/*
 - (void) sendMessage: (WerewolvesMessage*) msg;
 - (WerewolvesMessage*) receiveMessage;
 */
/*Message send methods*/
/*From moderator to player*/
- (void) sendPeopleInfo;

- (void) createVote;
- (void) reVote;
- (void) sendVoteResult;

- (void) sendDeathResult:(int) playerId;
- (void) sendTerminateResult:(int) wolfWin;

/*From player to moderator*/
- (void) sendVoteNominate:(int) playerId;

/*Text Chat*/
- (void) sendTextChat:(NSString*) msg;

/*Message receive method is didReceiveDataWithNotification*/

/*
 TODO
 0. Register
 1. Join Room
 2. Send Message [Name, Vote]
 3. Receive Message
 */


@end

static WerewolvesModeratorPlayer* playerinstance = nil;
