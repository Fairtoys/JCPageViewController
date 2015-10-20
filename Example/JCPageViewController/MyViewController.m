//
//  MyViewController.m
//  TransitionController
//
//  Created by Cerko on 15/10/19.
//  Copyright © 2015年 Cerko. All rights reserved.
//

#import "MyViewController.h"

@implementation MyViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc]init];
    label.text = self.title;
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
    self.view.backgroundColor = [UIColor whiteColor];
    
}




@end
