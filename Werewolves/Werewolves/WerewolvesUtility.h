//
//  WerewolvesUtility.h
//  Werewolves
//
//  Created by Gloria Xu on 4/6/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "WerewolvesPlayer.h"
#import "WerewolvesRoom.h"

@class WerewolvesPlayer;

@interface WerewolvesUtility : NSObject

enum RoleType
{
    Moderator, Peasant, Wolf, Oracle, Witch, UndefinedRole
};

+ (void) animateTextField: (UITextField*) textField forView: (UIView *) view up: (BOOL) up;
+ (UITableViewCell *) createCellFor: (WerewolvesPlayer *) player forVote: (BOOL) vote forStatus: (BOOL) status;
+ (void) createPlayerList: (int) number;

@end
