//
//  TurnWitchSaveViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "TurnWitchSaveViewController.h"

@interface TurnWitchSaveViewController ()

@end

@implementation TurnWitchSaveViewController
@synthesize playerKilledInfo, saveInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        TurnWerewolfViewController *viewController = [[TurnWerewolfViewController alloc] init];
        // assign delegate
        viewController.delegate = self;
    }
    return self;
}

-(void)playerKilled:(NSString*)playerName{
    playerKilledInfo.text = [NSString stringWithFormat:@"%@ is killed.", playerName];
    [self.view addSubview:playerKilledInfo];
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Success" message:@"success!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];

}

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
	[self.view addSubview:saveInfo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void) pickOne:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    playerKilledInfo.text = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
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
