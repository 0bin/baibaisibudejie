//
//  UIView+LBFrameExtension.m
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "UIView+LBFrameExtension.h"

@implementation UIView (LBFrameExtension)

+ (instancetype)initWithFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


- (BOOL)isShowingOnKeyWindow
{
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    CGRect newFrame = [keywindow convertRect:self.frame fromView:self.superview];
    CGRect keywindowBounds = keywindow.bounds;
    BOOL RectCompare = CGRectIntersectsRect(newFrame, keywindowBounds);
    BOOL isShowOnKeyWindow = !self.isHidden && self.alpha > 0.01 && self.window == keywindow && RectCompare;
    
    return isShowOnKeyWindow;

}

- (CGFloat)width {

    return self.frame.size.width;
}

- (CGFloat)height {
    
    return self.frame.size.height;
}

- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (CGFloat)y {
    
     return self.frame.origin.y;
}

- (CGSize)size {
    
    return self.frame.size;
}

- (CGFloat)centerX {
    
    return self.center.x;
}

- (CGFloat)centerY {

    return self.center.y;
}

- (void)setWidth:(CGFloat)width {

    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;

}

- (void)setHeight:(CGFloat)height {

    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;

}

- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;

}

- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
    
}

- (void)setSize:(CGSize)size {
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;

}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;

}

- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
    
}
@end
