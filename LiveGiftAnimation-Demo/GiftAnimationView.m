//
//  GiftAnimationView.m
//  LiveGiftAnimation-Demo
//
//  Created by 张建 on 2017/4/27.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import "GiftAnimationView.h"
#import "UIViewExt.h"

#define kColorRGB(r, g, b)      [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:1.f]


@interface GiftAnimationView ()

//底背景
@property (nonatomic,strong)UIView      * oneBackView;
@property (nonatomic,strong)UIView      * twoBackView;

//顶背景
@property (nonatomic,strong)UIView      * oneTopBackView;
@property (nonatomic,strong)UIView      * twoTopBackView;

//头像
@property (nonatomic,strong)UIImageView * oneIconImgView;
@property (nonatomic,strong)UIImageView * twoIconImgView;

//昵称
@property (nonatomic,strong)UILabel     * oneNameLabel;
@property (nonatomic,strong)UILabel     * twoNameLabel;

//礼物名称
@property (nonatomic,strong)UILabel     * oneTitleLabel;
@property (nonatomic,strong)UILabel     * twoTitleLabel;

//礼物类型
@property (nonatomic,strong)UIImageView * oneGiftImgView;
@property (nonatomic,strong)UIImageView * twoGiftImgView;

//礼物数量
@property (nonatomic,strong)UILabel     * oneNumLabel;
@property (nonatomic,strong)UILabel     * twoNumLabel;

//oneNum
@property (nonatomic,assign)NSInteger   oneNum;
@property (nonatomic,assign)NSInteger   oneTotalNum;

//twoNum
@property (nonatomic,assign)NSInteger   twoNum;
@property (nonatomic,assign)NSInteger   twoTotalNum;

//计时器
@property (nonatomic,strong) NSTimer * timerOne;
@property (nonatomic,strong) NSTimer * timerTwo;

//originTopBackW
@property (nonatomic,assign)CGFloat originOneTopBackW;
@property (nonatomic,assign)CGFloat originTwoTopBackW;

//是否正在使用
@property (nonatomic,assign)BOOL isUse1;
@property (nonatomic,assign)BOOL isUse2;

//model
@property (nonatomic,strong)GiftModel * showModel1;
@property (nonatomic,strong)GiftModel * showModel2;

//giftArr
@property (nonatomic,strong)NSMutableArray * giftArr;

@end
@implementation GiftAnimationView

- (NSMutableArray *)giftArr{
    
    if (_giftArr == nil) {
        
        _giftArr = [NSMutableArray array];
    }
    return _giftArr;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}
