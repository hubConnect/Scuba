//
//  DiveListController.h
//  DivePro
//
//  Created by Jon Kotowski on 12/17/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiveListController : UIViewController
<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *DiveListTableView;

@end
