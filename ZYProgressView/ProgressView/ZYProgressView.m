//
//  ZYProgressView.m
//  ZYProgressView
//
//  Created by Daniel on 16/5/12.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ZYProgressView.h"

@interface ZYProgressView()
@property (nonatomic, strong)UIImageView *backImgView;
@property (nonatomic, strong)UIImageView *tintImgView;
@property (nonatomic, strong)CAGradientLayer *gradientLayer;
@end

@implementation ZYProgressView {
    CGFloat sliderWidth;
    UIPanGestureRecognizer *swipeGes;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 设置默属性
        _backColor = [UIColor blackColor];
        _progressColors = @[(id)[UIColor colorWithRed:16/255.00 green:126/255.00 blue:214/255.00 alpha:1].CGColor,
                            (id)[UIColor colorWithRed:26/255.00 green:131/255.00 blue:112/255.00 alpha:1].CGColor];
        
        _backImage = [[UIImage imageNamed:@"backImage.jpg"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
        _tintImage = [[UIImage imageNamed:@"tintImage.jpg"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
        
        sliderWidth = frame.size.height * 0.4f;
        
        [self addSubview:self.backImgView];
        [self.backImgView addSubview:self.tintImgView];
        [self.backImgView.layer addSublayer:self.gradientLayer];
        [self addSubview:self.sliderView];
        [self.backImgView addSubview:self.progressLab];
        
        self.frame = frame;
    }
    return self;
}

// 显示百分比
- (UILabel *)progressLab {
    if (!_progressLab) {
        CGFloat width = self.frame.size.width/3;
        _progressLab = [[UILabel alloc] init];
        _progressLab.bounds = CGRectMake(0, 0, width, self.frame.size.height);
        _progressLab.center = CGPointMake(-width/2, self.frame.size.height/2);
        _progressLab.textColor = [UIColor whiteColor];
        _progressLab.font = [UIFont systemFontOfSize:self.frame.size.height * 0.6];
        _progressLab.textAlignment = NSTextAlignmentRight;
    }
    return _progressLab;
}

// 白色小点
- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [UIView new];
        _sliderView.bounds = CGRectMake(0, 0, sliderWidth, sliderWidth);
        _sliderView.center = CGPointMake(self.frame.size.height - self.frame.size.height/2, self.frame.size.height/2);
        _sliderView.backgroundColor = [UIColor whiteColor];
        _sliderView.layer.cornerRadius = sliderWidth/2;
//        _sliderView.layer.masksToBounds = YES;
        
        // 阴影
        _sliderView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _sliderView.layer.shadowOffset = CGSizeMake(0, 0);
        _sliderView.layer.shadowOpacity = 0.8;
        _sliderView.layer.shadowRadius = 1;
    }
    return _sliderView;
}

// 背景图片
- (UIImageView *)backImgView {
    if (!_backImgView) {
        
        _backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _backImgView.layer.cornerRadius = self.frame.size.height/2;
        _backImgView.layer.masksToBounds = YES;
        _backImgView.image = _backImage;
    }
    return _backImgView;
}

// 前景图片
- (UIImageView *)tintImgView {
    if (!_tintImgView) {
        
        _tintImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _tintImgView.backgroundColor = _backColor;
    }
    return _tintImgView;
}

// 渐变层
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        
        _gradientLayer = [CAGradientLayer new];
        _gradientLayer.bounds = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
        _gradientLayer.position = CGPointMake(self.frame.size.height/2, _tintImgView.bounds.size.height/2);
        _gradientLayer.cornerRadius = self.frame.size.height/2-1;
        
        _gradientLayer.masksToBounds = YES;
        _gradientLayer.locations = @[@0, @0.9];
        _gradientLayer.colors = _progressColors;
        _gradientLayer.startPoint = CGPointMake(0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1, 0.5);
    }
    return _gradientLayer;
}

