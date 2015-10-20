//
//  TCPageContainerController.h
//  GetOn
//
//  Created by Cerko on 15/10/19.
//  Copyright © 2015年 Tonchema. All rights reserved.
//

#import "JCPageViewHController.h"

@class JCOptionTitleBar;

@interface JCPageContainerController : JCPageViewHController <JCPageViewHControllerDelegate>

@property (nonatomic, strong) JCOptionTitleBar *titleBar;


@end
