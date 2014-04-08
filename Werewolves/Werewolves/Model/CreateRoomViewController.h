//
//  CreateRoomViewController.h
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface CreateRoomViewController : UIViewController <UITextFieldDelegate,MCBrowserViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *roomName;


- (IBAction)browseForDevices:(id)sender;
- (IBAction)toggleVisibility:(id)sender;
- (IBAction)disconnect:(id)sender;

@end
