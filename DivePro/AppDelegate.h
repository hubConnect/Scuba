//
//  AppDelegate.h
//  DivePro
//
//  Created by Jon Kotowski on 12/5/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//
#import "DiveListController.h"
#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray * arrayOfLocations;
@property (weak, nonatomic) UITableView * DLC;


@end

