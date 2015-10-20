//
//  JCPageViewHController.h
//  TransitionController
//
//  Created by Cerko on 15/10/19.
//  Copyright © 2015年 Cerko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JCPageViewHController;
@protocol JCPageViewHControllerDelegate <NSObject>

@optional
/**
 *  PageViewController 滑动的回调
 *
 *  @param pageViewController pageViewController
 *  @param viewController     当前选中的controller
 *  @param index              当前选中的controller的索引
 *  @param fromIndex          当前的controller是从哪个索引变过来的
 */
- (void)pageViewController:(JCPageViewHController *)pageViewController
   didSelectViewController:(UIViewController *)viewController
                   atIndex:(NSInteger)index
                 fromIndex:(NSInteger)fromIndex;

@end

@interface JCPageViewHController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, readonly) NSArray<__kindof UIViewController *> *controllersCached;

@property (nonatomic, assign) NSInteger selectedIndex;//当前选中controller的位置
@property (nonatomic, strong) UIViewController *selectedController;//当前选中的controller,必须在cotrollersCached里面的Controller

@property (nonatomic, weak, nullable) id<JCPageViewHControllerDelegate> pageViewControllerDelegate;

/**
 *  初始化
 *
 *  @param controllersCached controller数组
 *  @param firstShowIndex    当前要显示哪一个controller
 *
 *  @return PageViewcontroller
 */
- (instancetype)initWithControllersCached:(NSArray<__kindof UIViewController *> *)controllersCached firstShowIndex:(NSInteger)firstShowIndex;

- (instancetype)initWithControllersCached:(NSArray<__kindof UIViewController *> *)controllersCached;


@end

NS_ASSUME_NONNULL_END
