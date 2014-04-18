//
//  WerewolvesPlayer.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WerewolvesMessage.h"
#import "WerewolvesPlayer.h"
#import "WerewolvesUtility.h"
#import "WerewolvesAppDelegate.h"

@interface WerewolvesPlayer : NSObject
{
    /*
    BOOL alive;
    NSString *playerName;
    enum RoleType role;
    int playerId;
    int peerId;
    
    NSMutableArray* playerArray;
     */
}
@property BOOL alive;
@property NSString* playerName;
@property enum RoleType role;
@property int playerId;
@property MCPeerID* peerId;
@property int voteNominate; /* playerId dominated by this player*/
@property NSMutableArray* playerArray;
@property (nonatomic, strong) WerewolvesAppDelegate *appDelegate;

- (WerewolvesPlayer*) initWithCoder:(NSCoder *) decoder;
- (void)encodeWithCoder:(NSCoder *) encoder;

- (WerewolvesPlayer*) init;
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
- (void) receiveData:(NSNotification *)notification;

/*Message receive method is didReceiveDataWithNotification*/

/*
 TODO
 0. Register
 1. Join Room
 2. Send Message [Name, Vote]
 3. Receive Message
 */

@end
