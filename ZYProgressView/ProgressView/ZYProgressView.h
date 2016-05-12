//
//  ZYProgressView.h
//  ZYProgressView
//
//  Created by Daniel on 16/5/12.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYProgressView : UIView

@property (nonatomic, strong)UILabel *left;
@property (nonatomic, strong)UILabel *right;

@property (nonatomic, strong)UIImage *tintImage;
@property (nonatomic, strong)UIImage *backImage;

@property (nonatomic, assign)CGFloat progress;

@end
