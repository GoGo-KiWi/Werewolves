//
//  WerewolvesMessage.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "WerewolvesPlayer.h"

enum MessageType {
    Name, Role, Vote, VoteResult, DeathResult, Terminate
};

@interface WerewolvesMessage : NSObject
{
    enum MessageType messageType;
    NSString* messageContent;
    /* Should we use player pointers or player ID to distinguish? Maybe ID is better */
    int senderId;
    int receiverId;
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
