//
//  WerewolvesAppDelegate.h
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Peer.h"
@interface WerewolvesAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) Peer *peer;
@end
