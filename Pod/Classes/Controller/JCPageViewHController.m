//
//  JCPageViewHController.m
//  TransitionController
//
//  Created by Cerko on 15/10/19.
//  Copyright © 2015年 Cerko. All rights reserved.
//

#import "JCPageViewHController.h"

@interface JCPageViewHController ()

@property (nonatomic, strong) NSArray<__kindof UIViewController *> *controllersCached;

@property (nonatomic, weak) UIViewController *tempSelectedController;

@end

@implementation JCPageViewHController

#pragma mark - init

- (instancetype)initWithControllersCached:(NSArray *)controllersCached firstShowIndex:(NSInteger)firstShowIndex{
    if (self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil]) {
        [self setDataSource:self];
        [self setDelegate:self];


        self.controllersCached = controllersCached;
        self.selectedIndex = firstShowIndex;
    }
    return self;
}

- (instancetype)initWithControllersCached:(NSArray *)controllersCached{
    return [self initWithControllersCached:controllersCached firstShowIndex:0];
}



#pragma mark - public
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    [self setSelectedController:self.controllersCached[selectedIndex]];
}

- (NSInteger)selectedIndex{
    return [self.controllersCached indexOfObject:self.selectedController];
}

- (void)setSelectedController:(UIViewController *)selectedController{
    if (selectedController == _selectedController) {
        return;
    }
    NSInteger first = _selectedController ? [self.controllersCached indexOfObject:_selectedController] : -1;
    NSInteger second = [self.controllersCached indexOfObject:selectedController];
    
    [self setViewControllers:@[selectedController]
                   direction: (first < second) ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse
                    animated:_selectedController completion:NULL];
    
    _selectedController = selectedController;
}



#pragma mark - UIPageViewController Datasource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger index = [self.controllersCached indexOfObject:viewController];
    if (index == (self.controllersCached.count - 1)) {
        return nil;
    }
    return self.controllersCached[index + 1];

}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.controllersCached indexOfObject:viewController];
    if (!index) {
        return nil;
    }
    return self.controllersCached[index - 1];
}




#pragma mark - delegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    self.tempSelectedController = pendingViewControllers[0];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed && self.tempSelectedController) {
        //设置当前选中的controller
        _selectedController = self.tempSelectedController;

        if ([self.pageViewControllerDelegate respondsToSelector:@selector(pageViewController:didSelectViewController:atIndex:fromIndex:)]) {
            
            //获取当前选中的ViewController的索引
            NSInteger index = [self.controllersCached indexOfObject:self.tempSelectedController];
            //获取之前的controller的索引
            NSInteger fromIndex = [self.controllersCached indexOfObject:previousViewControllers[0]];
            
            //回调
            [self.pageViewControllerDelegate pageViewController:self didSelectViewController:self.tempSelectedController atIndex:index fromIndex:fromIndex];
            
        }
        self.tempSelectedController = nil;

    }
}



@end
