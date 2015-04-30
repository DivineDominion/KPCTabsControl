//
//  AppDelegate.h
//  KPCTabsControlDemo
//
//  Created by Cédric Foellmi on 28/10/14.
//  Copyright (c) 2014 Cédric Foellmi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PaneViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property(nonatomic, weak) IBOutlet NSWindow *window;
@property(nonatomic, weak) IBOutlet NSVisualEffectView *vibrancyView;

// Top-levels objects
@property(nonatomic, strong) IBOutlet PaneViewController *vibrancyTopPane;
@property(nonatomic, strong) IBOutlet PaneViewController *vibrancyBottomPane;

@property(nonatomic, strong) IBOutlet PaneViewController *topPane;
@property(nonatomic, strong) IBOutlet PaneViewController *bottomPane;

@end

