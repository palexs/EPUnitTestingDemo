//
//  FakeNotificationCenter.h
//  EPViewCtrl
//
//  Created by Alexander Perepelitsyn on 5/31/13.
//  Copyright (c) 2013 Alexander Perepelitsyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeNotificationCenter : NSObject

- (void)addObserver:(NSObject *)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
- (void)removeObserver:(NSObject *)observer;
- (BOOL)hasObject:(id)observer forNotification:(NSString *)aName;

@end