#pragma mark ---initUI---
- (void)initUI{
    
    //初始化UI
    [self setupUI];
    
    //计时器
    [self initTimer];
}
//初始化UI
- (void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    
    //===one====
    //back
    _oneBackView = [[UIView alloc] init];
    _oneBackView.backgroundColor = [UIColor clearColor];
    _oneBackView.hidden = YES;
    [self addSubview:_oneBackView];
    
    //topBack
    _oneTopBackView = [[UIView alloc] init];
    _oneTopBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _oneTopBackView.layer.cornerRadius = 20;
    _oneTopBackView.layer.masksToBounds = YES;
    [_oneBackView addSubview:_oneTopBackView];
    
    //icon
    _oneIconImgView = [[UIImageView alloc] init];
    _oneIconImgView.backgroundColor = [UIColor cyanColor];
    _oneIconImgView.layer.cornerRadius = 15;
    _oneIconImgView.layer.masksToBounds = YES;
    [_oneBackView addSubview:_oneIconImgView];
    
    //昵称
    _oneNameLabel = [[UILabel alloc] init];
    _oneNameLabel.backgroundColor = [UIColor clearColor];
    _oneNameLabel.font = [UIFont systemFontOfSize:13];
    [_oneBackView addSubview:_oneNameLabel];
    
    //礼物名
    _oneTitleLabel = [[UILabel alloc] init];
    _oneTitleLabel.backgroundColor = [UIColor clearColor];
    _oneTitleLabel.font = [UIFont systemFontOfSize:12];
    _oneTitleLabel.textColor = kColorRGB(250, 221, 127);;
    [_oneBackView addSubview:_oneTitleLabel];
    
    //礼物样式
    _oneGiftImgView = [[UIImageView alloc] init];
    _oneGiftImgView.backgroundColor = [UIColor clearColor];
    _oneGiftImgView.contentMode = UIViewContentModeScaleAspectFit;
    [_oneBackView addSubview:_oneGiftImgView];
    
    //礼物数量
    _oneNumLabel = [[UILabel alloc] init];
    _oneNumLabel.backgroundColor = [UIColor clearColor];
    _oneNumLabel.textColor = kColorRGB(250, 221, 127);
    _oneNumLabel.font = [UIFont boldSystemFontOfSize:20];
    _oneNumLabel.textAlignment = NSTextAlignmentCenter;
    [_oneBackView addSubview:_oneNumLabel];
 
    //===two====
    //back
    _twoBackView = [[UIView alloc] init];
    _twoBackView.backgroundColor = [UIColor clearColor];
    _twoBackView.hidden = YES;
    [self addSubview:_twoBackView];
    
    //topBack
    _twoTopBackView = [[UIView alloc] init];
    _twoTopBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _twoTopBackView.layer.cornerRadius = 20;
    _twoTopBackView.layer.masksToBounds = YES;
    [_twoBackView addSubview:_twoTopBackView];
    
    //icon
    _twoIconImgView = [[UIImageView alloc] init];
    _twoIconImgView.backgroundColor = [UIColor cyanColor];
    _twoIconImgView.layer.cornerRadius = 15;
    _twoIconImgView.layer.masksToBounds = YES;
    [_twoBackView addSubview:_twoIconImgView];
    
    //昵称
    _twoNameLabel = [[UILabel alloc] init];
    _twoNameLabel.backgroundColor = [UIColor clearColor];
    _twoNameLabel.font = [UIFont systemFontOfSize:13];
    [_twoBackView addSubview:_twoNameLabel];
    
    //礼物名
    _twoTitleLabel = [[UILabel alloc] init];
    _twoTitleLabel.backgroundColor = [UIColor clearColor];
    _twoTitleLabel.font = [UIFont systemFontOfSize:12];
    _twoTitleLabel.textColor = kColorRGB(250, 221, 127);;
    [_twoBackView addSubview:_twoTitleLabel];
    
    //礼物样式
    _twoGiftImgView = [[UIImageView alloc] init];
    _twoGiftImgView.backgroundColor = [UIColor clearColor];
    _twoGiftImgView.contentMode = UIViewContentModeScaleAspectFit;
    [_twoBackView addSubview:_twoGiftImgView];
    
    //礼物数量
    _twoNumLabel = [[UILabel alloc] init];
    _twoNumLabel.backgroundColor = [UIColor clearColor];
    _twoNumLabel.textColor = kColorRGB(250, 221, 127);
    _twoNumLabel.font = [UIFont boldSystemFontOfSize:20];
    _twoNumLabel.textAlignment = NSTextAlignmentCenter;
    [_twoBackView addSubview:_twoNumLabel];

}

