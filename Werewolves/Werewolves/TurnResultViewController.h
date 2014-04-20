//
//  TurnResultViewController.h
//  Werewolves
//
//  Created by Fiona Yang on 4/12/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TurnResultViewController : UIViewController
@property (strong, nonatomic) NSString *killedPlayer1;
@property (strong, nonatomic) NSString *killedPlayer2;
@property (weak, nonatomic) IBOutlet UITextView *killedLabel;
@property (assign, nonatomic) int killedPlayerID1;
@property (assign, nonatomic) int killedPlayerID2;
@end
