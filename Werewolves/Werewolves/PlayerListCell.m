//
//  PlayerListCell.m
//  Werewolves
//
//  Created by Fiona Yang on 4/6/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "PlayerListCell.h"

@interface PlayerListCell ()

@end

@implementation PlayerListCell
@synthesize nameLabel = _nameLabel;
@synthesize numberlLabel = _numberLabel;
@synthesize userImage = _userImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
