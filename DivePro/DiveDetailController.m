//
//  DiveDetailController.m
//  DivePro
//
//  Created by Jon Kotowski on 1/18/15.
//  Copyright (c) 2015 Jon Kotowski. All rights reserved.
//

#import "DiveDetailController.h"
#import "DiveLocation.h"
#import "AppDelegate.h"

@interface DiveDetailController ()

@end

@implementation DiveDetailController

DiveLocation *DiveToShow;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appD = [UIApplication sharedApplication].delegate;
    DiveToShow = appD.DiveToShow;
    NSLog(@"%@",DiveToShow.Name);
    
    self.DivePhotoGallery.delegate = self;
    self.DivePhotoGallery.dataSource = self;
    
    // Do any additional setup after loading the view.
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"cvCell";
    
    UICollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                              forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:1001];
    recipeImageView.image = [UIImage imageNamed:@"arrow"];
    
    
    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor blueColor]; // highlight selection
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor redColor]; // Default color
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return DiveToShow.Pictures.count;
}

- (void) setPhotos {
    
    for (PFFile *file in DiveToShow.Pictures) {
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
