//
//  WerewolvesMessage.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>

enum MessageType {
    /* Maybe using a single message to transmit all player info is clearer. by Cary*/
    
    /*From moderator to player*/
    SendPlayerInfo, /*All players' name, id, life status. Your name, id, role*/
    CreateVote, /*No follwing info*/
    SendVoteResult, /*Players' ID and their choosing result*/
    SendDeathResult, /*Death person's ID*/
    SendTerminateResult, /*Which side won*/
    
    /*From player to moderator*/
    SendVoteNominate
};

@interface WerewolvesMessage : NSObject
{
    enum MessageType messageType;
    NSString* messageContent;
    /* Should we use player pointers or player ID to distinguish? Maybe ID is better */
    int senderId;
    int receiverId;
    NSMutableArray* playerInfo;
}

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
