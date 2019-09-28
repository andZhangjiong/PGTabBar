//
//  NSMutableArray+pgSafeHelper.h
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (pgSafeHelper)

- (void)safe_setObject:(id)object AtIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
