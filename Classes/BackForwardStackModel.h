//
//  backForwardStackModel.h
//  前进回退
//
//  Created by iOS开发者 on 2018/4/13.
//  Copyright © 2018年 iOS开发者. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackForwardStackModel : NSObject

@property (assign, nonatomic) BOOL canBack;//判断当前栈是否为空，默认值为否，其实这是个预判操作。
@property (assign, nonatomic) BOOL canForward;//判断当前栈是否已满，默认值为否。
@property (strong, nonatomic) id statusObject;//用来装载状态对象。

@end
