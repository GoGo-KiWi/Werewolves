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
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    int resultID = [room getVoteResult];
    self.resultLabel.text = [NSString stringWithFormat:@"#%d %@ has most votes!", resultID, [playerList[resultID] playerName]];
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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    int idx = [indexPath row] + 1;
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    cell = [WerewolvesUtility createCellFor:playerList[idx] forVote:YES];
    return cell;
}

- (IBAction)startNewRound:(id)sender {
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    int resultID = [room getVoteResult];
    [playerList[resultID] setAlive:NO];
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