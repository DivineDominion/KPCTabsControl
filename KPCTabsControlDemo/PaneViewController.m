//
//  PaneViewController.m
//  KPCTabsControl
//
//  Created by Cédric Foellmi on 31/10/14.
//  Copyright (c) 2014 Cédric Foellmi. All rights reserved.
//

#import "PaneViewController.h"
#import "KPCTabsControlConstants.h"

@interface PaneViewController ()
@property (strong) NSArray *titles;
@property (strong) NSDictionary *icons;
@property (strong) NSDictionary *menus;
@end

@implementation PaneViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLabelsUponReframe:)
                                                 name:NSViewFrameDidChangeNotification
                                               object:self.tabsBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUponPaneSelectionDidChange:)
                                                 name:@"PaneSelectionDidChangeNotification"
                                               object:nil];
    
    if ([self.title isEqualToString:@"paneTopLeft"]) {
        self.titles = @[@"Vibrant 1", @"Vibrant 2", @"Vibrant 3", @"Vibrant 4", @"Vibrant 5"];
        NSMenu *tab2Menu = [[NSMenu alloc] init];
        [tab2Menu addItemWithTitle:@"VibrantTab Action 1" action:@selector(showActionAlert:) keyEquivalent:@""];
        [tab2Menu addItemWithTitle:@"VibrantTab Action 2" action:@selector(showActionAlert:) keyEquivalent:@""];
        [[tab2Menu itemArray] makeObjectsPerformSelector:@selector(setTarget:) withObject:self];
        self.menus = @{@"Vibrant 2": tab2Menu};
    }
    else if ([self.title isEqualToString:@"paneBottomLeft"]) {
        self.titles = @[@"Vibrant a", @"Vibrant b", @"Vibrant c", @"Vibrant d"];
    }
    else if ([self.title isEqualToString:@"paneTopRight"]) {
        self.titles = @[@"Tab #a", @"Tab #b", @"Tab #c", @"Tab #d", @"Tab #e", @"Tab #f", @"Tab #g", @"Tab #h"];
    }
    else if ([self.title isEqualToString:@"paneBottomRight"]) {
        self.titles = @[@"Tab #1", @"Tab #2"];
        NSMenu *tab2Menu = [[NSMenu alloc] init];
        [tab2Menu addItemWithTitle:@"Action 1" action:@selector(showActionAlert:) keyEquivalent:@""];
        [tab2Menu addItemWithTitle:@"Action 2" action:@selector(showActionAlert:) keyEquivalent:@""];
        [tab2Menu addItemWithTitle:@"Action 3" action:@selector(showActionAlert:) keyEquivalent:@""];
        [[tab2Menu itemArray] makeObjectsPerformSelector:@selector(setTarget:) withObject:self];
        self.menus = @{@"Tab #2": tab2Menu};
    }
}

- (void)showActionAlert:(id)sender
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setMessageText:@"KPCTabsControl menu action"];
    [alert setInformativeText:[NSString stringWithFormat:@"Action triggered from menu item with title: '%@'", [sender title]]];
    [alert runModal];
}

- (void)awakeFromNib
{
    [super awakeFromNib];

	if ([self.title isEqualToString:@"pane2"]) {
		self.tabsBar.maxTabWidth = 130.0;
		self.tabsBar.minTabWidth = 100.0;
	}

	NSString *labelString = [NSString stringWithFormat:@"min %.0f < %.0f < %.0f max",
							 self.tabsBar.minTabWidth, self.tabsBar.currentTabWidth, self.tabsBar.maxTabWidth];

	[self.tabWidthsLabel setStringValue:labelString];

	[self.tabsBar setPreferFullWidthTabs:self.useFullWidthTabsCheckButton.state];
    [self.tabsBar reloadTabs];
}

- (IBAction)toggleFullWidthTabs:(id)sender
{
	[self.tabsBar setPreferFullWidthTabs:self.useFullWidthTabsCheckButton.state];
}

