//
//  WerewolvesModeratorPlayer.m
//  Werewolves
//
//  Created by Zijia Lu on 14-4-18.
//  Copyright (c) 2014年 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesPlayerRoot.h"
@implementation WerewolvesPlayerRoot

+ (WerewolvesPlayerRoot*) getInstance {
    if (playerRootInstance == nil) {
        playerRootInstance = [[WerewolvesPlayerRoot alloc] init];
    }
    return playerRootInstance;
}

@end
