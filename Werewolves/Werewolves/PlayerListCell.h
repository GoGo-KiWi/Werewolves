//
//  PlayerListCell.h
//  Werewolves
//
//  Created by Fiona Yang on 4/6/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerListCell : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *userImage;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *numberlLabel;

@end
