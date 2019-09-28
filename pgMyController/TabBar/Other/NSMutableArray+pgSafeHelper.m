//
//  NSMutableArray+pgSafeHelper.m
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import "NSMutableArray+pgSafeHelper.h"

@implementation NSMutableArray (pgSafeHelper)

- (void)safe_setObject:(id)object AtIndex:(NSInteger)index
{
    if (index>=self.count) {
        return;
    }
    [self setObject:object atIndexedSubscript:index];
}

@end
