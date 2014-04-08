//
//  JoinRoomViewController.h
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface JoinRoomViewController : UIViewController <MCBrowserViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *roomList;

- (IBAction)browseForDevices:(id)sender;

@end
