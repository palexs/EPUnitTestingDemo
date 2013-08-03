//
//  ViewController.h
//  EPViewCtrl
//
//  Created by Alexander Perepelitsyn on 5/30/13.
//  Copyright (c) 2013 Alexander Perepelitsyn. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kDummyNotification;

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *currentCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *savedCountLabel;
@property (nonatomic, weak) IBOutlet UIButton *plusButton;
@property (nonatomic, weak) IBOutlet UIButton *minusButton;
@property (nonatomic, weak) IBOutlet UIButton *saveButton;
@property (nonatomic, weak) IBOutlet UIButton *resetButton;

- (IBAction)incrementCount:(id)sender;
- (IBAction)decrementCount:(id)sender;
- (IBAction)saveCount:(id)sender;
- (IBAction)resetCount:(id)sender;

@end
