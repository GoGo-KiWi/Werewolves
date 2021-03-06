//
//  WerewolvesViewController.m
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesViewController.h"
#import "WerewolvesUtility.h"
#import "WerewolvesAppDelegate.h"
#import "JoinRoomViewController.h"

@interface WerewolvesViewController ()
@property (nonatomic, strong) WerewolvesAppDelegate *appDelegate;
@end

@implementation WerewolvesViewController
@synthesize userName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    userName.placeholder = @"Your Name";
    userName.backgroundColor = [UIColor lightGrayColor];
    userName.returnKeyType = UIReturnKeyDone;
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:userName];
    userName.delegate = self;
    
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
    /*
    [[_appDelegate peer] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
    [_appDelegate.peer setupMCBrowser];
     */
    //[self.nextView setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([userName.text isEqualToString:@""] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name Invalid"
                                                        message:@"Will use device name!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        [[_appDelegate peer] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
        [_appDelegate.peer setupMCBrowser];
    }
    else {
        [_appDelegate.peer setupPeerAndSessionWithDisplayName:userName.text];
        [_appDelegate.peer setupMCBrowser];
    }
    
    if([segue.identifier isEqualToString:@"CreateRoomSegue"]){
        if ([segue.destinationViewController isMemberOfClass:[JoinRoomViewController class]]) {
            WerewolvesRoom *newRoom = [WerewolvesRoom getInstance];
            [WerewolvesUtility createPlayerList: 5]; /*Creating dummpy players. Should delete in final code*/
            JoinRoomViewController *controller = (JoinRoomViewController *)segue.destinationViewController;
            controller.userName = self.userName.text;
            controller.navigationItem.hidesBackButton = YES;
            [_appDelegate.peer advertiseSelf: true];
        }
    } else if([segue.identifier isEqualToString:@"JoinRoomSegue"]){
        if ([segue.destinationViewController isMemberOfClass:[JoinRoomViewController class]]) {
            JoinRoomViewController *controller = (JoinRoomViewController *)segue.destinationViewController;
            controller.userName = self.userName.text;
            controller.navigationItem.hidesBackButton = YES;
            [_appDelegate.peer advertiseSelf: false];
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
    _appDelegate.peer.peerID = nil;
    _appDelegate.peer.session = nil;
    _appDelegate.peer.browser = nil;
    
    [_appDelegate.peer.advertiser stop];
    _appDelegate.peer.advertiser = nil;
    
    if ([userName.text isEqualToString:@""] == NO ) {
        [_appDelegate.peer setupPeerAndSessionWithDisplayName:userName.text];
        [_appDelegate.peer setupMCBrowser];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name Invalid"
                                                        message:@"Please enter a valid name!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    //[_appDelegate.peer advertiseSelf: true];

    return YES;
}


@end
