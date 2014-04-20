//
//  PlayerVoteViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/14/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "PlayerVoteViewController.h"
#import "WerewolvesAppDelegate.h"
#import "WerewolvesUtility.h"
#import "WerewolvesPlayerRoot.h"
#import "WerewolvesRoom.h"

@interface PlayerVoteViewController ()
@property (nonatomic, strong) WerewolvesAppDelegate *appDelegate;

@end

@implementation PlayerVoteViewController

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
    [self.navigationItem.backBarButtonItem setEnabled:NO];
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    [self.bottomLabel setEnabled:NO];
    [self.bottomLabel setTitle:@"Select To Vote" forState:UIControlStateDisabled];
    // Do any additional setup after loading the view.
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
    WerewolvesPlayerRoot *player = [WerewolvesPlayerRoot getInstance];
    NSMutableArray * playerList = [[player myPlayerInstance] playerArray];
    return [playerList count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    int idx = [indexPath row] + 1;
    WerewolvesPlayerRoot *player = [WerewolvesPlayerRoot getInstance];
    NSMutableArray * playerList = [[player myPlayerInstance] playerArray];
    cell = [WerewolvesUtility createCellFor:playerList[idx] forVote:YES forStatus:YES];
    /*
    if ([playerList[idx] role] == Wolf){
        [cell setUserInteractionEnabled:NO];
    }
     */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[delegate playerKilled:[NSString stringWithFormat:@"# %ld", (long) indexPath.row]];
    self.votedPlayer = [indexPath row] + 1;
    [self.bottomLabel setEnabled:YES];
    [self.bottomLabel setTitle:@"Vote" forState:UIControlStateNormal];
    /*
    if ([self.bottomLabel.titleLabel.text isEqualToString:@"Select to Vote"]) {
    }
     */
}

- (IBAction)sendVote:(id)sender {
    WerewolvesPlayerRoot * player = [WerewolvesPlayerRoot getInstance];
    [[player myPlayerInstance] sendVoteNominate:self.votedPlayer];
    [self.bottomLabel setEnabled:NO];
    [self.bottomLabel setTitle:@"Vote Sent" forState:UIControlStateDisabled];
    [self.voteList setAllowsSelection:NO];
}

- (void) didReceiveDataWithNotification:(NSNotification *)notification{
    WerewolvesPlayerRoot *myself = [WerewolvesPlayerRoot getInstance];
    [[myself myPlayerInstance] receiveData:notification];
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    WerewolvesMessage *receivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:receivedData];
    NSString *deathResult = @"";
    if ([receivedMsg senderId] == -1){
        deathResult = [[[myself myPlayerInstance] playerArray][[receivedMsg senderId]] playerName];
        [self.bottomLabel setTitle:@"Okay" forState:UIControlStateNormal];
        [self.bottomLabel setEnabled:YES];
    } else {
        deathResult = @"It's a tie! Please re-vote!";
        [self.bottomLabel setEnabled:NO];
        [self.bottomLabel setTitle:@"Select to Vote" forState:UIControlStateDisabled];
        [self.voteList setAllowsSelection:YES];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Voting Result:"
                                                    message:deathResult
                                                   delegate:nil
                                          cancelButtonTitle:@"Got it!"
                                          otherButtonTitles:nil];
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self.voteList reloadData];
    });
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
