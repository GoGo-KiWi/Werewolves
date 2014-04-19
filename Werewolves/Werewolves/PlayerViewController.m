//
//  PlayerViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/18/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "PlayerViewController.h"
#import "WerewolvesPlayerRoot.h"
#import "WerewolvesRoom.h"

@interface PlayerViewController ()
@end

@implementation PlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    WerewolvesPlayerRoot * player = [WerewolvesPlayerRoot getInstance];
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
    [player myPlayerInstance].peerId = _appDelegate.peer.session.myPeerID;
    NSLog(@"Update peer ID: %d", _appDelegate.peer.session.myPeerID);
    // Do any additional setup after loading the view.
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

- (void) didReceiveDataWithNotification:(NSNotification *)notification{
    NSLog(@"Entered the didReceiveDataWithNotification function!");
    WerewolvesPlayerRoot *myself = [WerewolvesPlayerRoot getInstance];
    [[myself myPlayerInstance] receiveData:notification];
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    WerewolvesMessage *receivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:receivedData];
    if ([receivedMsg messageType] == SendDeathResult) {
        NSString *deathResult1 = @"", *deathResult2 = @"";
        if ([receivedMsg senderId] != -1){
            deathResult1 = [[[myself myPlayerInstance] playerArray][[receivedMsg senderId]] playerName];
        }
        if ([receivedMsg receiverId] != -1){
            deathResult2 = [[[myself myPlayerInstance] playerArray][[receivedMsg receiverId]] playerName];
        }
        NSString *message = [NSString stringWithFormat:@"%@\r%@", deathResult1, deathResult2];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Players killed:"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Got it!"
                                              otherButtonTitles:nil];
        
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
    }
    else{
        NSString * roleMessage;
        NSLog([NSString stringWithFormat:@"%d", [[myself myPlayerInstance] role]]);
        switch ([[myself myPlayerInstance] role]){
            case Wolf: self.roleName = @"WOLF"; break;
            case Peasant: self.roleName = @"PEASANT"; break;
            case Witch: self.roleName = @"WITCH"; break;
            case Oracle: self.roleName = @"ORACLE"; break;
            default: self.roleName = @"ERROR";
        }
    
        roleMessage = [NSString stringWithFormat:@"Your role is %@!", self.roleName];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Role Assigned!"
                                                      message:roleMessage
                                                     delegate:nil
                                              cancelButtonTitle:@"Got it!"
                                              otherButtonTitles:nil];
    
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
    }
    NSLog(@"Finish the didReceiveDataWithNotification function!");

}

- (IBAction)checkRole:(id)sender {
    NSString *roleMessage = [NSString stringWithFormat:@"Your role is %@!", self.roleName];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remeber!"
                                                    message:roleMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"Got it!"
                                          otherButtonTitles:nil];
    
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
