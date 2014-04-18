//
//  WerewolvesPlayerRoot.h
//  Werewolves
//
//  Created by Zijia Lu on 14-4-18.
//  Copyright (c) 2014年 GoGo-KiWi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WerewolvesUtility.h"

@interface WerewolvesPlayerRoot : NSObject
@property WerewolvesPlayer* myPlayerInstance;
+ (WerewolvesPlayerRoot*) getInstance;
@end

static WerewolvesPlayerRoot* playerRootInstance = nil;
