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
    const int movementDistance = 150; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    view.frame = CGRectOffset(view.frame, 0, movement);
    [UIView commitAnimations];
}

+ (UITableViewCell *) createCellFor: (WerewolvesPlayer *) player forVote: (BOOL) vote forStatus: (BOOL) status
{
    UITableViewCell *cell;
    if (vote){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                               reuseIdentifier:@"voteIdentifier"];
    }
    else{
        cell = [[UITableViewCell alloc]init];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"#%d %@", [player playerId], [player playerName]];
    if (status){
        cell.imageView.image = [UIImage imageNamed:@"icon_undefined.png"];
    }
    else{
    switch ([player role]) {
        case Peasant:
            cell.imageView.image = [UIImage imageNamed:@"icon_village.png"];
            break;
        case Wolf:
            cell.imageView.image = [UIImage imageNamed:@"icon_werewolf.png"];
            break;
        case Witch:
            cell.imageView.image = [UIImage imageNamed:@"icon_witch.png"];
            break;
        case Oracle:
            cell.imageView.image = [UIImage imageNamed:@"icon_oracle.png"];
            break;
        case UndefinedRole:
            cell.imageView.image = [UIImage imageNamed:@"icon_undefined.png"];
            break;
        default:
            break;
    }
    }
    
    if (vote && [player alive]){
        if ([player voteNominate] == -1){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Not voted yet"];
        }
        else{
            cell.detailTextLabel.text = [NSString stringWithFormat:@"-> %d",[player voteNominate]];
        }
    }
    
    if ([player alive] == NO){
        [cell setTextColor:[UIColor grayColor]];
        [cell setUserInteractionEnabled:NO];
    }
    return cell;
}

// Just for test
+ (void) createPlayerList: (int) number
{
    WerewolvesRoom *room = [WerewolvesRoom getInstance];
    for (int i = 0; i < number; i ++){
        WerewolvesPlayer * tempPlayer = [[WerewolvesPlayer alloc] init];
        NSString * tempName = [[NSString alloc] initWithFormat:@"Player %d", i + 1];
        //[tempPlayer setPlayerName:tempName];
        [tempPlayer setPlayerName:tempName];
        [tempPlayer setVoteNominate:-1];
        //[tempPlayer setPlayerId:i];
        [room addPlayer:tempPlayer];
    }

    //[room generateRandomRoles];
}
@end
