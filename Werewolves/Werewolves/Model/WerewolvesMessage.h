//
//  WerewolvesMessage.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WerewolvesPlayer.h"

enum MessageType {
    /* Maybe using a single message to transmit all player info is clearer. by Cary*/
    
    /*From moderator to player*/
    SendPlayerInfo, /* Use players' info in playerInfo array. Find player's own identity using peerId*/
    CreateVote,
    ReVote,
    SendVoteResult, /*Player display voting result*/
    SendDeathResult, /*Death person's ID is the receiverId*/
    SendTerminateResult, /*Which side won*/
    
    /*From player to moderator*/
    SendVoteNominate /*Player send their own playerId in the playerInfo array object*/
};

@interface WerewolvesMessage : NSObject
@property enum MessageType messageType;
/* Should we use player pointers or player ID to distinguish? Maybe ID is better */
@property int senderId; // THIS PROPERTY MAY BE USELESS!!!!!
@property int receiverId; // -1 for broadcase. THIS PROPERTY MAY BE USELESS!!!!!!!!
@property NSMutableArray* playerInfo;

- (WerewolvesMessage*) initWithCoder:(NSCoder *) decoder;
- (void)encodeWithCoder:(NSCoder *) encoder;
/*
 1. Message type:
    Name
    Role
    Vote
    Voting Result
    Death Result
    Terminate
 2. Message content
 3. Sender
 4. Receiver
 */

-(void) dumpMessage: (NSString *)msg;


@end
