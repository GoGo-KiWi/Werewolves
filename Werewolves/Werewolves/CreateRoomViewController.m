//
//  CreateRoomViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "CreateRoomViewController.h"
#import "WerewolvesUtility.h"
#import "WerewolvesAppDelegate.h"
#import "PlayerListViewController.h"
#import "WerewolvesRoom.h"

@interface CreateRoomViewController ()

@end


@implementation CreateRoomViewController

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
    self.roomName.placeholder = @"Your Name";
    self.roomName.backgroundColor = [UIColor lightGrayColor];
    self.roomName.returnKeyType = UIReturnKeyDone;
    self.roomName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.roomName];
    self.roomName.delegate = self;
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
    if([segue.identifier isEqualToString:@"DeviceListSegue"]){
        WerewolvesRoom *newRoom = [WerewolvesRoom getInstance];
        
        [WerewolvesUtility createPlayerList: 8];
        if ([segue.destinationViewController isMemberOfClass:[PlayerListViewController class]]) {
            PlayerListViewController *controller = (PlayerListViewController *)segue.destinationViewController;
            controller.roomNameText = [NSString stringWithFormat: @"Room %@", self.roomName.text];
            [newRoom printPlayers];
        }
    }    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [WerewolvesUtility animateTextField:textField forView:self.view up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [WerewolvesUtility animateTextField:textField forView:self.view up:NO];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
