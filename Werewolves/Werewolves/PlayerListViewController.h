//
//  PlayerListViewController.h
//  Werewolves
//
//  Created by Gloria Xu on 4/8/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerListViewController : UIViewController <UITableViewDelegate>

@property (strong, nonatomic) NSString *roomNameText;
@property (weak, nonatomic) IBOutlet UITableView *playerList;

@end
