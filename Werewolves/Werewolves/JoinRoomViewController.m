//
//  JoinRoomViewController.m
//  Werewolves
//
//  Created by Fiona Yang on 4/5/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "JoinRoomViewController.h"
#import "WerewolvesAppDelegate.h"
#import "WerewolvesPlayerRoot.h"
#import "PlayerListViewController.h"
#import "PlayerViewController.h"

@interface JoinRoomViewController ()
@property (nonatomic, strong) WerewolvesAppDelegate *appDelegate;
@property (nonatomic, strong) NSMutableArray *arrConnectedDevices;

@end

@implementation JoinRoomViewController

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
    _appDelegate = (WerewolvesAppDelegate *)[[UIApplication sharedApplication] delegate];
    WerewolvesPlayer *curPlayer = [[WerewolvesPlayer alloc]init];
    WerewolvesPlayerRoot *playerRoot = [WerewolvesPlayerRoot getInstance];
    [curPlayer registerPlayer:self.userName];
    playerRoot.myPlayerInstance = curPlayer;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(peerDidChangeStateWithNotification:)
                                                 name:@"MCDidChangeStateNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveDataWithNotification:)
                                                 name:@"MCDidReceiveDataNotification"
                                               object:nil];
    _arrConnectedDevices = [[NSMutableArray alloc] init];
    
    [_roomList setDelegate:self];
    [_roomList setDataSource:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public method implementation

- (IBAction)browseForDevices:(id)sender {
    [[_appDelegate peer] setupMCBrowser];
    [[[_appDelegate peer] browser] setDelegate:self];
    [self presentViewController:[[_appDelegate peer] browser] animated:YES completion:nil];
}


#pragma mark - MCBrowserViewControllerDelegate method implementation

-(void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [_appDelegate.peer.browser dismissViewControllerAnimated:YES completion:nil];
}

-(void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [_appDelegate.peer.browser dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - UITableView Delegate and Datasource method implementation

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrConnectedDevices count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    cell.textLabel.text = [_arrConnectedDevices objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

#pragma mark - Private method implementation

-(void)peerDidChangeStateWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    MCSessionState state = [[[notification userInfo] objectForKey:@"state"] intValue];
    
    if (state != MCSessionStateConnecting) {
        if (state == MCSessionStateConnected) {
            [_arrConnectedDevices addObject:peerDisplayName];
        }
        else if (state == MCSessionStateNotConnected){
            if ([_arrConnectedDevices count] > 0) {
                int indexOfPeer = [_arrConnectedDevices indexOfObject:peerDisplayName];
                [_arrConnectedDevices removeObjectAtIndex:indexOfPeer];
            }
        }
        [_roomList reloadData];
        
        //BOOL peersExist = ([[_appDelegate.peer.session connectedPeers] count] == 0);
       // [_btnDisconnect setEnabled:!peersExist];
       // [_txtName setEnabled:peersExist];
    }
}

-(void)didReceiveDataWithNotification:(NSNotification *)notification{
    MCPeerID *peerID = [[notification userInfo] objectForKey:@"peerID"];
    NSString *peerDisplayName = peerID.displayName;
    
    NSData *receivedData = [[notification userInfo] objectForKey:@"data"];
    WerewolvesMessage *receivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:receivedData];
    
    if ([receivedMsg messageType] == StartGame) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self performSegueWithIdentifier: @"ShowRoleSegue" sender: self];
        });
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayerListSegue"]){
        if ([segue.destinationViewController isMemberOfClass:[PlayerListViewController class]]) {
            NSArray *allClients = self.appDelegate.peer.session.connectedPeers;
            NSError *error;
            WerewolvesMessage *startMsg = [[WerewolvesMessage alloc]init];
            startMsg.messageType = StartGame;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:startMsg];
            [self.appDelegate.peer.session sendData:data
                                            toPeers:allClients
                                           withMode:MCSessionSendDataReliable
                                              error:&error];
            if (error) {
                NSLog(@"%@", [error localizedDescription]);
            }
            NSLog(@"SEND");
        }
    } else if ([segue.identifier isEqualToString:@"ShowRoleSegue"]) {
        if ([segue.destinationViewController isMemberOfClass:[PlayerViewController class]]) {
            PlayerViewController *controller = (PlayerViewController *)segue.destinationViewController;
        }
    }
}

- (IBAction)createPlayerObject:(id)sender {
    
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
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    NSString *name = [NSString stringWithFormat:@"Room %ld", (long)[indexPath row]];
    cell.textLabel.text = name;
    return cell;
}
*/

@end
