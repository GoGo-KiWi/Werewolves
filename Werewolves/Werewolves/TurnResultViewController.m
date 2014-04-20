//
//  TurnResultViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/12/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "TurnResultViewController.h"
#import "WerewolvesRoom.h"
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
    NSString *killedInfo = @"";
    self.killedLabel.textColor = [UIColor lightGrayColor];
    if (![self.killedPlayer1 isEqualToString:@"None is killed."]) {
        killedInfo = [NSString stringWithFormat:@"%@\n%@", killedInfo, self.killedPlayer1];
    }
    if (![self.killedPlayer2 isEqualToString:@"None is killed."]) {
        killedInfo = [NSString stringWithFormat:@"%@\n%@", killedInfo, self.killedPlayer2];
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

@end
