//
//  BJLPreviewCell.m
//  BJLiveUI
//
//  Created by MingLQ on 2017-06-05.
//  Copyright © 2017 BaijiaYun. All rights reserved.
//

#import "BJLPreviewCell.h"

#import "BJLViewImports.h"

NS_ASSUME_NONNULL_BEGIN

static const CGFloat heightM = 75.0, heightL = 100.0;

NSString
* const BJLPreviewCellID_view = @"view",
* const BJLPreviewCellID_view_label = @"view+label",
* const BJLPreviewCellID_avatar_label = @"avatar+label",
* const BJLPreviewCellID_avatar_label_buttons = @"avatar+label+buttons";

@interface BJLPreviewCell ()

@property (nonatomic, nullable) UIView *customView;
@property (nonatomic, readonly, nullable) UIView *customCoverView;

@property (nonatomic, readonly, nullable) UIImageView *avatarView;
@property (nonatomic, readonly, nullable) UIImageView *cameraView;
@property (nonatomic, readonly, nullable) UIImageView *nameShadowView;
@property (nonatomic, readonly, nullable) UIButton *nameView;
@property (nonatomic, readonly, nullable) UIButton *likeButton;

@property (nonatomic, readonly, nullable) UIView *actionGroupView;
@property (nonatomic, readonly, nullable) UILabel *messageLabel;
@property (nonatomic, readonly, nullable) UIButton *disallowButton, *allowButton;

@property (nonatomic, readonly, nullable) UIView *videoLoadingView;
@property (nonatomic, readonly, nullable) UIImageView *videoLoadingImageView;

@end

@implementation BJLPreviewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // self.contentView.backgroundColor = [UIColor bjl_grayImagePlaceholderColor];
        self.contentView.clipsToBounds = YES;
        
        bjl_weakify(self);
        [self bjl_kvo:BJLMakeProperty(self, reuseIdentifier)
               filter:^BOOL(id _Nullable old, id _Nullable now) {
                   // bjl_strongify(self);
                   return !!now;
               }
             observer:^BOOL(id _Nullable old, id _Nullable now) {
                 bjl_strongify(self);
                 [self makeSubviews];
                 [self makeConstraints];
                 [self prepareForReuse];
                 return NO;
             }];
    }
    return self;
}

