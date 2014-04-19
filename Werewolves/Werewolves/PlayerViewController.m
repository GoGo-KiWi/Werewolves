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
    NSString * roleMessage;
    NSLog([NSString stringWithFormat:@"%d", [[myself myPlayerInstance] role]]);
    switch ([[myself myPlayerInstance] role]){
        case Wolf:
            roleMessage = @"Your role is: WOLF!";
            break;
        case Peasant:
            roleMessage = @"Your role is: PEASANT!";
            break;
        case Witch:
            roleMessage = @"Your role is: WITCH!";
            break;
        case Oracle:
            roleMessage = @"Your role is: ORACLE!";
            break;
        default:
            roleMessage = @"Your role is: ERROR!";
    }
    
    NSString *message = [[NSString alloc] initWithFormat:
                         @"You selected %@",roleMessage];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Role Assigned!"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"Got it!"
                                            otherButtonTitles:nil];
    
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
    NSLog(@"Finish the didReceiveDataWithNotification function!");
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self.roleTableView reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.frame.size.height / 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RoleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.numberOfLines = 0;
    WerewolvesPlayerRoot *myself = [WerewolvesPlayerRoot getInstance];
    switch ([indexPath row]) {
        case 0:
            cell.textLabel.text = @"Peasant";
            cell.detailTextLabel.text = @"Peasants do not have any special ability. Try to survive the game! ";
            cell.imageView.image = [UIImage imageNamed:@"icon_village.png"];
            if ([[myself myPlayerInstance]role] == Peasant) {
                cell.textLabel.text = @"Peasant [YOU]";
                [cell setHighlighted:YES];
                cell.backgroundColor = [UIColor redColor];
            }
            break;
        case 1:
            cell.textLabel.text = @"Wolf";
            cell.detailTextLabel.text = @"Werewolves can eliminate one person every night. Try eliminating all the townfolks to win the game!";
            cell.imageView.image = [UIImage imageNamed:@"icon_werewolf.png"];
            if ([[myself myPlayerInstance]role] == Wolf) {
                cell.textLabel.text = @"Wolf [YOU]";
                [cell setHighlighted:YES];
                cell.backgroundColor = [UIColor redColor];
            }
            break;
        case 2:
            cell.textLabel.text = @"Oracle";
            cell.detailTextLabel.text = @"An oracle can know the role of one person by asking the moderator every night";
            cell.imageView.image = [UIImage imageNamed:@"icon_oracle.png"];
            if ([[myself myPlayerInstance]role] == Oracle) {
                cell.textLabel.text = @"Oracle [YOU]";
                [cell setHighlighted:YES];
                cell.backgroundColor = [UIColor redColor];
            }
            break;
        case 3:
            cell.textLabel.text = @"Witch";
            cell.detailTextLabel.text = @"A witch has the ability to save one person and kill one person during the game.";
            cell.imageView.image = [UIImage imageNamed:@"icon_witch.png"];
            if ([[myself myPlayerInstance]role] == Witch) {
                cell.textLabel.text = @"Witch [YOU]";
                [cell setHighlighted:YES];
                cell.backgroundColor = [UIColor redColor];
            }
            break;
        default:
            break;
    }
    return cell;
}

@end
