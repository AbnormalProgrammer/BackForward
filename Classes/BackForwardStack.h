//
//  backForwardStack.h
//  前进回退
//
//  Created by iOS开发者 on 2018/4/13.
//  Copyright © 2018年 iOS开发者. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BackForwardStackModel.h"

@protocol BackForwardStackDelegate <NSObject>

/**
 判断当前是栈空还是栈满，就是回调当前栈的状态。

 @param backNumber 还有多少可以回退的对象
 @param forwardNumber 还有多少可以前进的对象。
 */
- (void)currentStackStatusBackObjectsNumber:(NSInteger)backNumber forwardObjectsNumber:(NSInteger)forwardNumber;

@end

@interface BackForwardStack : NSObject

@property (weak, nonatomic) id<BackForwardStackDelegate> delegate;

/**
 回退操作，如果已经达到栈底就返回nil。
 可以通过判断标志位来判定是否已经达到栈底。

 @return 返回状态对象。
 */
- (BackForwardStackModel *)backAction;

/**
 前进操作，如果已经达到栈顶就返回nil。
可以通过判断标志位来判定是否已经达到栈顶。

 @return 返回的状态对象。
 */
- (BackForwardStackModel *)forwardAction;

/**
 添加状态对象

 @param object 某状态对象
 */
- (void)addStatusObject:(id)object;

/**
 打印当前栈的信息。
 */
- (void)printCurrentStack;

@end