//计时器
- (void)initTimer{
    
    _timerOne = [NSTimer timerWithTimeInterval:0.4 target:self selector:@selector(timerOne:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerOne forMode:NSRunLoopCommonModes];
    [_timerOne setFireDate:[NSDate distantFuture]];//开始
    
    _timerTwo = [NSTimer timerWithTimeInterval:0.4 target:self selector:@selector(timerTwo:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timerTwo forMode:NSRunLoopCommonModes];
    [_timerTwo setFireDate:[NSDate distantFuture]];//开始
}

#pragma mark ---发送礼物的动画---
- (void)sendGiftWithModel:(GiftModel *)model{
    
    [self.giftArr addObject:model];
    
    //如果数量大于2，并且one和two正在使用
    if (_giftArr.count > 2 && _isUse1 && _isUse2) {
        
        NSLog(@"不执行下个动画");
    }
    else {
        
        //调用动画
        [self invocationAnimationWithModel:model];
    }
}

//插入model执行动画
- (void)invocationAnimationWithModel:(GiftModel *)model{
    
    NSLog(@"count:%ld",_giftArr.count);
    
    //如果one没有动画
    if (_isUse1 == NO) {
        
        //赋值
        _showModel1 = model;
        //正在使用
        _isUse1 = YES;
        //显示
        _oneBackView.hidden = NO;
        _oneBackView.alpha = 1.0;
        
        //总数量
        _oneTotalNum = model.giftCount;
        //初始化
        _oneNum = 1;
        
        //icon
        _oneIconImgView.frame = CGRectMake(14, 20, 30, 30);
        
        //昵称
        _oneNameLabel.text = @"我是张建";
        CGFloat oneNameW = [self sizeWithString:_oneNameLabel.text size:CGSizeMake(180, 15) textFont:[UIFont systemFontOfSize:13]].width;
        _oneNameLabel.frame = CGRectMake(_oneIconImgView.right + 5, 20, oneNameW, 15);
        
        //礼物名称
        _oneTitleLabel.text = model.giftName;
        CGFloat oneTitleW = [self sizeWithString:_oneTitleLabel.text size:CGSizeMake(180, 15) textFont:[UIFont systemFontOfSize:12]].width;
        _oneTitleLabel.frame = CGRectMake(_oneIconImgView.right + 5, _oneIconImgView.bottom - 15, oneTitleW, 15);
        
        //礼物类型
        _oneGiftImgView.image = [UIImage imageNamed:model.giftPic];
        CGFloat oneGiftLeft;
        CGFloat oneWidth;
        if (oneNameW >= oneTitleW) {
            oneWidth = oneNameW;
            oneGiftLeft = _oneNameLabel.right ;
        }else{
            oneWidth = oneTitleW;
            oneGiftLeft = _oneTitleLabel.right;
        }
        _oneGiftImgView.frame = CGRectMake(oneGiftLeft, 0, 60, 65);
        
        //礼物数量
        _oneNumLabel.text = [NSString stringWithFormat:@"x%ld",_oneNum];
        CGFloat oneNumW = [self sizeWithString:[NSString stringWithFormat:@"x%ld",_oneNum] size:CGSizeMake(180, 15) textFont:[UIFont systemFontOfSize:20]].width + 20;
        CGFloat oneNumTW = [self sizeWithString:[NSString stringWithFormat:@"x%ld",_oneTotalNum] size:CGSizeMake(180, 15) textFont:[UIFont systemFontOfSize:20]].width + 20;
        _oneNumLabel.frame = CGRectMake(_oneGiftImgView.right, 15, oneNumW, 40);
        
        //阴影宽度
        _originOneTopBackW = 4 + _oneIconImgView.width + 5 + oneWidth + _oneGiftImgView.width + 5 + oneNumW + 10;
        _oneTopBackView.width = _originOneTopBackW;
        //topBack
        _oneTopBackView.frame = CGRectMake(8, 15, _oneTopBackView.width, 40);
        
        
        //back
        CGFloat oneBackW = 4 + _oneIconImgView.width + 5 + oneWidth + _oneGiftImgView.width + 5 + oneNumTW + 10 + 10;
        _oneBackView.frame = CGRectMake(- (_oneTopBackView.width + 10), 5, oneBackW, 65);
        
        
        //设置本视图的宽度
        if (_oneBackView.width > _twoBackView.width) {
            
            self.width = _oneBackView.width;
            
        }else{
            
            self.width = _twoBackView.width;
        }
        
        [UIView animateWithDuration:1 animations:^{
            
            _oneBackView.frame = CGRectMake(0, 5, _oneTopBackView.width + 10, 65);
            
        } completion:^(BOOL finished) {
            
            //暂停
            [_timerOne setFireDate:[NSDate distantPast]];
            
        }];
    }
    //two
    else {
        
        //赋值
        _showModel2 = model;
        //正在动画
        _isUse2 = YES;
        //显示
        _twoBackView.hidden = NO;
        _twoBackView.alpha = 1.0f;
        
        //总数量
        _twoTotalNum = model.giftCount;
        //初始化
        _twoNum = 1;
        
        //icon
        _twoIconImgView.frame = CGRectMake(14, 20, 30, 30);
        
        //昵称
        _twoNameLabel.text = @"我是杨乃文";
        CGFloat twoNameW = [self sizeWithString:_twoNameLabel.text size:CGSizeMake(180, 15) textFont:[UIFont systemFontOfSize:13]].width;
        _twoNameLabel.frame = CGRectMake(_twoIconImgView.right + 5, 20, twoNameW, 15);
        
        //礼物名称
        _twoTitleLabel.text = model.giftName;
        CGFloat twoTitleW = [self sizeWithString:_twoTitleLabel.text size:CGSizeMake(180, 15) textFont:[UIFont systemFontOfSize:12]].width;
        _twoTitleLabel.frame = CGRectMake(_twoIconImgView.right + 5, _twoIconImgView.bottom - 15, twoTitleW, 15);
        
        //礼物类型
        _twoGiftImgView.image = [UIImage imageNamed:model.giftPic];
        CGFloat twoGiftLeft;
        CGFloat twoWidth;
        if (twoNameW >= twoTitleW) {
            twoWidth = twoNameW;
            twoGiftLeft = _twoNameLabel.right ;
        }else{
            twoWidth = twoTitleW;
            twoGiftLeft = _twoTitleLabel.right;
        }
        _twoGiftImgView.frame = CGRectMake(twoGiftLeft, 0, 60, 65);
 
        //礼物数量
        _twoNumLabel.text = [NSString stringWithFormat:@"x%ld",_twoNum];
        CGFloat twoNumW = [self sizeWithString:[NSString stringWithFormat:@"x%ld",_twoNum] size:CGSizeMake(180, 40) textFont:[UIFont systemFontOfSize:20]].width + 20;
        CGFloat twoNumTW = [self sizeWithString:[NSString stringWithFormat:@"x%ld",_twoTotalNum] size:CGSizeMake(180, 40) textFont:[UIFont systemFontOfSize:20]].width + 20;
        _twoNumLabel.frame = CGRectMake(_twoGiftImgView.right, 15, twoNumW, 40);
        
        //阴影宽度back
        _originTwoTopBackW = 4 + _twoIconImgView.width + 5 + twoWidth + _twoGiftImgView.width + 5 + twoNumW + 10;
        _twoTopBackView.width = _originTwoTopBackW;
        //topback
        _twoTopBackView.frame = CGRectMake(8, 15, _twoTopBackView.width, 40);
        
        //back
        CGFloat twoBackW = 4 + _twoIconImgView.width + 5 + twoWidth + _twoGiftImgView.width + 5 + twoNumTW + 10 + 10;
        _twoBackView.frame = CGRectMake(- (_twoTopBackView.width + 10), _oneBackView.bottom + 10, twoBackW, 65);
        
        //设置本视图的宽度
        if (_oneBackView.width > _twoBackView.width) {
            
            self.width = _oneBackView.width;
            
        }else{
            
            self.width = _twoBackView.width;
        }

        [UIView animateWithDuration:1 animations:^{
            
            _twoBackView.frame = CGRectMake(0, _oneBackView.bottom + 10, _twoTopBackView.width + 10, 65);
            
        } completion:^(BOOL finished) {
            
            //第二个结束开始计时
            [_timerTwo setFireDate:[NSDate distantPast]];
        }];

    }
    
}
//timerOne
- (void)timerOne:(NSTimer *)timerOne{
    
    NSLock * lock = [[NSLock alloc] init];
    
    [lock lock];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _oneNumLabel.text = [NSString stringWithFormat:@"x%ld",_oneNum];
        [_oneNumLabel setTransform:CGAffineTransformMakeScale(1.5, 1.5)];
        
    } completion:^(BOOL finished) {
        
        [_oneNumLabel setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        CGFloat oneNumW = [self sizeWithString:[NSString stringWithFormat:@"x%d",1] size:CGSizeMake(180, 40) textFont:[UIFont systemFontOfSize:20]].width + 20;
        CGFloat oneNewNumW = [self sizeWithString:[NSString stringWithFormat:@"x%ld",_oneNum] size:CGSizeMake(180, 40) textFont:[UIFont systemFontOfSize:20]].width + 20;
        _oneNumLabel.frame = CGRectMake(_oneGiftImgView.right, 15, oneNewNumW, 40);
        _oneTopBackView.width = _originOneTopBackW + oneNewNumW - oneNumW;
        _oneBackView.width = _oneTopBackView.width + 10;
        //设置本视图的宽度
        if (_oneBackView.width > _twoBackView.width) {
            
            self.width = _oneBackView.width;
            
        }else{
            
            self.width = _twoBackView.width;
        }

        
    }];
    
    if (_oneNum >= _oneTotalNum) {
        
        //暂停计时器
        [_timerOne setFireDate:[NSDate distantFuture]];
        
        [UIView animateWithDuration:1 animations:^{
            
            _oneBackView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            _oneBackView.frame = CGRectMake(-(_oneTopBackView.width + 10), 5, _twoTopBackView.width + 10, 65);
            _oneBackView.hidden = YES;
            //one没有被用
            _isUse1 = NO;
            
            //从数组移除
            [_giftArr removeObject:_showModel1];
            
            if (_giftArr.count > 0) {
                
                for (GiftModel * model in _giftArr) {
                    
                    if (model != _showModel2) {
                        
                        //调用动画
                        [self invocationAnimationWithModel:model];
                        //跳出循环
                        break;
                    }
                }
            }
        }];
    }
    
    _oneNum ++;
    
    [lock unlock];
}


//timerTwo
- (void)timerTwo:(NSTimer *)timerTwo{

    NSLock * lock = [[NSLock alloc] init];
    
    [lock lock];

    [UIView animateWithDuration:0.4 animations:^{
        
        _twoNumLabel.text = [NSString stringWithFormat:@"x%ld",_twoNum];
        [_twoNumLabel setTransform:CGAffineTransformMakeScale(1.5, 1.5)];
        
    } completion:^(BOOL finished) {
        
        [_twoNumLabel setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        CGFloat twoNumW = [self sizeWithString:[NSString stringWithFormat:@"x%d",1] size:CGSizeMake(180, 40) textFont:[UIFont systemFontOfSize:20]].width + 20;
        CGFloat twoNewNumW = [self sizeWithString:[NSString stringWithFormat:@"x%ld",_twoNum] size:CGSizeMake(180, 40) textFont:[UIFont systemFontOfSize:20]].width + 20;
        _twoNumLabel.frame = CGRectMake(_twoGiftImgView.right, 15, twoNewNumW, 40);
        _twoTopBackView.width = _originTwoTopBackW + twoNewNumW - twoNumW;
        _twoBackView.width = _twoTopBackView.width + 10;
        //设置本视图的宽度
        if (_oneBackView.width > _twoBackView.width) {
            
            self.width = _oneBackView.width;
            
        }else{
            
            self.width = _twoBackView.width;
        }

    }];
    
    if (_twoNum >= _twoTotalNum) {
        
        //暂停计时器
        [_timerTwo setFireDate:[NSDate distantFuture]];
        
        [UIView animateWithDuration:1 animations:^{
            
            _twoBackView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            _twoBackView.frame = CGRectMake(- (_twoTopBackView.width + 10), _oneBackView.bottom + 10, _twoTopBackView.width + 10, 65);
            _twoBackView.hidden = YES;
            
            //two可用
            _isUse2 = NO;
            
            //数组移除
            [_giftArr removeObject:_showModel2];
            
            if (_giftArr.count > 0) {
                
                for (GiftModel * model in _giftArr) {
                    
                    if (model != _showModel1) {
                        
                        //开始动画
                        [self invocationAnimationWithModel:model];
                        break;
                    }
                }
            }
            
        }];
    }
    
    _twoNum ++;
    
    [lock unlock];
}

//设置文本自适应宽和高度
- (CGSize)sizeWithString:(NSString *)string size:(CGSize)size textFont:(UIFont *)textFont
{
    if (![string isKindOfClass:[NSString class]]) {
        
        return CGSizeMake(0, 0);
    }
    
    CGSize result = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size;
    
    CGSize resultSize = CGSizeMake(result.width + 1, result.height + 1);
    
    return resultSize;
}


- (void)dealloc{
    
    [_timerOne invalidate];
    [_timerTwo invalidate];
    
    self.hidden = YES;
}
@end
