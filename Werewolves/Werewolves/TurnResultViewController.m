//
//  TurnResultViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/12/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "TurnResultViewController.h"
#import "WerewolvesRoom.h"
#import "WerewolvesAppDelegate.h"

@interface TurnResultViewController ()

@end

@implementation TurnResultViewController
@synthesize killedLabel;

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
    NSString *killedInfo = @"";
    self.killedLabel.textColor = [UIColor lightGrayColor];
    if (![self.killedPlayer1 isEqualToString:@"None is killed."]) {
        killedInfo = [NSString stringWithFormat:@"%@\n\t%@", killedInfo, self.killedPlayer1];
    }
    if (![self.killedPlayer2 isEqualToString:@"None is killed."]) {
        killedInfo = [NSString stringWithFormat:@"%@\n\t%@", killedInfo, self.killedPlayer2];
    }
    if ([killedInfo isEqualToString:@""]) {
        killedInfo = @"Nobody";
    }
    self.killedLabel.text = [NSString stringWithFormat:@"Dead players:\n%@", killedInfo];
    /*
    if ([self.killedPlayer1 isEqualToString:@"None is killed."] &&
        [self.killedPlayer2 isEqualToString:@"None is killed."]){
        self.killedLabel1.text = self.killedPlayer1;
        self.killedLabel2.text = @"";
    }
    else{
        if ([self.killedPlayer1 isEqualToString:@"None is killed."]){
            self.killedLabel1.text = @"";
        }
        else{
            self.killedLabel1.text = self.killedPlayer1;
        }
    
        if ([self.killedPlayer2 isEqualToString:@"None is killed."]){
            self.killedLabel2.text = @"";
        }
        else{
            self.killedLabel2.text = self.killedPlayer2;
        }    // Do any additional setup after loading the view.
    }
     */
    
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    NSMutableArray *playerList = [room playerArray];
    [playerList[0] sendDeathResult:_killedPlayerID1:_killedPlayerID2];
    UIAlertView *alertView;
    switch ([room checkTerminate]) {
        case 0:
            // continue
            break;
        case 1:
            // wolf win
            alertView = [[UIAlertView alloc] initWithTitle:@"Game Result:"
                                                   message:@"Wolf Win!!!"
                                                  delegate:nil
                                         cancelButtonTitle:@"Got it!"
                                         otherButtonTitles:nil];
            [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
            break;
        case 2:
            // villager win
            alertView = [[UIAlertView alloc] initWithTitle:@"Game Result:"
                                                   message:@"Villagers Win!!!"
                                                  delegate:nil
                                         cancelButtonTitle:@"Got it!"
                                         otherButtonTitles:nil];
            [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
            break;
        case 3:
            // tie
            alertView = [[UIAlertView alloc] initWithTitle:@"Game Result:"
                                                   message:@"Tie!"
                                                  delegate:nil
                                         cancelButtonTitle:@"Got it!"
                                         otherButtonTitles:nil];
            [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:false];
            break;
        default:
            break;
    }
}
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"VoteTurnSegue"]){
        WerewolvesAppDelegate *appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSArray *allClients = appDelegate.peer.session.connectedPeers;
        NSError *error;
        WerewolvesMessage *startMsg = [[WerewolvesMessage alloc]init];
        startMsg.messageType = StartVote;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:startMsg];
        [appDelegate.peer.session sendData:data
                                   toPeers:allClients
                                  withMode:MCSessionSendDataReliable
                                     error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
