//
//  ViewController.m
//  TransitionController
//
//  Created by Cerko on 15/10/19.
//  Copyright © 2015年 Cerko. All rights reserved.
//

#import "JCViewController.h"
#import "MyViewController.h"
#import "JCPageViewHController.h"
#import "JCOptionTitleBar.h"

@interface JCViewController () <JCPageViewHControllerDelegate, JCOptionTitleBarDelegate>

@property (nonatomic, strong) UIViewController *vc1;
@property (nonatomic, strong) UIViewController *vc2;
@property (nonatomic, strong) UIViewController *vc3;

@property (nonatomic, strong) JCPageViewHController *controller;

@end

@implementation JCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.center = self.view.center;
    [btn sizeToFit];
    [self.view addSubview:btn];
    
    JCOptionTitleBar *optionBar = [[JCOptionTitleBar alloc]initWithTitles:@[@"用户",@"活动",@"群组"] selectedIndex:0];
    [optionBar setDelegate:self];
    optionBar.frame = CGRectMake(0, 80, 200, 100);
    [self.view addSubview:optionBar];
    
}



- (void)onClick{
    JCPageViewHController *pageViewController = [[JCPageViewHController alloc]initWithControllersCached:@[self.vc1,self.vc2,self.vc3] firstShowIndex:2];
    [pageViewController setPageViewControllerDelegate:self];
    [self presentViewController:pageViewController animated:YES completion:NULL];
    _controller = pageViewController;
    
}

#pragma mark - delegate
#pragma mark pageViewcontroller
- (void)pageViewController:(JCPageViewHController *)pageViewController
   didSelectViewController:(UIViewController *)viewController
                   atIndex:(NSInteger)index
                 fromIndex:(NSInteger)fromIndex
{
    NSLog(@"controllerTitle:%@ ,index:%ld, fromIndex:%ld",viewController.title, index,fromIndex );
}
#pragma mark optionbarDelegate
- (void)optionTitleBar:(JCOptionTitleBar *)optionTitleBar didSelectItemAtIndex:(NSInteger)index fromItemAtIndex:(NSInteger)fromIndex{
    NSLog(@"selectIndex:%ld, fromIndex:%ld", index, fromIndex);
}


#pragma mark properties

- (UIViewController *)vc1{
    if (!_vc1) {
        _vc1 = [[MyViewController alloc]init ];
        _vc1.title = @"vc1";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"touch" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onTouch) forControlEvents:UIControlEventTouchUpInside];
        button.center = self.view.center;
        [button sizeToFit];
        [_vc1.view addSubview:button];
    }
    return _vc1;
}
- (void)onTouch{
    self.controller.selectedIndex = 2;
}

- (UIViewController *)vc2{
    if (!_vc2) {
        _vc2 = [[MyViewController alloc]init];
        _vc2.title = @"vc2";
    }
    return _vc2;
}

- (UIViewController *)vc3{
    if (!_vc3) {
        _vc3 = [[MyViewController alloc]init];
        _vc3.title = @"vc3";
    }
    return _vc3;
}





@end
