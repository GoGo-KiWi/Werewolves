//
//  WerewolvesUtility.h
//  Werewolves
//
//  Created by Gloria Xu on 4/6/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WerewolvesUtility : NSObject

enum RoleType
{
    Moderator, Peasant, Wolf, Oracle, Witch, UndefinedRole
};

+ (void) animateTextField: (UITextField*) textField forView: (UIView *) view up: (BOOL) up;
+ (UITableViewCell *) createCellFor: (enum RoleType) role WithName: (NSString *) name;

@end
