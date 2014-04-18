//
//  TurnWerewolfViewController.h
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>
/*@protocol playerKilledDelegate <NSObject>
    -(void)playerKilled:(NSString*)playerName;
@end*/

@interface TurnWerewolfViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSInteger selectedRow;
    //id<playerKilledDelegate> delegate;
}
@property (weak, nonatomic) IBOutlet UITableView *killList;
@property (strong, nonatomic) NSString *killedName;
@property (assign, nonatomic) int killedID;
@property (weak, nonatomic) IBOutlet UIButton *nextView;

//@property(nonatomic,assign)id delegate;

//-(IBAction)playerSelected;

@end
