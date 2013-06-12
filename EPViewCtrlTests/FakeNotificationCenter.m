//
//  FakeNotificationCenter.m
//  EPViewCtrl
//
//  Created by Alexander Perepelitsyn on 5/31/13.
//  Copyright (c) 2013 Alexander Perepelitsyn. All rights reserved.
//

#import "FakeNotificationCenter.h"

@interface FakeNotificationCenter ()
{
    NSMutableDictionary *observers;
}
@end

@implementation FakeNotificationCenter

- (id)init
{
    self = [super init];
    if (self) {
        observers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addObserver:(NSObject *)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
    [observers setObject:observer forKey:aName];
}

- (void)removeObserver:(NSObject *)observer
{
    [[observers copy] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isEqual:observer]) {
            [observers removeObjectForKey:key];
        }
    }];
}

- (BOOL)hasObject:(id)observer forNotification:(NSString *)aName
{
    return [[observers objectForKey:aName] isEqual:observer];
}

@end
