//
//  UIView+Frame.m
//  weidongdaojiaC
//
//  Created by 嘚嘚以嘚嘚 on 2017/7/24.
//  Copyright © 2017年 嘚嘚以嘚嘚. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (CGFloat) frameMaxX {
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setFrameMaxX:(CGFloat)newMaxX {
    self.frame = CGRectMake(newMaxX - self.frame.size.width, self.frame.origin.y, self.frame.size.width,
                            self.frame.size.height);
}
- (CGFloat) frameMaxY {
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setFrameMaxY:(CGFloat)newMaxY {
    self.frame = CGRectMake(self.frame.origin.x, newMaxY - self.frame.size.height, self.frame.size.width,
                            self.frame.size.height);
}

@end
