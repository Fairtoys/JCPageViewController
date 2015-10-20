//
//  JCOptionTitleBar.m
//  TransitionController
//
//  Created by Cerko on 15/10/19.
//  Copyright © 2015年 Cerko. All rights reserved.
//

#import "JCOptionTitleBar.h"
#import "Masonry.h"

@interface JCOptionTitleBar ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *items;

@end

@implementation JCOptionTitleBar

- (instancetype)initWithTitles:(NSArray <NSString *> *)titles selectedIndex:(NSInteger)selectedIndex{
    
    if (self = [super init]) {
        self.selectedIndex = selectedIndex;
        self.colorItemNormal = [UIColor grayColor];
        self.colorItemSelected = [UIColor yellowColor];
        [self addSubItemsWithTitles:titles selectedIndex:selectedIndex];
    }
    
    return self;
}


- (instancetype)initWithTitles:(NSArray <NSString *> *)titles{
    return [self initWithTitles:titles selectedIndex:0];
}



- (void)addSubItemsWithTitles:(NSArray <NSString *> *)titles selectedIndex:(NSInteger)selectedIndex{
    

    
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.colorItemNormal forState:UIControlStateNormal];
        [btn setTitleColor:self.colorItemSelected forState:UIControlStateSelected];
        [btn setSelected:idx == selectedIndex];
        [btn addTarget:self action:@selector(onItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:btn];
        [self.items addObject:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            
        }];
        
    }];
    
    
}

- (void)updateConstraints{
    UIView *viewTemp;
    for (NSInteger i = 0, count = self.items.count ; i < count; i++) {
        UIView *subView = self.items[i];
        [subView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (!viewTemp) {
                make.left.equalTo(self);
            }else{
                make.left.equalTo(viewTemp.mas_right);
            }
            make.width.equalTo(self).multipliedBy(1.f / count);
        }];
        
        viewTemp = subView;
    }
    [super updateConstraints];
}


#pragma mark - action
- (void)onItemClick:(UIButton *)btn{
    UIButton *buttonSelected = self.items[self.selectedIndex];
    if (buttonSelected == btn) {
        return;
    }
    
    NSInteger selectedIndex = [self.items indexOfObject:btn];
    
    buttonSelected.selected = NO;
    btn.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(optionTitleBar:didSelectItemAtIndex:fromItemAtIndex:)]) {
        
        [self.delegate optionTitleBar:self
                  didSelectItemAtIndex:selectedIndex
                      fromItemAtIndex:self.selectedIndex];
    }
    
    self.selectedIndex = selectedIndex;
    
}

#pragma mark - public
- (NSMutableArray<UIButton *> *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if (_selectedIndex == selectedIndex) {
        return;
    }
    UIButton *buttonSelected = self.items[_selectedIndex];
    buttonSelected.selected = NO;
    buttonSelected = self.items[selectedIndex];
    buttonSelected.selected = YES;
    
    _selectedIndex = selectedIndex;
    
}

- (void)setFont:(UIFont *)font{
    [self.items enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.titleLabel.font = font;
    }];
    _font = font;
}

- (void)setColorItemNormal:(UIColor *)colorItemNormal{
    [self.items enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitleColor:colorItemNormal forState:UIControlStateNormal];
    }];
    _colorItemNormal = colorItemNormal;
}

- (void)setColorItemSelected:(UIColor *)colorItemSelected{
    [self.items enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitleColor:colorItemSelected forState:UIControlStateSelected];
    }];
    _colorItemSelected = colorItemSelected;
}

@end
