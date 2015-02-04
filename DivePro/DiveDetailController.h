//
//  DiveDetailController.h
//  DivePro
//
//  Created by Jon Kotowski on 1/18/15.
//  Copyright (c) 2015 Jon Kotowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiveDetailController : UIViewController
<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *DivePhotoGallery;
@property (strong, nonatomic) IBOutlet UICollectionViewCell *CellImage;

@end
