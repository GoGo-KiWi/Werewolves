//
//  WerewolvesMessage.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WerewolvesMessage : NSObject

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
