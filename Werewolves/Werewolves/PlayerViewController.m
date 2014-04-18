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
    NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view.
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
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
    switch ([[myself myPlayerInstance] role]){
        case Wolf: roleMessage = @"WOLF"; break;
        case Peasant: roleMessage = @"PEASANT"; break;
        case Witch: roleMessage = @"WITCH"; break;
        case Oracle: roleMessage = @"ORACLE"; break;
        default: roleMessage = @"ERROR"; break;
    }
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Role Assigned!"
                                                      message:[NSString stringWithFormat: @"Your role is: %@!", roleMessage]
                                                     delegate:nil
                                            cancelButtonTitle:@"Got it!"
                                            otherButtonTitles:nil];
    
    [message show];
    
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
