//
//  PlayerVoteViewController.h
//  Werewolves
//
//  Created by Fiona Yang on 4/14/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerVoteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *voteList;
@property (assign, nonatomic) int votedPlayer;
@end
