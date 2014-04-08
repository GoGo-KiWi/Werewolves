//
//  TurnWerewolfViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "TurnWerewolfViewController.h"

@interface TurnWerewolfViewController ()

@end

@implementation TurnWerewolfViewController
@synthesize killList;

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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = [NSString stringWithFormat:@"# %ld", (long)[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"Player %ld", (long)[indexPath row]];
    switch ([indexPath row]){
        case 2: cell.imageView.image = [UIImage imageNamed:@"icon_oracle.png"]; break;
        case 4: cell.imageView.image = [UIImage imageNamed:@"icon_witch.png"]; break;
        default: cell.imageView.image = [UIImage imageNamed:@"icon_village.png"];

    }
    //cell.textLabel.tag = [(NSInteger) [indexPath row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [delegate playerKilled:[NSString stringWithFormat:@"# %ld", (long) indexPath.row]];

}

-(IBAction)playerSelected
{
    //Is anyone listening
    //if([delegate respondsToSelector:@selector(playerKilled:)])
    //{
        //send the delegate function with the amount entered by the user
        [delegate playerKilled:[NSString stringWithFormat:@"# %ld", (long) selectedRow]];
        UIAlertView *messageAlert = [[UIAlertView alloc]
                                     initWithTitle:@"Success" message:@"success!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        // Display Alert Message
        [messageAlert show];
    //}
    
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
