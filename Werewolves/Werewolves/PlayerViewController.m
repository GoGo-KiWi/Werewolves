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
//@synthesize voteButton;

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
    NSLog(@"Enter viewDidLoad in PlayerViewController");
    WerewolvesPlayerRoot * player = [WerewolvesPlayerRoot getInstance];
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
    [player myPlayerInstance].peerId = _appDelegate.peer.session.myPeerID;
    [self.showHideButton setEnabled:NO];
    NSLog(@"Update peer ID: %d", _appDelegate.peer.session.myPeerID);
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    NSLog(@"Leaving viewDidLoad in PlayerViewController");
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
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    NSLog(@"Succesfully decoded the receviedData!");
    WerewolvesMessage *receivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:receivedData];
    
    if ([receivedMsg messageType] == SendDeathResult) {
        NSString *deathResult1 = @"", *deathResult2 = @"";
        if ([receivedMsg senderId] != -1){
            deathResult1 = [[[myself myPlayerInstance] playerArray][[receivedMsg senderId]] playerName];
        }
        if ([receivedMsg receiverId] != -1){
            deathResult2 = [[[myself myPlayerInstance] playerArray][[receivedMsg receiverId]] playerName];
        }
        NSString *message = [NSString stringWithFormat:@"%@\r%@", deathResult1, deathResult2];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Players killed:"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Got it!"
                                              otherButtonTitles:nil];
        
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
    }
    else if ([receivedMsg messageType] == SendPlayerInfo) {
        NSString * roleMessage;
        NSLog([NSString stringWithFormat:@"%d", [[myself myPlayerInstance] role]]);
        switch ([[myself myPlayerInstance] role]){
            case Wolf: self.roleName = @"WOLF"; break;
            case Peasant: self.roleName = @"PEASANT"; break;
            case Witch: self.roleName = @"WITCH"; break;
            case Oracle: self.roleName = @"ORACLE"; break;
            default: self.roleName = @"ERROR";
        }
        [self.showHideButton setTitle:@"Show your role" forState:UIControlStateNormal];
        [self.showHideButton setEnabled:YES];
        
        roleMessage = [NSString stringWithFormat:@"Your role is %@!", self.roleName];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Role Assigned!"
                                                        message:roleMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"Got it!"
                                              otherButtonTitles:nil];
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
    } else if ([receivedMsg messageType] == StartVote) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self performSegueWithIdentifier: @"GotoVoteSegue" sender: self];
        });
    }
    NSLog(@"Finish the didReceiveDataWithNotification function!");

}

- (IBAction)checkRole:(id)sender {
    NSLog(@"Enter checkRole in PlayerViewController");
    NSString *roleMessage = [NSString stringWithFormat:@"Your role is %@!", self.roleName];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remeber!"
                                                    message:roleMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"Got it!"
                                          otherButtonTitles:nil];
    
    [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
    NSLog(@"Leaving checkRole in PlayerViewController");
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
    switch ([indexPath row]) {
        case 0:
            cell.textLabel.text = @"Peasant";
            cell.detailTextLabel.text = @"Peasants do not have any special ability. Try to survive the game! ";
            cell.imageView.image = [UIImage imageNamed:@"icon_village.png"];
            break;
        case 1:
            cell.textLabel.text = @"Wolf";
            cell.detailTextLabel.text = @"Werewolves can eliminate one person every night. Try eliminating all the townfolks to win the game!";
            cell.imageView.image = [UIImage imageNamed:@"icon_werewolf.png"];
            break;
        case 2:
            cell.textLabel.text = @"Oracle";
            cell.detailTextLabel.text = @"An oracle can know the role of one person by asking the moderator every night";
            cell.imageView.image = [UIImage imageNamed:@"icon_oracle.png"];
            break;
        case 3:
            cell.textLabel.text = @"Witch";
            cell.detailTextLabel.text = @"A witch has the ability to save one person and kill one person during the game.";
            cell.imageView.image = [UIImage imageNamed:@"icon_witch.png"];
            break;
        default:
            break;
    }
    return cell;
}

@end
