//
//  TurnWerewolfViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "TurnWerewolfViewController.h"
#import "TurnWitchSaveViewController.h"
#import "WerewolvesUtility.h"
#import "WerewolvesRoom.h"

@interface TurnWerewolfViewController ()

@end

@implementation TurnWerewolfViewController
@synthesize killList;

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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    //cell.textLabel.text = [NSString stringWithFormat:@"# %ld", (long)[indexPath row]];
    /*cell.textLabel.text = [NSString stringWithFormat:@"Player %ld", (long)[indexPath row]];
    switch ([indexPath row]){
        case 2: cell.imageView.image = [UIImage imageNamed:@"icon_oracle.png"]; break;
        case 4: cell.imageView.image = [UIImage imageNamed:@"icon_witch.png"]; break;
        default: cell.imageView.image = [UIImage imageNamed:@"icon_village.png"];

    }*/
    int idx = [indexPath row] + 1;
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    cell = [WerewolvesUtility createCellFor:playerList[idx] forVote:NO];
    if ([playerList[idx] role] == Wolf){
        [cell setTextColor:[UIColor grayColor]];
        [cell setUserInteractionEnabled:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[delegate playerKilled:[NSString stringWithFormat:@"# %ld", (long) indexPath.row]];
    self.killedName = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"WitchSaveSegue"]){
        if ([segue.destinationViewController isMemberOfClass:[TurnWitchSaveViewController class]]) {
            TurnWitchSaveViewController *controller = (TurnWitchSaveViewController *)segue.destinationViewController;
            controller.killedPlayerName = [NSString stringWithFormat:@"%@ is killed.", self.killedName];
        }
    }
}

@end
