//
//  LoginView.m
//  DivePro
//
//  Created by Jon Kotowski on 3/19/15.
//  Copyright (c) 2015 Jon Kotowski. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView


-(id)init{
    if (self = [super init]) {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil];
        self = [subviewArray objectAtIndex:0];
    }
    return self;
}
@end