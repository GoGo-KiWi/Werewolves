//
//  TurnOracleViewController.h
//  Werewolves
//
//  Created by Fiona Yang on 4/6/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TurnOracleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *playerList;
@property (strong, nonatomic) NSString *killedPlayer1;
@property (strong, nonatomic) NSString *killedPlayer2;
@property (assign, nonatomic) int killedPlayerID1;
@property (assign, nonatomic) int killedPlayerID2;
@end
