//
//  BSPlaceholderTextView.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/11.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSPlaceholderTextView.h"

@implementation BSPlaceholderTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChange
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    if (self.hasText) {
        return;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = self.font;
    attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    [self.placeholder drawInRect:CGRectMake(4, 7, self.bounds.size.width - 8, self.bounds.size.height) withAttributes:attributes];
}

/**
 *
 */
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];

}
/**
 *  重写父类方法
 */
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];

}
@end
