//
//  ViewController.m
//  LiveGiftAnimation-Demo
//
//  Created by 张建 on 2017/4/27.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import "ViewController.h"
#import "GiftModel.h"
#import "GiftAnimationView.h"

#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

//发送按钮
@property (nonatomic,strong)UIButton * sendBtn;
//礼物视图
@property (nonatomic,strong)GiftAnimationView * giftView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化UI
    [self initUI];
    
}

//初始化UI
- (void)initUI{
    
    //send
    _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendBtn.backgroundColor = [UIColor redColor];
    _sendBtn.frame = CGRectMake((kScreenW - 100) /2.0, kScreenH - 60,100, 40);
    [_sendBtn setTitle:@"send" forState:UIControlStateNormal];
    [_sendBtn addTarget:self action:@selector(sendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendBtn];
    
    //giftView
    _giftView = [[GiftAnimationView alloc] initWithFrame:CGRectMake(0, 100, kScreenW - 50, 150)];
    [self.view addSubview:_giftView];
}

//点击了发送按钮
- (void)sendButton:(UIButton *)send{
    
    NSArray * nameArr = @[@"鲜花",@"鸡腿",@"冰淇淋",@"逢考必过",@"蛋糕"];
    NSInteger index = arc4random()%5;
    
    GiftModel * model = [[GiftModel alloc] init];
    model.giftName = nameArr[index];
    model.giftPic = [NSString stringWithFormat:@"gift%ld",(long)index];
    model.giftCount = arc4random()%200;
    
    [_giftView sendGiftWithModel:model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
