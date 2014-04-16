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
    _peerId = [decoder decodeIntForKey:@"peerId"];
    _voteNominate = [decoder decodeIntForKey:@"voteNominate"];
    //_playerArray = [decoder decodeObjectForKey:@"playerArray"]; //No need to transmit player object's playerArray. It's for player's own use only
    return self;
}

- (void)encodeWithCoder:(NSCoder *) encoder {
    [encoder encodeBool:_alive forKey:@"alive"];
    [encoder encodeObject:_playerName forKey:@"playerName"];
    [encoder encodeInt:_role forKey:@"role"];
    [encoder encodeInt:_playerId forKey:@"playerId"];
    [encoder encodeInt:_peerId forKey:@"peerId"];
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
    
    return  self;
}

- (void) registerPlayer: (NSString*)name {
    _playerName = name;
}

- (void) sendPeopleInfo {
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
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

-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    //NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    WerewolvesMessage *receivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:receivedData];
    
    if ([receivedMsg messageType] == SendPlayerInfo) {
        //do something
    }
}

@end
