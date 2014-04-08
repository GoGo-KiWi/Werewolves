#import "PeerHelper.h"
#import "WerewolvesAppDelegate.h"

@interface PeerHelper ()

@property (nonatomic, strong) WerewolvesAppDelegate *appDelegate;

-(void)sendMyMessage:(NSString*) str;
-(void)didReceiveDataWithNotification:(NSNotification *)notification;

@end

@implementation PeerHelper

-(id)init{
	// Do any additional setup after loading the view, typically from a nib.
    
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    return self;
}


#pragma mark - IBAction method implementation

- (IBAction)sendMessage:(id)sender :(NSString*) Str {
    [self sendMyMessage:@"Str"];
}


#pragma mark - Private method implementation

-(void)sendMyMessage:(NSString*) str{
    NSData *dataToSend = [ @"str" dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    [_appDelegate.peer.session sendData:dataToSend
                                     toPeers:allPeers
                                    withMode:MCSessionSendDataReliable
                                       error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    /*
    [_tvChat setText:[_tvChat.text stringByAppendingString:[NSString stringWithFormat:@"I wrote:\n%@\n\n", _txtMessage.text]]];
    [_txtMessage setText:@""];
    [_txtMessage resignFirstResponder];
     */
}


-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    /*
    [_tvChat performSelectorOnMainThread:@selector(setText:) withObject:[_tvChat.text stringByAppendingString:[NSString stringWithFormat:@"%@ wrote:\n%@\n\n", peerDisplayName, receivedText]] waitUntilDone:NO];
     */
}

@end