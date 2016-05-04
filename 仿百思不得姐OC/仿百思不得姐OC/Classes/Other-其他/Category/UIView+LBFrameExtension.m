//
//  UIView+LBFrameExtension.m
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "UIView+LBFrameExtension.h"

@implementation UIView (LBFrameExtension)

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
@end
