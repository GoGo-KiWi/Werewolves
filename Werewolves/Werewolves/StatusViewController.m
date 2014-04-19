 //
//  StatusViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/16/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "StatusViewController.h"
#import "WerewolvesRoom.h"
#import "WerewolvesUtility.h"
#import "WerewolvesPlayerRoot.h"

@interface StatusViewController ()

@end

@implementation StatusViewController

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
    //[WerewolvesUtility createPlayerList: 8];

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
    cell = [WerewolvesUtility createCellFor:playerList[idx] forVote:NO forStatus:YES];
    return cell;
}

/*- (IBAction)startNewRound:(id)sender {
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    int resultID = [room getVoteResult];
    [playerList[resultID] setAlive:NO];
    [room resetVoteNominate];
}*/
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