// 修改进度
- (void)setProgress:(CGFloat)progress {
    
    if (progress > 1.00) {
        progress = 1.00;
    }
    
    double duration = fabs (_progress - progress)  * 1.50;
    _progress = progress;
    
    self.progressLab.text = [NSString stringWithFormat:@"%d%%", (int)(_progress *100)];
    
    if (_progressType == ProgressTypeMaskImage) {
        _tintImgView.layer.mask = _gradientLayer;
    }
    
    CGRect frame = _gradientLayer.bounds;
    CGFloat progressWidth = (self.frame.size.width - self.frame.size.height) * progress + self.frame.size.height;
    if (progressWidth < self.frame.size.height) {
        progressWidth = self.frame.size.height;
    }
    
    frame.size.width = progressWidth;
    
    // 滑动的时候不修改model layer
    [UIView animateWithDuration:duration animations:^{
        self.progressLab.alpha =_progress * 3 - 0.3;
    } completion:^(BOOL finished) {
        if (swipeGes && !swipeGes.state) {
            _sliderView.center = CGPointMake(frame.size.width - frame.size.height/2, frame.size.height/2);
        }
    }];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    animation1.duration = duration;
    animation1.fromValue = [_gradientLayer.presentationLayer valueForKeyPath:@"bounds.size.width"];
    animation1.toValue = @(progressWidth);
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation2.duration = duration;
    animation2.fromValue = [_gradientLayer.presentationLayer valueForKeyPath:@"position.x"];
    animation2.toValue = @(progressWidth/2);
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation3.duration = duration;
    animation3.fromValue = [_sliderView.layer.presentationLayer valueForKeyPath:@"position.x"];
    animation3.toValue = @(progressWidth - frame.size.height/2);
    animation3.fillMode = kCAFillModeForwards;
    animation3.removedOnCompletion = NO;
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animation4.duration = duration;
    animation4.fromValue = [_progressLab.layer.presentationLayer valueForKeyPath:@"position.x"];
    animation4.toValue = @(progressWidth-self.frame.size.height-self.frame.size.width/3/2);
    animation4.fillMode = kCAFillModeForwards;
    animation4.removedOnCompletion = NO;
    
    [_gradientLayer addAnimation:animation1 forKey:@"bounds"];
    [_gradientLayer addAnimation:animation2 forKey:@"position1"];
    [_sliderView.layer addAnimation:animation3 forKey:@"position2"];
    [_progressLab.layer addAnimation:animation4 forKey:@"position3"];
    
}

- (void)setIsSlider:(BOOL)isSlider {
    
    if (_progress) {
        NSLog(@"已设置进度后不支持修改样式!!");
        return;
    }
    
    _isSlider = isSlider;
    if (_isSlider) {
        self.clipsToBounds = NO;
        sliderWidth = self.frame.size.height * 1.2;
        self.progressLab.hidden = YES;
        self.sliderView.bounds = CGRectMake(0, 0, sliderWidth, sliderWidth);
        self.sliderView.layer.cornerRadius = sliderWidth/2;
        
        self.sliderView.userInteractionEnabled = YES;
        swipeGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        [self.sliderView addGestureRecognizer:swipeGes];
    }
}

- (void)swipe:(UISwipeGestureRecognizer *)swip {
    
    CGPoint location = [swip locationInView:self];
    
    if (location.x>self.frame.size.width) {
        location.x = self.frame.size.width;
    } else if (location.x<0) {
        location.x = 0;
    }
    
    self.sliderView.center = CGPointMake(location.x, self.frame.size.height/2);
    
    CGFloat progress = location.x/self.frame.size.width;
    self.progress = progress;
    
    if (_panGesBlock) {
        _panGesBlock(self.progress);
    }
}

// 修改样式
- (void)setProgressType:(ProgressType)progressType {
    
    if (_progress) {
        NSLog(@"已设置进度后不支持修改样式!!");
        return;
    }
    
    _progressType = progressType;
    if (_progressType == ProgressTypeMaskImage) {
        _backImgView.image = _backImage;
        _tintImgView.image = _tintImage;
        _tintImgView.layer.mask = _gradientLayer;
    } else {
        _tintImgView.image = nil;
        _tintImgView.backgroundColor = _backColor;
        _gradientLayer.colors = _progressColors;
    }
}

// 修改前景图
- (void)setTintImage:(UIImage *)tintImage {
    _tintImage = [tintImage stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    if (_progressType == ProgressTypeMaskImage) {
        _tintImgView.image = _tintImage;
    }
}

// 修改背景图
- (void)setBackImage:(UIImage *)backImage {
    _backImage = [backImage stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    if (_progressType == ProgressTypeMaskImage) {
        _backImgView.image = _backImage;
    }
}

- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    _tintImgView.backgroundColor = _backColor;
}

- (void)setProgressColors:(NSArray<UIColor *> *)progressColors {
    _progressColors = progressColors;
    _gradientLayer.colors = _progressColors;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.backImgView.frame.size.width != self.bounds.size.width) {
        self.backImgView.frame = self.bounds;
        self.tintImgView.frame = self.bounds;
        [self setProgress:_progress];
    }
}

@end
