//
//  WerewolvesUtility.m
//  Werewolves
//
//  Created by Gloria Xu on 4/6/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesUtility.h"

@implementation WerewolvesUtility

+ (void) animateTextField: (UITextField*) textField forView: (UIView *) view up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    view.frame = CGRectOffset(view.frame, 0, movement);
    [UIView commitAnimations];
}

+ (UITableViewCell *) createCellFor: (enum RoleType) role WithName: (NSString *) name
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = name;
    switch (role) {
        case Peasant:
            cell.imageView.image = [UIImage imageNamed:@"icon_village.png"];
            break;
        case Wolf:
            cell.imageView.image = [UIImage imageNamed:@"icon_werewolf.png"];
            break;
        case Witch:
            cell.imageView.image = [UIImage imageNamed:@"icon_witch.png"];
            break;
        case FortuneTeller:
            cell.imageView.image = [UIImage imageNamed:@"icon_oracle.png"];
            break;
        default:
            break;
    }
    return cell;
}


@end
