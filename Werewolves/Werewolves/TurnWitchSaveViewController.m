//
//  TurnWitchSaveViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "TurnWitchSaveViewController.h"
#import "TurnWitchKillViewController.h"
#import "WerewolvesRoom.h"

@interface TurnWitchSaveViewController ()

@end

@implementation TurnWitchSaveViewController
@synthesize playerKilledInfo, saveInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.playerKilledInfo.text = self.killedPlayerName;
    //label = [[UILabel alloc] init];
    //playerKilledInfo.frame = CGRectMake(10, 10, 300, 40);
    //[self.view addSubview:playerKilledInfo];
    /*[saveInfo addTarget:self
            action:@selector(pickOne:)
            forControlEvents:UIControlEventValueChanged];*/
	//[self.view addSubview:saveInfo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (IBAction)saveAction:(id)sender
{
    if(saveInfo.selectedSegmentIndex == 0){
        self.killedPlayerName = @"None is killed.";
        self.killedPlayerID = -1;
	}
    else{
        self.killedPlayerName = playerKilledInfo.text;
    }
}
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (self.saveInfo.selectedSegmentIndex == 0){
        self.saveInfo.enabled = FALSE;
        self.killedPlayerName = @"None is killed.";
        self.killedPlayerID = -1;
    } else {
        WerewolvesRoom *room = [WerewolvesRoom getInstance];
        NSMutableArray *playerList = [room playerArray];
        [playerList[self.killedPlayerID] setAlive:NO];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"WitchKillSegue"]){
        if ([segue.destinationViewController isMemberOfClass:[TurnWitchKillViewController class]]) {
            TurnWitchKillViewController *controller = (TurnWitchKillViewController *)segue.destinationViewController;
            controller.killedPlayer1 = self.killedPlayerName;
            controller.killedPlayerID1 = self.killedPlayerID;
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
