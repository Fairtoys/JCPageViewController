//
//  TCPageContainerController.m
//  GetOn
//
//  Created by Cerko on 15/10/19.
//  Copyright © 2015年 Tonchema. All rights reserved.
//

#import "JCPageContainerController.h"
#import "JCOptionTitleBar.h"

@interface JCPageContainerController () <JCOptionTitleBarDelegate>

@end

@implementation JCPageContainerController

#pragma mark - init
- (void)viewDidLoad{
    [super viewDidLoad];

    [self setPageViewControllerDelegate:self];
    self.navigationItem.titleView = self.titleBar;
    [self pageViewController:self didSelectViewController:self.selectedController atIndex:0 fromIndex:0];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - properties
- (JCOptionTitleBar *)titleBar{
    if (!_titleBar) {
        
        _titleBar = [[JCOptionTitleBar alloc]initWithTitles:self.titles selectedIndex:0];
        _titleBar.frame = CGRectMake(0, 0, 120, 44);
        _titleBar.delegate = self;
    }
    return _titleBar;
}

#pragma mark - private
- (NSArray *)titles{
    NSMutableArray *titles = [NSMutableArray array];
    for (UIViewController *viewController in self.controllersCached) {
        [titles addObject:viewController.title];
    }
    return titles.copy;
}

#pragma mark - title bar delegate
- (void)optionTitleBar:(JCOptionTitleBar *)optionTitleBar
  didSelectItemAtIndex:(NSInteger)index
       fromItemAtIndex:(NSInteger)fromIndex{
    
    
    self.selectedIndex = index;
    
    self.navigationItem.leftBarButtonItem = self.selectedController.navigationItem.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = self.selectedController.navigationItem.rightBarButtonItem;
   
}

#pragma mark - pageViewController delegate
- (void)pageViewController:(JCPageViewHController *)pageViewController didSelectViewController:(UIViewController *)viewController atIndex:(NSInteger)index fromIndex:(NSInteger)fromIndex{
    
    self.titleBar.selectedIndex = index;
    self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem;
}

@end
