//
//  ScreenDengViewController.m
//  shoudiantong
//
//  Created by chenxi on 2018/3/9.
//  Copyright © 2018年 com.beicheng. All rights reserved.
//

#import "ScreenDengViewController.h"

@interface ScreenDengViewController ()
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIView *toolView;
@property(nonatomic,strong)CALayer *subLayer;
@property(nonatomic,assign)CGFloat lastNess;
@end

@implementation ScreenDengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
    
    _lastNess = [[UIScreen mainScreen] brightness];
    NSLog(@"%lf",_lastNess);
    [[UIScreen mainScreen] setBrightness: 1];
    

    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [[UIScreen mainScreen] setBrightness: _lastNess];

}
- (void)createUI{
    
    _toolView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth - 50, ScreenHeight - 50, 30, 30)];
//                 CGRectMake(60, ScreenHeight - kAUTOWIDTH(60), ScreenWidth - kAUTOWIDTH(70), kAUTOHEIGHT(44))];
//    [self.view addSubview:_toolView];
    _toolView.backgroundColor = [UIColor redColor];
    _toolView.layer.cornerRadius = kAUTOHEIGHT(22);
    //        iconImage.layer.borderWidth = 0.5f;
    //        iconImage.layer.borderColor = [UIColor grayColor].CGColor;
    _toolView.layer.masksToBounds = YES;
    self.subLayer=[CALayer layer];
    CGRect fixframe=_toolView.layer.frame;
    _subLayer.frame = fixframe;
    _subLayer.cornerRadius = kAUTOHEIGHT(22);
    _subLayer.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    _subLayer.masksToBounds=NO;
    _subLayer.shadowColor=[UIColor grayColor].CGColor;
    _subLayer.shadowOffset=CGSizeMake(0,5);
    _subLayer.shadowOpacity=0.5f;
    _subLayer.shadowRadius= 4;
//    [self.view.layer insertSublayer:_subLayer below:_toolView.layer];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(ScreenWidth - 50, ScreenHeight - 50, 30, 30);
    if (PNCisIPHONEX) {
        self.addBtn.frame = CGRectMake(ScreenWidth - 50, ScreenHeight - 70, 30, 30);
    }
    [self.addBtn setImage:[UIImage imageNamed:@"翻转hei"] forState:UIControlStateNormal];
    [self.addBtn setImage:[UIImage imageNamed:@"翻转hei"] forState:UIControlStateSelected];
    [self.addBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];

    
    
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"sos (2).png"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"sos (2).png"] forState:UIControlStateSelected];
    [backBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:backBtn];
    
    UIButton *shanShuoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shanShuoBtn.frame = CGRectMake(50, 0, 30, 30);
    [shanShuoBtn setImage:[UIImage imageNamed:@"sos (2).png"] forState:UIControlStateNormal];
    [shanShuoBtn setImage:[UIImage imageNamed:@"sos (2).png"] forState:UIControlStateSelected];
    [shanShuoBtn addTarget:self action:@selector(pushScreenShouDianTong) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:shanShuoBtn];
    
    UIButton *caiSeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    caiSeBtn.frame = CGRectMake(100, 0, 30, 30);
    [caiSeBtn setImage:[UIImage imageNamed:@"sos (2).png"] forState:UIControlStateNormal];
    [caiSeBtn setImage:[UIImage imageNamed:@"sos (2).png"] forState:UIControlStateSelected];
    [caiSeBtn addTarget:self action:@selector(pushScreenShouDianTong) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:caiSeBtn];
    
    UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    otherBtn.frame = CGRectMake(150, 0, 30, 30);
    [otherBtn setImage:[UIImage imageNamed:@"sos (2).png"] forState:UIControlStateNormal];
    [otherBtn setImage:[UIImage imageNamed:@"sos (2).png"] forState:UIControlStateSelected];
    [otherBtn addTarget:self action:@selector(pushScreenShouDianTong) forControlEvents:UIControlEventTouchUpInside];
    [self.toolView addSubview:otherBtn];
    
    
    
}

- (void)showToolView:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIView animateWithDuration:1 animations:^{
            _toolView.frame = CGRectMake(ScreenWidth - 50, ScreenHeight - 50, 30, 30);
            self.toolView.hidden = YES;
            _subLayer.hidden = YES;
        }];
      
    }else{
        [UIView animateWithDuration:1 animations:^{
            _toolView.frame = CGRectMake(60, ScreenHeight - kAUTOWIDTH(60), ScreenWidth - kAUTOWIDTH(70), kAUTOHEIGHT(44));
            self.toolView.hidden = NO;
            _subLayer.hidden = NO;

        }];
        

     
    }
}
- (void)backTo{
    __weak typeof (self) vc = self;
    [vc.navigationController.view.layer addAnimation:[self createTransitionAnimation] forKey:nil];
//    ScreenDengViewController *svc = [[ScreenDengViewController alloc]init];
    [self.navigationController popViewControllerAnimated:YES];
}

-(CATransition *)createTransitionAnimation
{
    //切换之前添加动画效果
    //后面知识: Core Animation 核心动画
    //不要写成: CATransaction
    //创建CATransition动画对象
    CATransition *animation = [CATransition animation];
    //设置动画的类型:
    animation.type = @"oglFlip";
    //设置动画的方向
    animation.subtype = kCATransitionFromRight;
    //设置动画的持续时间
    animation.duration = 1.5;
    //设置动画速率(可变的)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画添加到切换的过程中
    return animation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
