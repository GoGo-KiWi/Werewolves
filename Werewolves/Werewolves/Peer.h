
#import <Foundation/Foundation.h>
@import MultipeerConnectivity;
#import "WerewolvesPlayer.h"

@interface Peer : NSObject
{
    
}

@property (nonatomic,strong) MCPeerID *peerId;
@property (nonatomic,strong) MCSession *session;
@property (nonatomic,strong) MCAdvertiserAssistant *assistant;

@end
