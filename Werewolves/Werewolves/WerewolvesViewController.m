//
//  WerewolvesViewController.m
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesViewController.h"
#import "WerewolvesMessage.h"

@interface WerewolvesViewController ()

@end

@implementation WerewolvesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WerewolvesMessage *msg = [[WerewolvesMessage alloc]init];
    [msg dumpMessage:@"xxx"];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