- (void)makeSubviews {
    if ([self.reuseIdentifier isEqualToString:BJLPreviewCellID_view]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self->_customCoverView = ({
            UIView *view = [UIView new];
            [self.contentView addSubview:view];
            view;
        });
    }
    
    if ([self.reuseIdentifier isEqualToString:BJLPreviewCellID_view_label]) {
        self->_customCoverView = ({
            UIView *view = [UIView new];
            [self.contentView addSubview:view];
            view;
        });
        
        self->_videoLoadingView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor bjl_colorWithHexString:@"4A4A4A"];
            view.hidden = YES;
            [self.contentView addSubview:view];
            view;
        });
        
        self->_videoLoadingImageView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage bjl_imageNamed:@"bjl_ic_user_loading"]];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self.videoLoadingView addSubview:imageView];
            imageView;
        });
    }
    
    if ([self.reuseIdentifier isEqualToString:BJLPreviewCellID_avatar_label]
        || [self.reuseIdentifier isEqualToString:BJLPreviewCellID_avatar_label_buttons]) {
        self->_avatarView = ({
            UIImageView *imageView = [UIImageView new];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self.contentView addSubview:imageView];
            imageView;
        });
    }
    
    if ([self.reuseIdentifier isEqualToString:BJLPreviewCellID_avatar_label]) {
        self->_cameraView = ({
            UIImageView *imageView = [UIImageView new];
            imageView.image = [UIImage bjl_imageNamed:@"bjl_ic_video_on"];
            [self.contentView addSubview:imageView];
            imageView;
        });
    }
    
    if ([self.reuseIdentifier isEqualToString:BJLPreviewCellID_view_label]
        || [self.reuseIdentifier isEqualToString:BJLPreviewCellID_avatar_label]) {
        self->_nameShadowView = ({
            UIImageView *imageView = [UIImageView new];
            imageView.image = [UIImage bjl_imageNamed:@"bjl_bg_name"];
            [self.contentView addSubview:imageView];
            imageView;
        });
        
        self->_nameView = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            button.titleLabel.textAlignment = NSTextAlignmentLeft;
            button.titleLabel.font = [UIFont systemFontOfSize:12.0];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.contentView addSubview:button];
            button;
        });
        
        self->_likeButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont systemFontOfSize:10.0];
            button.layer.cornerRadius = 6.0;
            button.layer.masksToBounds = YES;
            button.contentEdgeInsets = UIEdgeInsetsMake(0.0, 4.0, 0.0, 4.0);
            [button setTitle:@"0" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage bjl_imageWithColor:[UIColor bjl_dimColor]] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor bjl_colorWithHexString:@"#F7E123"] forState:UIControlStateNormal];
            [button setImage:[UIImage bjl_imageNamed:@"bjl_like_icon"] forState:UIControlStateNormal];
            [self.contentView addSubview:button];
            button;
        });
    }
    
    if ([self.reuseIdentifier isEqualToString:BJLPreviewCellID_avatar_label_buttons]) {
        self->_actionGroupView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor bjl_darkDimColor];
            [self.contentView addSubview:view];
            view;
        });
        
        self->_messageLabel = ({
            UILabel *label = [UILabel new];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12.0];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 2;
            label.lineBreakMode = NSLineBreakByTruncatingMiddle;
            [self.actionGroupView addSubview:label];
            label;
        });
        
        self->_disallowButton = ({
            UIButton *button = [UIButton new];
            [button setTitle:@"拒绝" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [self.actionGroupView addSubview:button];
            button;
        });
        
        self->_allowButton = ({
            UIButton *button = [UIButton new];
            [button setTitle:@"同意" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor bjl_blueBrandColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [self.actionGroupView addSubview:button];
            button;
        });
        
        bjl_weakify(self);
        [self.disallowButton bjl_addHandler:^(__kindof UIControl * _Nullable sender) {
            bjl_strongify(self);
            if (self.actionCallback) self.actionCallback(self, NO);
        } forControlEvents:UIControlEventTouchUpInside];
        [self.allowButton bjl_addHandler:^(__kindof UIControl * _Nullable sender) {
            bjl_strongify(self);
            if (self.actionCallback) self.actionCallback(self, YES);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    bjl_weakify(self);
    [self.contentView addGestureRecognizer:({
        UITapGestureRecognizer *tap = [UITapGestureRecognizer bjl_gestureWithHandler:^(__kindof UIGestureRecognizer * _Nullable gesture) {
            bjl_strongify(self);
            if (self.doubleTapsCallback) self.doubleTapsCallback(self);
        }];
        tap.numberOfTapsRequired = 2;
        tap.numberOfTouchesRequired = 1;
        tap.delaysTouchesBegan = YES;
        tap;
    })];
}

- (void)makeConstraints {
    if (self.customCoverView) {
        [self.customCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    
    if (self.avatarView) {
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    
    if (self.cameraView) {
        [self.cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView);
        }];
    }
    
    if (self.nameShadowView && self.nameView) {
        [self.nameShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@16.0);
        }];
        
        [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameShadowView).offset(1.0);
            make.left.equalTo(self.nameShadowView).offset(3.0);
            make.bottom.equalTo(self.nameShadowView).offset(-4.0);
        }];
    }
    
    if (self.likeButton && self.nameView) {
        [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(4.0);
            make.bottom.equalTo(self.nameView.mas_top).offset(-3.0);
            make.height.equalTo(@(12.0));
        }];
    }
    
    if (self.actionGroupView) {
        [self.actionGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.actionGroupView).with.inset(BJLViewSpaceS);
            // label 底边到 actionGroupView 底边的距离是 actionGroupView 高度的 1/2
            make.bottom.equalTo(self.actionGroupView).multipliedBy(1.0 / 2);
        }];
        [self.disallowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.actionGroupView).with.inset(BJLViewSpaceL);
            make.bottom.equalTo(self.actionGroupView).with.inset(BJLViewSpaceS);
        }];
        [self.allowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.actionGroupView).with.inset(BJLViewSpaceL);
            make.bottom.equalTo(self.actionGroupView).with.inset(BJLViewSpaceS);
        }];
    }
    
    if (self.videoLoadingView) {
        [self.videoLoadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    
    if (self.videoLoadingImageView) {
        [self.videoLoadingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@40.0);
            make.center.equalTo(self.videoLoadingView);
        }];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    if (self.customView.superview == self.contentView) {
        [self.customView removeFromSuperview];
    }
    self.customView = nil;
    
    // [self.avatarView sd_setImageWithURL:nil]; // cancel image loading
    [self.avatarView bjl_cancelCurrentImageLoading];
    self.avatarView.image = nil;
    
    [self.nameView setTitle:nil forState:UIControlStateNormal];
    // self.nameView.selected = NO;
    self.cameraView.hidden = YES;
    
    self.messageLabel.text = nil;
    self.videoLoadingView.hidden = YES;
}

