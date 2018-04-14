//
//  backForwardStackModel.m
//  前进回退
//
//  Created by iOS开发者 on 2018/4/13.
//  Copyright © 2018年 iOS开发者. All rights reserved.
//

#import "BackForwardStackModel.h"

@implementation BackForwardStackModel

- (instancetype)init {
    if (self = [super init]) {
        [self customInitilizer];
    }
    return self;
}

- (void)customInitilizer {
    _canBack = YES;
    _canForward = YES;
    _statusObject = nil;
}
@end
