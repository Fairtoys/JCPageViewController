//
//  JCOptionTitleBar.h
//  TransitionController
//
//  Created by Cerko on 15/10/19.
//  Copyright © 2015年 Cerko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JCOptionTitleBar;
@protocol JCOptionTitleBarDelegate <NSObject>

- (void)optionTitleBar:(JCOptionTitleBar *)optionTitleBar didSelectItemAtIndex:(NSInteger)index fromItemAtIndex:(NSInteger)fromIndex;

@end


@interface JCOptionTitleBar : UIView

@property (nonatomic, weak) id <JCOptionTitleBarDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *colorItemSelected;

@property (nonatomic, strong) UIColor *colorItemNormal;

- (instancetype)initWithTitles:(NSArray <NSString *> *)titles selectedIndex:(NSInteger)selectedIndex;

@end

NS_ASSUME_NONNULL_END