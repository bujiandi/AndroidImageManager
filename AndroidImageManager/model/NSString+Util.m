//
//  NSString+Util.m
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import "NSString+Util.h"


@implementation NSString (Util)

- (NSString *)stringByDeletingPathPrefix {
    return [self componentsSeparatedByString:@"/"].lastObject;
}

@end