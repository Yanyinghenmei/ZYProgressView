//
//  ZYProgressView.h
//  ZYProgressView
//
//  Created by Daniel on 16/5/12.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ProgressType) {
    ProgressTypeGradient = 0,       // 使用渐变颜色 default
    ProgressTypeMaskImage = 1,      // 使用图片作为进度条的样式
};

@interface ZYProgressView : UIView

@property (nonatomic, strong)UILabel *progressLab;

// round point
@property (nonatomic, strong)UIView *sliderView;

// when '_progressType == ProgressTypeMaskImage'
@property (nonatomic, strong)UIImage *tintImage;
@property (nonatomic, strong)UIImage *backImage;

// when '_progressType == ProgressTypeGradient'
@property (nonatomic, strong)NSArray<UIColor *> *progressColors;
@property (nonatomic, strong)UIColor *backColor;

@property (nonatomic, assign)CGFloat progress;

@property (nonatomic, assign)ProgressType progressType;


@property (nonatomic, assign)BOOL isSlider;
// when thouch slider, call this block
@property (nonatomic, copy) void(^panGesBlock)(CGFloat progress);

@end
