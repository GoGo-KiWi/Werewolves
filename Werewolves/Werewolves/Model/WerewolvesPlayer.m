//
//  WerewolvesPlayer.m
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesPlayer.h"

@implementation WerewolvesPlayer

@synthesize playerName = _playerName;    // Optional for Xcode 4.4+

- (WerewolvesPlayer*) initWithCoder:(NSCoder *) decoder {
    self = [super init]; // Should I call parent's intiWitCoder method? NOT SURE......!!!!!!!!!!!!!
    _alive = [decoder decodeBoolForKey:@"alive"];
    _playerName = [decoder decodeObjectForKey:@"playerName"];
    _role = (enum RoleType)[decoder decodeIntegerForKey:@"role"];
    _playerId = [decoder decodeIntForKey:@"playerId"];
    _peerId = [decoder decodeObjectForKey:@"peerId"];
    _voteNominate = [decoder decodeIntForKey:@"voteNominate"];
    //_playerArray = [decoder decodeObjectForKey:@"playerArray"]; //No need to transmit player object's playerArray. It's for player's own use only
    return self;
}

- (void)encodeWithCoder:(NSCoder *) encoder {
    [encoder encodeBool:_alive forKey:@"alive"];
    [encoder encodeObject:_playerName forKey:@"playerName"];
    [encoder encodeInt:_role forKey:@"role"];
    [encoder encodeInt:_playerId forKey:@"playerId"];
    [encoder encodeObject:_peerId forKey:@"peerId"];
    [encoder encodeInt:_voteNominate forKey:@"voteNominate"];
    //[encoder encodeObject:_playerArray forKey:@"playerArray"]; //No need to transmit player object's playerArray. It's for player's own use only
}

- (WerewolvesPlayer*) init {
    self =[super init];
    
    _alive = YES;
    //_playerName = [[NSString alloc] init];
    _role = UndefinedRole;
    _playerId = -1;
    _voteNominate = -1;
    _witchHasSave = NO;
    _witchHasKill = NO;
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];

    return  self;
}

- (void) registerPlayer: (NSString*)name {
    _playerName = name;
}

