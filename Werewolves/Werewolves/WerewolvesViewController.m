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
    [[_appDelegate peer] setupPeerAndSessionWithDisplayName:[UIDevice currentDevice].name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

    [_appDelegate.peer setupPeerAndSessionWithDisplayName:userName.text];
    [_appDelegate.peer setupMCBrowser];
    [_appDelegate.peer advertiseSelf: true];

    return YES;
}


@end
