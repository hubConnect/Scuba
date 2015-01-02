//
//  DiveListCellTableViewCell.h
//  DivePro
//
//  Created by Jon Kotowski on 12/29/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiveListCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;
@property (strong, nonatomic) IBOutlet UIView *RatingViewOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *Photo;

@end
