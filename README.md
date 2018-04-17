# StromanBackForward

## 功能
>它是一个容器，用来实现类似于网页或者word的撤销和恢复功能。它通过把状态抽象成对象，并操作状态对象来实现撤销和恢复的功能。

## Demo演示
![演示](/images/demo.gif)

## API&使用方法
>你需要把状态数据封装成数据模型对象。**注意!**你需要把初始状态或者重置以后的状态也封装成状态对象传递给该容器，这样才能保证该容器正常工作。
>使用的时候在Podfile中添加`pod 'StromanBackForward', '~> 1.0.4'`。
>使用的时候直接加入`#import <StromanBackForward/StromanBackForward.h>`即可。
>你最好让使用的类遵循`BackForwardStackDelegate`协议。
>1. `- (void)currentStackStatusBackObjectsNumber:(NSInteger)backNumber forwardObjectsNumber:(NSInteger)forwardNumber;`:回调，用来回调此时可以回退多少个状态和恢复多少个状态。
>2. `- (instancetype)initWithDelegate:(id<BackForwardStackDelegate>)delegate;`:初始化方法。就这一个，之所以要把`delegate`放到初始化方法中，是因为如果不这样做，容器在初始化阶段是没有回调出来的。
>3. `- (BackForwardStackModel *)backAction`:用于撤销功能，它回退出一个容器模型`BackForwardStackModel`，这个模型带有一个标志位`canBack`用来判断弹出来的状态对象是否可用。
>4. `- (BackForwardStackModel *)forwardAction;`:用于恢复功能，它包含了同样类型的数据模型，它的标志位`canForward`用于判断弹出来的状态对象是否可用。
>5. `- (void)addStatusObject:(id)object;`:它用于添加状态对象。
>6. `- (void)clearAllState;`:用于清空所有的状态。
>7. `- (void)printCurrentStack;`:用于打印容器中的状态。

## 适用平台
>1. iOS平台，要求iOS 8.0及以上。
>2. 支持ARC，不支持MRC。
