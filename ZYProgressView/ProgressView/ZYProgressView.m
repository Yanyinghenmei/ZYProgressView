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
@property (nonatomic, strong)UIView *maskView;
@end

@implementation ZYProgressView {
    CGFloat progressWidth;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _left = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_left];
        _left.text = @"0%";
        
        _right = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_right];
        _right.text = @"100%";
        
        CGSize size1 = [_left sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGSize size2 = [_right sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        
        _left.frame = CGRectMake(0, 0, size1.width, size1.height);
        _right.frame = CGRectMake(frame.size.width-size2.width, 0, size2.width, size2.height);
        
        
        
        _backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_left.frame)+10, _left.frame.size.height * 0.3, frame.size.width-20-size1.width-size2.width, _left.frame.size.height * 0.4)];
        [self addSubview:_backImgView];
        _backImgView.layer.cornerRadius = _backImgView.frame.size.height/2;
        _backImgView.layer.masksToBounds = YES;
        _backImage = [[UIImage imageNamed:@"backImage.jpg"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
        _backImgView.image = _backImage;
        _backImgView.backgroundColor = [UIColor lightGrayColor];
        
        
        
        _tintImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _backImgView.frame.size.width, _backImgView.frame.size.height)];
        [_backImgView addSubview:_tintImgView];
        _tintImage = [[UIImage imageNamed:@"tintImage.jpg"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
        _tintImgView.image = _tintImage;
        _tintImgView.backgroundColor = [UIColor orangeColor];
        
        
        
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, _backImgView.frame.size.height)];
        [self addSubview:_maskView];
        _maskView.backgroundColor = [UIColor blackColor];
        _tintImgView.maskView = _maskView;
        
        progressWidth = _backImgView.frame.size.width;
        frame.size.height = _left.frame.size.height;
        self.frame = frame;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    CGRect frame = _maskView.frame;
    frame.size.width = progressWidth * progress;
    
    [UIView animateWithDuration:2*progress animations:^{
        _maskView.frame = frame;
    }];
}

- (void)setTintImage:(UIImage *)tintImage {
    _tintImage = [tintImage stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    _tintImgView.image = _tintImage;
}

- (void)setBackImage:(UIImage *)backImage {
    _backImage = [backImage stretchableImageWithLeftCapWidth:0.5 topCapHeight:0.5];
    _backImgView.image = _backImage;
}

@end
