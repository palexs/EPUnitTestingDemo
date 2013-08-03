//
//  ViewController.m
//  EPViewCtrl
//
//  Created by Alexander Perepelitsyn on 5/30/13.
//  Copyright (c) 2013 Alexander Perepelitsyn. All rights reserved.
//

#import "ViewController.h"
#import "ViewController_ViewControllerExt.h"

NSString * const kDummyNotification = @"DummyNotification";

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
        _notificationCenter = [NSNotificationCenter defaultCenter];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNumber *countNumber = [_userDefaults objectForKey:@"countValue"];
    if (countNumber) {
        self.savedCountLabel.text = [NSString stringWithFormat:@"%i", [countNumber integerValue]];
    } else {
        self.savedCountLabel.text = @"-";
    }
    
    _count = [countNumber integerValue];
    
    self.currentCountLabel.text = [NSString stringWithFormat:@"%i", _count];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.notificationCenter addObserver:self selector:@selector(onSave:) name:kDummyNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.notificationCenter removeObserver:self];
    
    [super viewWillDisappear:animated];
}

- (void)onSave:(NSNotification *)notif
{
    NSInteger countInt = [[[notif userInfo] objectForKey:@"countValue"] integerValue];
    self.savedCountLabel.text = [NSString stringWithFormat:@"%i", countInt];
}

- (IBAction)incrementCount:(id)sender
{
    _count++;
    [self.currentCountLabel setText:[NSString stringWithFormat:@"%i", _count]];
}

- (IBAction)decrementCount:(id)sender
{
    _count--;
    [self.currentCountLabel setText:[NSString stringWithFormat:@"%i", _count]];
}

- (IBAction)saveCount:(id)sender;
{
    [_userDefaults setObject:[NSNumber numberWithInt:self.count] forKey:@"countValue"];
    [_userDefaults synchronize];
    NSDictionary *userInfo = @{@"countValue" : [NSNumber numberWithInt:_count]};
    [self.notificationCenter postNotificationName:kDummyNotification object:self userInfo:userInfo];
}

- (IBAction)resetCount:(id)sender
{
    _count = 0;
    [self.currentCountLabel setText:[NSString stringWithFormat:@"%i", _count]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    self.currentCountLabel = nil;
    self.plusButton = nil;
    self.minusButton = nil;
    
    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }
}

- (void)dealloc
{

}

@end