- (void)mouseDown:(NSEvent *)theEvent
{
    [super mouseDown:theEvent];
    
    BOOL sendNotification = (!self.tabsBar.isHighlighted);

    [self.tabsBar highlight:YES];
    
    if (sendNotification) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PaneSelectionDidChangeNotification"
                                                            object:self
                                                          userInfo:nil];
    }
}

- (void)updateUponPaneSelectionDidChange:(NSNotification *)notif
{
    if ([notif object] != self) {
        [self.tabsBar highlight:NO];
    }
}

- (void)updateLabelsUponReframe:(NSNotification *)notif
{
    NSString *labelString = [NSString stringWithFormat:@"min %.0f < %.0f < %.0f max",
                             self.tabsBar.minTabWidth, self.tabsBar.currentTabWidth, self.tabsBar.maxTabWidth];
    
    [self.tabWidthsLabel setStringValue:labelString];
}

#pragma mark - KPCTabsControlDataSource

- (NSUInteger)tabsControlNumberOfTabs:(KPCTabsControl *)tabControl
{
    return self.titles.count;
}

- (id)tabsControl:(KPCTabsControl *)tabControl itemAtIndex:(NSUInteger)index
{
    return self.titles[index];
}

- (NSString *)tabsControl:(KPCTabsControl *)tabControl titleForItem:(id)item
{
    NSUInteger index = [self.titles indexOfObject:item];
    return (index == NSNotFound) ? @"?" : self.titles[index];
}


#pragma - mark Optionals

- (NSMenu *)tabsControl:(KPCTabsControl *)tabControl menuForItem:(id)item
{
    return [self.menus objectForKey:item];
}

- (NSImage *)tabsControl:(KPCTabsControl *)tabControl iconForItem:(id)item
{
    if ([item isEqualToString:@"Vibrant a"]) {
        return [NSImage imageNamed:@"Star"];
    }
    else if ([item isEqualToString:@"Vibrant b"]) {
        return [NSImage imageNamed:@"Oval"];
    }
    else if ([item isEqualToString:@"Vibrant 2"]) {
        return [NSImage imageNamed:@"Triangle"];
    }
    else if ([item isEqualToString:@"Vibrant 3"]) {
        return [NSImage imageNamed:@"Spiral"];
    }
    else if ([item isEqualToString:@"Vibrant 4"]) {
        return [NSImage imageNamed:@"Polygon"];
    }
    
    return nil;
}

// By returning the same icons as alternative icons, we make sure, the title do not overlap the left-hand place icon,
// and replace the two (left-hand icon and title), with the new icon.
- (NSImage *)tabsControl:(KPCTabsControl *)tabControl titleAlternativeIconForItem:(id)item
{
    if ([item isEqualToString:@"Vibrant a"]) {
        return [NSImage imageNamed:@"Star"];
    }
    else if ([item isEqualToString:@"Vibrant b"]) {
        return [NSImage imageNamed:@"Oval"];
    }
    else if ([item isEqualToString:@"Vibrant 2"]) {
        return [NSImage imageNamed:@"Triangle"];
    }
    else if ([item isEqualToString:@"Vibrant 3"]) {
        return [NSImage imageNamed:@"Spiral"];
    }
    else if ([item isEqualToString:@"Vibrant 4"]) {
        return [NSImage imageNamed:@"Polygon"];
    }
    
    return nil;
}

#pragma - mark KPCTabsControlDelegate

- (BOOL)tabsControl:(KPCTabsControl *)tabControl canReorderItem:(id)item
{
	return YES;
}

- (void)tabsControl:(KPCTabsControl *)tabControl didReorderItems:(NSArray *)itemArray
{
    self.titles = itemArray;
}

- (BOOL)tabsControl:(KPCTabsControl *)tabControl canEditTitleOfItem:(id)item
{
    return YES;
}

- (void)tabsControl:(KPCTabsControl *)tabControl setTitle:(NSString *)title forItem:(id)item
{
    NSLog(@"-> %@", title);
}


@end
