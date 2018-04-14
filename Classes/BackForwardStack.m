//
//  backForwardStack.m
//  前进回退
//
//  Created by iOS开发者 on 2018/4/13.
//  Copyright © 2018年 iOS开发者. All rights reserved.
//

#import "BackForwardStack.h"

@interface BackForwardStack()

@property (strong, nonatomic) NSMutableArray *statusStackArray;//用来存储状态的数组。
@property (assign, nonatomic) NSInteger stackBackPointer;//它始终指向待回退的那个对象。
@property (assign, nonatomic) NSInteger forwardObjectsCount;//记录当前还能有多少个对象用于forward
@property (assign, nonatomic) NSInteger backObjectsCount;//记录当前有多少个对象用于back

@end

@implementation BackForwardStack

#pragma mark - 生命周期方法
- (instancetype)init {
    if (self = [super init]) {
        [self customInitilizer];
    }
    return self;
}

- (void)dealloc {
	NSLog(@"%@释放了",NSStringFromClass([self class]));
}
#pragma mark - 自定义方法
- (void)customInitilizer {
    self.statusStackArray = [[NSMutableArray alloc] init];
    self.stackBackPointer = -1;//因为一开始的时候没有对象所以此时指向-1.
    [self calculateCurrentStackStatus];
}

/**
 计算当前栈的状态，主要是判定栈满还是栈空
 */
- (void)calculateCurrentStackStatus {
    NSInteger objectNumber = [self.statusStackArray count];
	self.forwardObjectsCount = (objectNumber - self.stackBackPointer - 1 > 0)?(objectNumber - self.stackBackPointer - 1):0;
	self.backObjectsCount = self.stackBackPointer > 0?self.stackBackPointer:0;
}
#pragma mark - 对外接口
- (BackForwardStackModel *)backAction {
	[self calculateCurrentStackStatus];
	BackForwardStackModel *model = [[BackForwardStackModel alloc] init];
	if (self.backObjectsCount > 0) {
		self.stackBackPointer--;
		model.statusObject = self.statusStackArray[self.stackBackPointer];
	}
	model.canBack = self.backObjectsCount > 0;
	model.canForward = self.forwardObjectsCount > 0;
    [self calculateCurrentStackStatus];
    if ([_delegate respondsToSelector:@selector(currentStackStatusBackObjectsNumber:forwardObjectsNumber:)]) {
        [_delegate currentStackStatusBackObjectsNumber:self.backObjectsCount forwardObjectsNumber:self.forwardObjectsCount];
    }
    return model;
}

- (BackForwardStackModel *)forwardAction {
	[self calculateCurrentStackStatus];
    BackForwardStackModel *model = [[BackForwardStackModel alloc] init];
    if (self.forwardObjectsCount > 0) {
		self.stackBackPointer++;
        model.statusObject = self.statusStackArray[self.stackBackPointer];
    }
	model.canBack = self.backObjectsCount > 0;
	model.canForward = self.forwardObjectsCount > 0;
    [self calculateCurrentStackStatus];
    if ([_delegate respondsToSelector:@selector(currentStackStatusBackObjectsNumber:forwardObjectsNumber:)]) {
        [_delegate currentStackStatusBackObjectsNumber:self.backObjectsCount forwardObjectsNumber:self.forwardObjectsCount];
    }
    return model;
}

- (void)addStatusObject:(id)object {
	[self calculateCurrentStackStatus];
	if (self.forwardObjectsCount <= 0) {
		[self.statusStackArray addObject:object];
		self.stackBackPointer++;
	} else {
		self.stackBackPointer++;
		[self.statusStackArray setObject:object atIndexedSubscript:self.stackBackPointer];
		NSRange removingRange = NSMakeRange(self.stackBackPointer + 1, [self.statusStackArray count] - self.stackBackPointer - 1);
		[self.statusStackArray removeObjectsInRange:removingRange];
	}
    [self calculateCurrentStackStatus];
    if ([_delegate respondsToSelector:@selector(currentStackStatusBackObjectsNumber:forwardObjectsNumber:)]) {
        [_delegate currentStackStatusBackObjectsNumber:self.backObjectsCount forwardObjectsNumber:self.forwardObjectsCount];
    }
}

- (void)printCurrentStack {
    NSLog(@"当前栈中对象为:");
    for (id iterator in self.statusStackArray) {
		NSLog(@"%@",iterator);
    }
    NSLog(@"当前指针值是:%ld",(long)self.stackBackPointer);
    NSLog(@"待回退对象个数为:%ld",self.backObjectsCount);
    NSLog(@"待前进对象个数为:%ld",self.forwardObjectsCount);
}
@end
