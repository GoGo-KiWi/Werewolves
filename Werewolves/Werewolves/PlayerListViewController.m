//
//  PlayerListViewController.m
//  Werewolves
//
//  Created by Gloria Xu on 4/8/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "PlayerListViewController.h"
#import "WerewolvesUtility.h"
#import "WerewolvesRoom.h"

@interface PlayerListViewController ()

@end

@implementation PlayerListViewController

@synthesize roomNameText;

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
    WerewolvesRoom *newRoom = [WerewolvesRoom getInstance];
    WerewolvesAppDelegate *appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSArray *allPeers = appDelegate.peer.session.connectedPeers;
    WerewolvesPlayer* newPlayer;
    NSLog(@"The size of connectedPeers is %d", allPeers.count);
    for (int i = 0; i < [allPeers count]; i++) {
        NSLog(@"Inside adding actual player loop with i=%d",i);
        newPlayer = [[WerewolvesPlayer alloc] init];
        NSLog(@"Inside adding actual player loop with i=%d before get peerID from allPeers",i);
        MCPeerID* peer = allPeers[i];
        NSLog(@"Inside adding actual player loop with i=%d after get peerID from allPeers",i);
        newPlayer.peerId = peer;
        NSLog(@"Inside adding actual player loop with i=%d after assign peerID and before getPeerName from peerID",i);
        newPlayer.playerName = peer.displayName;
        NSLog(@"Inside adding actual player loop with i=%d. Over, going to jump out",i);
        [newRoom addPlayer:newPlayer];
    }
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.roomNameText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    return [[room playerArray] count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"A" message:[NSString stringWithFormat:@"%d", [playerList count]] delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
    //[alert show];
    int idx = [indexPath row] + 1;
    cell = [WerewolvesUtility createCellFor:playerList[idx] forVote:NO forStatus:NO];
    return cell;
}

- (IBAction)assignRoles:(id)sender {
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    [room generateRandomRoles];
}

/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        [self.dataArray removeObjectAtIndex:indexPath.row];
    }
}
 */

@end
