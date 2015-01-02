//
//  DiveLocation.h
//  DivePro
//
//  Created by Jon Kotowski on 12/27/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DiveLocation : NSObject

@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSString *Creator;
@property (strong, nonatomic) NSArray *Pictures;
@property float Rating;
@property (nonatomic) CLLocationCoordinate2D Coordinates;
@property (strong, nonatomic) PFFile *picture;

@end
