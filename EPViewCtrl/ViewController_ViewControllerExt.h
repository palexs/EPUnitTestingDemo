//
//  ViewController_ViewControllerExt.h
//  EPViewCtrl
//
//  Created by Alexander Perepelitsyn on 5/31/13.
//  Copyright (c) 2013 Alexander Perepelitsyn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSNotificationCenter *notificationCenter;

- (void)onSave:(NSNotification *)notif;

@end
