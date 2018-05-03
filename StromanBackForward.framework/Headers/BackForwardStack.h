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

@property (assign, nonatomic) BOOL isStackEmpty;//就是说栈里面是不是没有状态对象。

/**
 自定义的初始化方法

 @param delegate 代理对象
 @return 实例
 */
- (instancetype)initWithDelegate:(id<BackForwardStackDelegate>)delegate;

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
 有的时候你希望传入的对象被深度复制然后再存储就可以使用此方法。
 使用此方法的前提是你传入的对象所属的类已经遵循了NSCopying或者NSMutableCopying协议。
 并且已经实现了copyWithZone方法。
 比方说有的时候模型记录的是本类的实时状态，但是你要存储的确实该类的不同时刻的状态，
 所以模型对象的地址是不变的，所以你会发现已经存入的对象都是一样的，
 那么本方法就是专门为这种情况提供的接口。

 @param object 希望被深度复制处理的对象。
 */
- (void)addCopiedStatusObject:(id)object;

/**
 清空所有的已经保存的状态对象，把状态恢复到一开始的样子。
 */
- (void)clearAllState;

/**
 清空除了第一个状态对象以外的所有状态。
 */
- (void)clearAllStateExceptFirstOne;

/**
 获取栈中第一个状态对象。

 @return 状态对象
 */
- (BackForwardStackModel *)gainFirstStatusObject;

/**
 打印当前栈的信息。
 */
- (void)printCurrentStack;

@end
