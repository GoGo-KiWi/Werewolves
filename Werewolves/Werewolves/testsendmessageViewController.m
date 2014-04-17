//
//  FirstViewController.m
//  MCDemo
//
//  Created by Gabriel Theodoropoulos on 1/6/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "testsendmessageViewController.h"
#import "WerewolvesAppDelegate.h"

@interface FirstViewController ()

@property (nonatomic, strong) WerewolvesAppDelegate *appDelegate;

-(void)sendMyMessage;
-(void)didReceiveDataWithNotification:(NSNotification *)notification;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _txtMessage.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextField Delegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendMyMessage];
    return YES;
}


#pragma mark - IBAction method implementation

- (IBAction)sendMessage:(id)sender {
    [self sendMyMessage];
}

- (IBAction)cancelMessage:(id)sender {
    [_txtMessage resignFirstResponder];
}


#pragma mark - Private method implementation

-(void)sendMyMessage{
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.messageType = SendPlayerInfo;
    myMessage.playerInfo = [[WerewolvesRoom getInstance] playerArray];
    myMessage.text = _txtMessage.text;
    
    /*Code for data transferring test*/
    if ([[[WerewolvesRoom getInstance] playerArray] count] > 2) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
        
        [_appDelegate.peer.session sendData:data
                                    toPeers:allPeers
                                   withMode:MCSessionSendDataReliable
                                      error:&error];
        
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
        
        [_tvChat setText:[_tvChat.text stringByAppendingString:[NSString stringWithFormat:@"I sent playerArray with size=%d:\n", [[[WerewolvesRoom getInstance] playerArray] count]]]];
        [_txtMessage setText:@""];
        [_txtMessage resignFirstResponder];
    }
    
    
    
    /*Code for text chat*/
    myMessage.messageType = TextChat;
    NSData *dataToSend = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
     
    [_appDelegate.peer.session sendData:dataToSend
                                toPeers:allPeers
                               withMode:MCSessionSendDataReliable
                                  error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [_tvChat setText:[_tvChat.text stringByAppendingString:[NSString stringWithFormat:@"I wrote:\n%@\n\n", _txtMessage.text]]];
    [_txtMessage setText:@""];
    [_txtMessage resignFirstResponder];
     
}


-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    /*
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    [_tvChat performSelectorOnMainThread:@selector(setText:) withObject:[_tvChat.text stringByAppendingString:[NSString stringWithFormat:@"%@ wrote:\n%@\n\n", peerDisplayName, receivedText]] waitUntilDone:NO];
     */
    
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    //NSString *receivedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    WerewolvesMessage *receivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:receivedData];
    
    if ([receivedMsg messageType] == SendPlayerInfo) {
        [_tvChat performSelectorOnMainThread:@selector(setText:) withObject:[_tvChat.text stringByAppendingString:[NSString stringWithFormat:@"%@ send me with playerArray size=%d and the second player's name is %@\n", peerDisplayName, (int)[[receivedMsg playerInfo] count], [[receivedMsg playerInfo][2] playerName]]] waitUntilDone:NO];
    }
    
    if ([receivedMsg messageType] == TextChat) {
        NSString *receivedText = [receivedMsg text];
        
        [_tvChat performSelectorOnMainThread:@selector(setText:) withObject:[_tvChat.text stringByAppendingString:[NSString stringWithFormat:@"%@ wrote:\n%@\n\n", peerDisplayName, receivedText]] waitUntilDone:NO];
    }
}

@end
