//
//  BBBImageModel.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/21.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBBImageModel : NSObject

@property (nonatomic, assign) CGFloat small_width;
@property (nonatomic, assign) CGFloat small_height;
@property (nonatomic, copy) NSString *small_url;
@property (nonatomic, copy) NSString *title;

@property (nonatomic , copy) NSString *image_url;
@property (nonatomic , assign) CGFloat image_width;
@property (nonatomic , assign) CGFloat image_height;

@end
