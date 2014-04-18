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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)voteAction:(id)sender {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WerewolvesRoom * room = [WerewolvesRoom getInstance];
    return [[room playerArray] count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    int idx = [indexPath row] + 1;
    WerewolvesPlayerRoot *player = [WerewolvesPlayerRoot getInstance];
    NSMutableArray * playerList = [[player myPlayerInstance] playerArray];
    cell = [WerewolvesUtility createCellFor:playerList[idx] forVote:NO forStatus:YES];
    if ([playerList[idx] role] == Wolf){
        [cell setTextColor:[UIColor grayColor]];
        [cell setUserInteractionEnabled:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[delegate playerKilled:[NSString stringWithFormat:@"# %ld", (long) indexPath.row]];
    self.votedPlayer = [indexPath row] + 1;
    
}

- (IBAction)sendVote:(id)sender {
    WerewolvesPlayerRoot * player = [WerewolvesPlayerRoot getInstance];
    [[player myPlayerInstance] sendVoteNominate:self.votedPlayer];
    //NSLog(@"SEND");
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