// 显示ppt视图
- (void)updateWithView:(UIView *)view {
    self.customView = view;
    if (view) {
        [self.contentView insertSubview:view atIndex:0];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
}

// 正在加载视频用户视图
- (void)updateLoadingViewHidden:(BOOL)hidden {
    if (!self.videoLoadingView) {
        return;
    }
    if (self.videoLoadingView.hidden == hidden) {
        return;
    }
    self.videoLoadingView.hidden = hidden;
    if (!self.videoLoadingView.hidden && !self.videoLoadingImageView.isAnimating) {
        // 显示旋转动画
        [self.videoLoadingView.layer removeAllAnimations];
        [self.videoLoadingImageView.layer removeAllAnimations];
        [self startAnimation:0];
    }
}

- (void)startAnimation:(CGFloat)angle {
    __block float nextAngle = angle + 10;
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.videoLoadingImageView.transform = endAngle;
    } completion:^(BOOL finished) {
        if (!self.videoLoadingView.hidden && finished) {
            [self startAnimation:nextAngle];
        }
    }];
}

// 视频用户显示视频
- (void)updateWithView:(UIView *)view title:(NSString *)title {
    [self updateWithView:view];
    [self.nameView setTitle:title forState:UIControlStateNormal];
}

// 音频用户显示视频头像
- (void)updateWithImageURLString:(NSString *)imageURLString title:(NSString *)title hasVideo:(BOOL)hasVideo {
    [self.avatarView bjl_setImageWithURL:[NSURL URLWithString:imageURLString]
                             placeholder:[UIImage bjl_imageWithColor:[UIColor bjl_grayImagePlaceholderColor]]
                              completion:nil];
    if (self.nameView) {
        [self.nameView setTitle:title forState:UIControlStateNormal];
        // self.nameView.selected = hasVideo;
        self.cameraView.hidden = !hasVideo;
    }
    else {
        self.messageLabel.text = title;
    }
}

// 音视频用户更新点赞数, 学生点赞数为0时不显示, 能给别人点赞的人一直显示, 助教和老师自己不显示
- (void)updateWithLikeCount:(NSInteger)count hidden:(BOOL)hidden {
    self.likeButton.hidden = hidden;
    [self.likeButton setTitle:[NSString stringWithFormat:@"%ld", (long)count] forState:UIControlStateNormal];
}

+ (CGSize)cellSize {
    static BOOL iPad = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    
    CGFloat height = iPad ? heightL : heightM;
    return CGSizeMake(height * 4 / 3, height);
}

+ (NSArray<NSString *> *)allCellIdentifiers {
    return @[BJLPreviewCellID_view,
             BJLPreviewCellID_view_label,
             BJLPreviewCellID_avatar_label,
             BJLPreviewCellID_avatar_label_buttons];
}

@end

NS_ASSUME_NONNULL_END
