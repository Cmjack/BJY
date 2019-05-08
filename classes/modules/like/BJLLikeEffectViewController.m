//
//  BJLLikeEffectViewController.m
//  BJLiveUI
//
//  Created by xijia dai on 2018/10/22.
//  Copyright © 2018年 BaijiaYun. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <BJLiveBase/NSObject+BJLObserving.h>
#import <BJLiveBase/BJL_EXTScope.h>

#import "BJLLikeEffectViewController.h"
#import "BJLAppearance.h"

@interface BJLLikeEffectViewController ()

@property (nonatomic) NSString *name;
@property (nonatomic) NSMutableArray<UIImage *> *starImages;
@property (nonatomic) UIView *scaleView;
@property (nonatomic) UIImageView *awardBackgroundImageView;
@property (nonatomic) UIImageView *awardImageView;
@property (nonatomic) UIImageView *starImageView;
@property (nonatomic) UILabel *nameLabel;

@end

@implementation BJLLikeEffectViewController

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
        self.starImages = [NSMutableArray new];
        for (NSInteger i = 1; i <= 20; i ++) {
            UIImage *image = [UIImage bjl_imageNamed:[NSString stringWithFormat:@"bjl_like_star%ld", (long)i]];
            [self.starImages addObject:image];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeSubviewsAndConstraints];
    // start animate
    [self startScaleAnimation:YES];
    [self startShineAnimation:0];
    [self.starImageView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startScaleAnimation:NO];
    });
}

- (void)makeSubviewsAndConstraints {
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    
    self.scaleView = [UIView new];
    [self.view addSubview:self.scaleView];
    [self.scaleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.awardBackgroundImageView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage bjl_imageNamed:@"bjl_like_shine"];
        imageView;
    });
    [self.scaleView addSubview:self.awardBackgroundImageView];
    [self.awardBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.equalTo(self.awardBackgroundImageView.mas_width);
    }];
    
    self.starImageView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.animationImages = self.starImages;
        imageView;
    });
    [self.scaleView addSubview:self.starImageView];
    [self.starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.awardBackgroundImageView);
    }];
    
    self.awardImageView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage bjl_imageNamed:@"bjl_like_award"];
        imageView;
    });
    [self.scaleView addSubview:self.awardImageView];
    [self.awardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.starImageView);
    }];
    
    self.nameLabel = ({
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16.0];
        label.textColor = [UIColor whiteColor];
        label.text = self.name;
        label;
    });
    [self.awardImageView addSubview:self.nameLabel];
    bjl_weakify(self);
    [self bjl_kvo:BJLMakeProperty(self.awardImageView, bounds)
         observer:^BOOL(id  _Nullable old, id  _Nullable now) {
             bjl_strongify(self);
             if (self.awardImageView.bounds.size.height) {
                 CGFloat bottomOffset = self.awardImageView.bounds.size.height * 0.3;
                 CGFloat height = self.awardImageView.bounds.size.height * (13.0 /180.0);
                 [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                     make.centerX.equalTo(self.awardImageView);
                     make.width.lessThanOrEqualTo(self.awardImageView.mas_width).multipliedBy(0.4);
                     make.bottom.equalTo(self.awardImageView).offset(-bottomOffset);
                     make.height.greaterThanOrEqualTo(@(height));
                 }];
             }
             return YES;
         }];
}

- (void)startShineAnimation:(CGFloat)angle {
    __block float nextAngle = angle + 10;
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.28 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.awardBackgroundImageView.transform = endAngle;
    } completion:^(BOOL finished) {
        [self startShineAnimation:nextAngle];
    }];
}

- (void)startScaleAnimation:(BOOL)zoom {
    if (zoom) {
        self.scaleView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        CGAffineTransform zoom = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.scaleView.transform = zoom;
        } completion:nil];
    }
    else {
        CGAffineTransform zoomOut = CGAffineTransformMakeScale(0.5, 0.5);
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.scaleView.transform = zoomOut;
        } completion:^(BOOL finished) {
            [self bjl_removeFromParentViewControllerAndSuperiew];
        }];
    }
}

@end
