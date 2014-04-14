//
//  AssignRoleViewController.m
//  Werewolves
//
//  Created by Gloria Xu on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "AssignRoleViewController.h"
#import "WerewolvesUtility.h"
#import "WerewolvesRoom.h"
@interface AssignRoleViewController ()

@end

@implementation AssignRoleViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
        case 2:
            return 1;
        case 3:
            return 1;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    //NSString *headerTitle = [self tableView:tableView titleForHeaderInSection:indexPath.section];
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList;
    WerewolvesPlayer * player;

    //NSString *name = [NSString stringWithFormat:@"%@ %ld", headerTitle, (long)[indexPath row]];
    switch (indexPath.section) {
        case 0:
            playerList = [room getPlayers:Peasant];
            break;
        case 1:
            playerList = [room getPlayers:Wolf];
            break;
        case 2:
            playerList = [room getPlayers:Oracle];
            break;
        case 3:
            playerList = [room getPlayers:Witch];
            break;
        default:
            break;
    }
    
    player = playerList[[indexPath row]];
    cell = [WerewolvesUtility createCellFor:player];
    return cell;
}
 
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Peasant";
            break;
        case 1:
            return @"Werewolf";
            break;
        case 2:
            return @"Oracle";
            break;
        case 3:
            return @"Witch";
            break;
        default:
            break;
    }
    return 0;
}

@end