- (void) sendPeopleInfo {
    NSArray *allPeers = self.appDelegate.peer.session.connectedPeers;
    NSLog(@"enter send people info with connectedPeers size=%d",allPeers.count);
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.senderId = _playerId;
    myMessage.receiverId = - 1; // -1 means send to every one
    myMessage.messageType = SendPlayerInfo;
    myMessage.playerInfo = [[WerewolvesRoom getInstance] playerArray];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
    [_appDelegate.peer.session sendData:data
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

/*
- (void) createVote {
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.senderId = _playerId;
    myMessage.receiverId = - 1; // -1 means send to every one
    myMessage.messageType = CreateVote;
    myMessage.playerInfo = [[WerewolvesRoom getInstance] playerArray];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
    [_appDelegate.peer.session sendData:data
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }

}

- (void) reVote {
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.senderId = _playerId;
    myMessage.receiverId = - 1; // -1 means send to every one
    myMessage.messageType = ReVote;
    myMessage.playerInfo = [[WerewolvesRoom getInstance] playerArray];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
    [_appDelegate.peer.session sendData:data
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}
 */

- (void) sendRevoteResult {
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.senderId = _playerId;
    myMessage.receiverId = -1; // -1 means no one die this round of vore
    myMessage.messageType = SendVoteResult;
    myMessage.playerInfo = [[WerewolvesRoom getInstance] playerArray];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
    [_appDelegate.peer.session sendData:data
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void) sendVoteResult:(int) playerId {
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.senderId = _playerId;
    myMessage.receiverId = playerId; // the one die this round of vote
    myMessage.messageType = SendVoteResult;
    myMessage.playerInfo = [[WerewolvesRoom getInstance] playerArray];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
    [_appDelegate.peer.session sendData:data
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void) sendDeathResult:(int) playerId1:(int) playerId2 {
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.senderId = playerId1; // playerId1 is the first dead player's id
    myMessage.receiverId = playerId2; // playerId2 is the second dead player's id
    myMessage.messageType = SendDeathResult;
    myMessage.playerInfo = [[WerewolvesRoom getInstance] playerArray];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
    [_appDelegate.peer.session sendData:data
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void) sendTerminateResult:(int) wolfWin {
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.senderId = _playerId;
    myMessage.receiverId = wolfWin; // if receiverId = 1, wolfWin.; =0, villager win
    myMessage.messageType = SendTerminateResult;
    myMessage.playerInfo = [[WerewolvesRoom getInstance] playerArray];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
    [_appDelegate.peer.session sendData:data
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }

}

- (void) sendVoteNominate:(int) playerId {
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.senderId = _playerId;
    myMessage.receiverId = playerId; // receiverId here used as the vote nominate id
    myMessage.messageType = SendVoteNominate;
    myMessage.playerInfo = _playerArray;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
    [_appDelegate.peer.session sendData:data
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    NSLog(@"VOTE SEND");
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }

}

- (void) sendTextChat:(NSString*) msg {
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.senderId = _playerId;
    myMessage.receiverId = -1; // broadcast
    myMessage.messageType = TextChat;
    myMessage.playerInfo = _playerArray;
    myMessage.text = msg;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
    [_appDelegate.peer.session sendData:data
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void) receiveData:(NSNotification *)notification{
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    WerewolvesMessage *receivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:receivedData];
    NSLog(@"Received messageType is %d",[receivedMsg messageType]);
    NSLog(@"My peerID is %d",_appDelegate.peer.session.myPeerID);
    switch ([receivedMsg messageType]) {
        /* On the player's end */
        case SendPlayerInfo:
            if (true) {
                // make sure moderator's information will not be changed by other player
                _playerArray = [receivedMsg playerInfo];
                NSLog([NSString stringWithFormat:@"playerArray: %d", [_playerArray count]]);
                for (WerewolvesPlayer* playerPtr in _playerArray) {
                    NSLog(@"Enter for loop with peerID=%d",playerPtr.peerId);
                    if ([playerPtr.peerId isEqual:_appDelegate.peer.session.myPeerID]) {
                        _alive = playerPtr.alive;
                        _playerName = playerPtr.playerName;
                        _role = playerPtr.role;
                        NSLog(@"Role assigned!");
                        _playerId = playerPtr.playerId;
                        _peerId = playerPtr.peerId;
                        _voteNominate = playerPtr.voteNominate;
                    }
                }
            }
            break;
            /*
        case CreateVote:
            // Go to vote UI
            break;
        case ReVote:
            // Remind the player to vote again
            break;
             */
        case SendVoteResult:
             _playerArray = [receivedMsg playerInfo];
            /* Check vote nominate list and display corresponding information*/
            break;
        case SendDeathResult:
            if ((receivedMsg.receiverId > 0 && receivedMsg.receiverId == _playerId) ||
                (receivedMsg.senderId > 0 && receivedMsg.senderId == _playerId)) {
                /*show message that YOU ARE KILLED*/
                _alive = NO;
            }
            /*Pop some message say playerId1 and playerId2 is dead*/
            _playerArray = receivedMsg.playerInfo;
            break;
        case SendTerminateResult:
            if (receivedMsg.receiverId == 1) {
                /*Wolf won*/
            }
            else if (receivedMsg.receiverId == 2) {
                /*villager win*/
            }
            else {
                /*tie*/
            }
        case SendVoteNominate:
            NSLog(@"Entered sendVoteNominate with nominate=%d and senderId=%d",receivedMsg.receiverId, receivedMsg.senderId);
            if (_role == Moderator) {
                NSLog(@"Entered if in sendVoteNominate");
                // Make sure only the moderator uses this information
                for (WerewolvesPlayer* playerPtr in [[WerewolvesRoom getInstance] playerArray]) {
                    NSLog(@"In For loop, playerPtr.playerId=%d",playerPtr.playerId);
                    if (playerPtr.playerId == receivedMsg.senderId && playerPtr.alive == YES) {
                        [playerPtr setVoteNominate:receivedMsg.receiverId];
                    }
                    //break;
                }
                /*May call other functions to update UI views*/
            }
            break;
        case TextChat:
            /*Display msg onto screen*/
            break;
        default:
            break;
    }
}

@end
