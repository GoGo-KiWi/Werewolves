//
//  PlayerViewController.h
//  Werewolves
//
//  Created by Fiona Yang on 4/18/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WerewolvesAppDelegate.h"
#import "WerewolvesUtility.h"
#import "WerewolvesRoom.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>


@interface PlayerViewController : UIViewController <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *roleTableView;
@property (nonatomic, strong) WerewolvesAppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UIButton *showHideButton;
@property (strong, nonatomic) NSString *roleName;
@property (weak, nonatomic) IBOutlet UIButton *voteButton;

- (IBAction)checkRole:(id)sender;
@end
