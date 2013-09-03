//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}


-(NSString *)imageUrl{
    
    return [self.user valueOrNilForKeyPath:@"profile_image_url"];
}

-(NSString *)name{
    return [self.user valueOrNilForKeyPath:@"name"];
}

-(NSString *)handle{
    return [self.user valueOrNilForKeyPath:@"screen_name"];
}


+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

-(RestObject *)user{
    if (!_user){
        _user = [self.data valueOrNilForKeyPath:@"user"];
    }
    return _user;
    
}

@end
