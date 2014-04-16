//
//  TurnWitchSaveViewController.h
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TurnWerewolfViewController.h"

@interface TurnWitchSaveViewController : UIViewController //<playerKilledDelegate>

@property (weak, nonatomic) IBOutlet UILabel *playerKilledInfo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *saveInfo;
//@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSString *killedPlayerName;
@property (assign, nonatomic) int killedPlayerID;

- (IBAction)saveAction:(id)sender;
@end
