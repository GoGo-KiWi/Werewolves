//
//  TurnWitchKillViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "TurnWitchKillViewController.h"
#import "TurnOracleViewController.h"
#import "WerewolvesRoom.h"

@interface TurnWitchKillViewController ()

@end

@implementation TurnWitchKillViewController
@synthesize witchPlayerList;

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
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    cell = [WerewolvesUtility createCellFor:playerList[idx] forVote:NO forStatus:NO];
    /*if ([playerList[idx] role] == Witch){
        [cell setTextColor:[UIColor grayColor]];
        [cell setUserInteractionEnabled:NO];
    }*/
    //cell.textLabel.tag = [(NSInteger) [indexPath row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[delegate playerKilled:[NSString stringWithFormat:@"# %ld", (long) indexPath.row]];
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    self.killedPlayer2 = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    self.killedPlayerID2 = [indexPath row] + 1;
    [playerList[[indexPath row] + 1] setAlive:NO];

}

- (IBAction)resetSelection:(id)sender {
    //[super viewDidDisappear:animated];
    [self.witchPlayerList deselectRowAtIndexPath:[self.witchPlayerList indexPathForSelectedRow] animated:NO];
    self.killedPlayer2 = @"None";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"OracleTurnSegue"]){
        if ([segue.destinationViewController isMemberOfClass:[TurnOracleViewController class]]) {
            TurnOracleViewController *controller = (TurnOracleViewController *)segue.destinationViewController;
            controller.killedPlayer1 = self.killedPlayer1;
            if ([self.killedPlayer2 length] == 0){
                self.killedPlayer2 = @"None";
                self.killedPlayerID2 = -1;
            }
            else{
                [self.witchPlayerList setAllowsSelection:NO];
            }
            controller.killedPlayer2 = [NSString stringWithFormat:@"%@ is killed.", self.killedPlayer2];
            controller.killedPlayerID1 = self.killedPlayerID1;
            controller.killedPlayerID2 = self.killedPlayerID2;
        }
    }
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
