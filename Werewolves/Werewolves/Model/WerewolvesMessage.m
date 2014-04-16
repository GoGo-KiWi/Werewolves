//
//  WerewolvesMessage.m
//  Werewolves
//
//  Created by Gloria Xu on 4/1/14.
//  Copyright (c) 2014 GoGo-KiWi. All rights reserved.
//

#import "WerewolvesMessage.h"

@implementation WerewolvesMessage

- (WerewolvesMessage*) initWithCoder:(NSCoder *) decoder {
    self = [super init];
    
    _messageType = [decoder decodeIntForKey:@"messageType"];
    _senderId = [decoder decodeIntForKey:@"senderId"];
    _receiverId = [decoder decodeIntForKey:@"receiverId"];
    _playerInfo = [decoder decodeObjectForKey:@"playerInfo"];
    _text = [decoder decodeObjectForKey:@"text"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *) encoder {
    [encoder encodeInt:_messageType forKey:@"messageType"];
    [encoder encodeInt:_senderId forKey:@"senderId"];
    [encoder encodeInt:_receiverId forKey:@"receiverId"];
    [encoder encodeObject:_playerInfo forKey:@"playerInfo"];
    [encoder encodeObject:_text forKey:@"text"];
}

-(void) dumpMessage:(NSString *)msg {
    NSLog(@"%@", msg);
}

@end
