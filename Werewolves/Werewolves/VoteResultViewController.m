//
//  VoteResultViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/14/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "VoteResultViewController.h"
#import "WerewolvesUtility.h"
#import "WerewolvesRoom.h"

@interface VoteResultViewController ()

@property (nonatomic, strong) WerewolvesAppDelegate *appDelegate;

@end

@implementation VoteResultViewController

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
    // Do any additional setup after loading the view.
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    int resultID = [room getVoteResult];
    if (resultID == -1){
        self.resultLabel.text = @"It's a tie! Please re-vote!";
    }
    else{
        self.resultLabel.text = [NSString stringWithFormat:@"#%d %@ has most votes!", resultID, [playerList[resultID] playerName]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    return [[room playerArray] count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    int idx = [indexPath row] + 1;
    NSLog(@"Cell: %d", [indexPath row]);
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    cell = [WerewolvesUtility createCellFor:playerList[idx] forVote:YES forStatus:NO];
    return cell;
}

- (IBAction)startNewRound:(id)sender {
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    [room.playerArray[0] sendVoteResult];
    
    NSMutableArray *playerList = [room playerArray];
    int resultID = [room getVoteResult];
    if (resultID != -1){
        [playerList[resultID] setAlive:NO];
        [room.playerArray[0] sendDeathResult:resultID];
    }
    [room resetVoteNominate];
}

- (void) didReceiveDataWithNotification:(NSNotification *)notification{
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    [playerList[0] receiveData:notification];
    NSString * message = [NSString stringWithFormat:@"Vote received!"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Role Assigned!"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"Got it!"
                                          otherButtonTitles:nil];
    
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
    [self.voteResult reloadData];
}

- (IBAction)revote:(id)sender{
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    [room.playerArray[0] sendVoteResult];
    /*
    NSArray *allPeers = _appDelegate.peer.session.connectedPeers;
    NSError *error;
    
    WerewolvesMessage *myMessage = [[WerewolvesMessage alloc] init];
    myMessage.messageType = SendVoteResult;
    myMessage.playerInfo = [[WerewolvesRoom getInstance] playerArray];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myMessage];
    
    [_appDelegate.peer.session sendData:data
                                    toPeers:allPeers
                                   withMode:MCSessionSendDataReliable
                                      error:&error];
     */
    
    [room resetVoteNominate];
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
