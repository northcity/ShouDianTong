//
//  LoadingViewController.m
//  shoudiantong
//
//  Created by 北城 on 2018/3/6.
//  Copyright © 2018年 com.beicheng. All rights reserved.
//

//手电筒主控制器

#import "LoadingViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SettingViewController.h"
#import "ScreenDengViewController.h"
@interface LoadingViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>
//@property (nonatomic, strong) AVCaptureDevice *device;
//@property(nonatomic,strong) AVCaptureSession *session;

@property (nonatomic,assign) BOOL lightOn;
@property (nonatomic,assign) BOOL lockOn;

@property(nonatomic,strong)UIImageView *blackImageView;
@property(nonatomic,strong)UIImageView *dengGuangImageView;
@property(nonatomic,strong)UIButton *progressBtn;
@property(nonatomic,strong)UIButton *aboutBtn;

@property(nonatomic,strong)UIButton *shouDianTongBtn;
@property(nonatomic,strong)UIButton *shanShuoBtn;
@property(nonatomic,strong)UIButton *sosBtn;
@property(nonatomic,strong)UIButton *pushBtn;
@property(nonatomic,strong)UIButton *lockBtn;
@property(nonatomic,strong)UIVisualEffectView *effectView;
@property(nonatomic,strong)UIBlurEffect *effect;
@property(nonatomic,strong) UIView *maskView;

@property(nonatomic,strong)UIView *shouDianTongBtnView;
@property(nonatomic,strong)UIView *shanShuoBtnView;
@property(nonatomic,strong)UIView *sosBtnView;
@property(nonatomic,strong)UIView *pushBtnView;



@property(nonatomic,strong)UIImageView *beiJingDengView;
@property(nonatomic,strong)UIView  *lineView;
@property(nonatomic,strong)UIProgressView *progress;
@property(nonatomic,strong)UISlider *slider;
@property(nonatomic,strong)UIView *tanChuKuangView;

@property(nonatomic,strong)UILabel *shouDianTongLabel;

@property (strong,nonatomic) NSArray *numbers;


@property (strong,nonatomic) NSTimer *uiTimer;

@property (nonatomic,strong) AVCaptureSession * captureSession;
@property (nonatomic,strong) AVCaptureDevice * captureDevice;
@property (nonatomic,strong) NSTimer * sosTimer;
@property (nonatomic,strong) NSTimer * sosChangTimer;

@property(nonatomic,assign)int timeAdd;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self initUI];
//    [self initShouDianTong];
    [self initShouShi];
    [self initToolBtn];
    [self OnLight];
}

//初始化界面
- (void)initUI{
    
    self.shouDianTongLabel = [Factory createLabelWithTitle:@"手电筒" frame:CGRectMake((ScreenWidth - 100)/2, 20, 100, 44)];
    self.shouDianTongLabel.textAlignment = NSTextAlignmentCenter;
    self.shouDianTongLabel.textColor = [UIColor whiteColor];
    self.shouDianTongLabel.font = [UIFont systemFontOfSize:20];
    
    self.beiJingDengView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.beiJingDengView.image = [UIImage imageNamed:@"titlebar_shadow"];
    [self.view addSubview:self.beiJingDengView];
    self.beiJingDengView.alpha = 0;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:imageView];
    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"手电筒的副本.png"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.blackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview: self.blackImageView];
    self.blackImageView.image = [UIImage imageNamed:@"手电筒 (1)的副本.png"];
    self.blackImageView.alpha = 0;
    self.blackImageView.center = self.view.center;
    self.blackImageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.blackImageView.layer.shadowRadius = 0.f;
    self.blackImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.blackImageView.layer.shadowOpacity = 0.f;
    self.dengGuangImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 59.75f)/2, CGRectGetMinY(_blackImageView.frame) - 25, 59.75f, 22.5f)];
    [self.view addSubview: self.dengGuangImageView];
    self.dengGuangImageView.image = [UIImage imageNamed:@"dengguang.png"];
    self.dengGuangImageView.alpha = 0;
    
    self.dengGuangImageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.dengGuangImageView.layer.shadowRadius = 0.f;
    self.dengGuangImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.dengGuangImageView.layer.shadowOpacity = 0.f;
    
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.view.backgroundColor = [UIColor blackColor];
        imageView.alpha = 0;
        self.blackImageView.alpha = 1;
        
    } completion:^(BOOL finished) {
    }];
    self.blackImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnLight)];
    [self.blackImageView addGestureRecognizer:tapGesture];
}

- (void)initTanChuView{
//    self.tanChuKuangView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 200)];
    self.tanChuKuangView = [[UIView alloc]init];
    self.tanChuKuangView.frame = CGRectMake(0, 0, self.view.frame.size.width - 60, 100);
    self.tanChuKuangView.alpha = 0;
    [self.view addSubview:self.tanChuKuangView];
//    self.tanChuKuangView.center = self.progressBtn.center;
    self.tanChuKuangView.layer.masksToBounds = YES;
    self.tanChuKuangView.layer.cornerRadius = 25.f;
    self.tanChuKuangView.backgroundColor = [UIColor clearColor];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 64, self.view.frame.size.width - 30, 0.5f)];
    [self.view addSubview:self.lineView];
    self.lineView.backgroundColor = [UIColor whiteColor];
    self.lineView.alpha = 0;
    
    //创建滑动条对象
    self.slider = [[UISlider alloc]init];
    //位置设置，高度不可变更，40写的不起作用，系统默认
    _slider.frame =CGRectMake(120, 20, self.view.frame.size.width - 240, 40);
   
    _numbers = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    NSInteger numberOfSteps = ((NSUInteger)[_numbers count] - 1);
    _slider.maximumValue = numberOfSteps;  //滑块上限
    _slider.minimumValue=0.0f;
    _slider.value=10.f;
    _slider.minimumTrackTintColor=[UIColor yellowColor];
    _slider.maximumTrackTintColor=[UIColor whiteColor];
    _slider.thumbTintColor=[UIColor whiteColor];
    UIImage *sliderImage=[self OriginImage:[UIImage imageNamed:@"晴天2.png"] scaleToSize:CGSizeMake(30, 30)];
    [_slider  setThumbImage:sliderImage forState:UIControlStateNormal];
    [_slider  setThumbImage:sliderImage forState:UIControlStateHighlighted];
    _slider.layer.masksToBounds = YES;
    _slider.layer.cornerRadius = 1.f;
    //对滑动条添加事件函数
    [_slider addTarget:self action:@selector(pressSlider:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(kaiShiZhenDong) forControlEvents:UIControlEventTouchDown];
    [_slider addTarget:self action:@selector(kaiShiZhenDong) forControlEvents:UIControlEventTouchDragOutside];
    [self.tanChuKuangView addSubview:_slider];
    
   
    [UIView animateWithDuration:0.5 animations:^{
        self.tanChuKuangView.alpha = 1;
        self.tanChuKuangView.layer.cornerRadius = 8.f;
        self.beiJingDengView.alpha = 1;
        self.lineView.alpha = 0.3;

    } completion:^(BOOL finished) {
        [self kaiShiLianXuZhenDong];
        self.tanChuKuangView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
        [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
            // 放大
            self.tanChuKuangView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:nil];
    }];
}

//缩放图片
- (UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}
//    弹框消失动画
- (void)removeTanChuShiTu{
    [UIView animateWithDuration:0.5 animations:^{
        self.tanChuKuangView.alpha = 0;
        self.tanChuKuangView.layer.cornerRadius = 25.f;
        self.beiJingDengView.alpha = 0;
        self.lineView.alpha = 0;

    } completion:^(BOOL finished) {
        [self.tanChuKuangView removeFromSuperview];
    }];
}
//初始化各个按钮
- (void)initToolBtn{
    self.progressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.progressBtn.frame = CGRectMake(self.view.frame.size.width - 50, 20, 30, 30);

    if (PNCisIPHONEX) {
        self.progressBtn.frame = CGRectMake(self.view.frame.size.width - 50, 40, 30, 30);
    }
    
    [self.progressBtn setImage:[UIImage imageNamed:@"360手电筒.png"] forState:UIControlStateNormal];
    [self.progressBtn setImage:[UIImage imageNamed:@"360手电筒开.png"] forState:UIControlStateSelected];
    [self.progressBtn addTarget:self action:@selector(progressBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.progressBtn setImage:[UIImage imageNamed: @"360手电筒hui.png"] forState:UIControlStateDisabled];
    [self.view addSubview:self.progressBtn];

    self.aboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.aboutBtn.frame = CGRectMake(20, 20, 30, 30);
    if (PNCisIPHONEX) {
        self.aboutBtn.frame = CGRectMake(20, 40, 30, 30);
    }
    [self.aboutBtn setImage:[UIImage imageNamed:@"关于.png"] forState:UIControlStateNormal];
//    [self.aboutBtn setImage:[UIImage imageNamed:@"360手电筒开.png"] forState:UIControlStateSelected];
    [self.aboutBtn addTarget:self action:@selector(presentAboutMeController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.aboutBtn];
    
    
    self.shouDianTongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shouDianTongBtn.frame = CGRectMake(ScreenWidth - 206, ScreenHeight -55, 42, 42);
    [self.shouDianTongBtn setImage:[UIImage imageNamed:@"晴天1.png"] forState:UIControlStateNormal];
    [self.shouDianTongBtn setImage:[UIImage imageNamed:@"晴天2.png"] forState:UIControlStateSelected];
    [self.shouDianTongBtn addTarget:self action:@selector(clickShouDianTongBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.shouDianTongBtn.selected = YES;
    [self.view addSubview:self.shouDianTongBtn];
    
    self.shouDianTongBtnView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth - 186.5, CGRectGetMinY(self.shouDianTongBtn.frame) - 5, 4, 4)];
    self.shouDianTongBtnView.layer.cornerRadius = 2.f;
    self.shouDianTongBtnView.layer.masksToBounds = YES;
    self.shouDianTongBtnView.layer.borderWidth = 1.f;
    self.shouDianTongBtnView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.shouDianTongBtnView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.shouDianTongBtnView];
    
    
    
    self.shanShuoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shanShuoBtn.frame = CGRectMake(ScreenWidth - 150, ScreenHeight - 50, 30, 30);
    [self.shanShuoBtn setImage:[UIImage imageNamed:@"闪电发货hui1.png"] forState:UIControlStateNormal];
    [self.shanShuoBtn setImage:[UIImage imageNamed:@"闪电发货.png"] forState:UIControlStateSelected];
    [self.shanShuoBtn addTarget:self action:@selector(clickShanShuoBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.shanShuoBtn.selected = NO;
    [self.view addSubview:self.shanShuoBtn];
    
    self.shanShuoBtnView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth - 136, CGRectGetMinY(self.shanShuoBtn.frame) - 10, 4, 4)];
    self.shanShuoBtnView.layer.cornerRadius = 2.f;
    self.shanShuoBtnView.layer.masksToBounds = YES;
    self.shanShuoBtnView.layer.borderWidth = 1.f;
    self.shanShuoBtnView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.shanShuoBtnView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.shanShuoBtnView];
    self.shanShuoBtnView.hidden = YES;
    
    
    
    self.sosBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sosBtn.frame = CGRectMake(ScreenWidth - 100, ScreenHeight - 50, 30, 30);
    [self.sosBtn setImage:[UIImage imageNamed:@"25-SOShui.png"] forState:UIControlStateNormal];
    [self.sosBtn setImage:[UIImage imageNamed:@"25-SOS.png"] forState:UIControlStateSelected];
    [self.sosBtn addTarget:self action:@selector(clickSosBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sosBtn];
    self.sosBtn.selected = NO;
    
    self.sosBtnView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth - 86, CGRectGetMinY(self.shanShuoBtn.frame) - 10, 4, 4)];
    self.sosBtnView.layer.cornerRadius = 2.f;
    self.sosBtnView.layer.masksToBounds = YES;
    self.sosBtnView.layer.borderWidth = 1.f;
    self.sosBtnView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.sosBtnView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.sosBtnView];
    self.sosBtnView.hidden = YES;
    
    self.pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pushBtn.frame = CGRectMake(ScreenWidth - 50, ScreenHeight - 50, 30, 30);
    [self.pushBtn setImage:[UIImage imageNamed:@"翻转bai"] forState:UIControlStateNormal];
    [self.pushBtn setImage:[UIImage imageNamed:@"翻转bai"] forState:UIControlStateSelected];
    [self.pushBtn addTarget:self action:@selector(pushScreenShouDianTong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pushBtn];
    
    self.lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lockBtn.frame = CGRectMake(30, ScreenHeight - 50, 30, 30);
    [self.lockBtn setImage:[UIImage imageNamed:@"符号-解锁"] forState:UIControlStateNormal];
    [self.lockBtn setImage:[UIImage imageNamed:@"符号-锁"] forState:UIControlStateSelected];
    [self.lockBtn addTarget:self action:@selector(clickLockBtn:) forControlEvents:UIControlEventTouchUpInside];

    //    [self.view addSubview:self.lockBtn];
    
    UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
    [keyWin addSubview:self.lockBtn];
    
    
    if (PNCisIPHONEX) {
        self.lockBtn.frame = CGRectMake(30, ScreenHeight - 70, 30, 30);
        self.pushBtn.frame = CGRectMake(ScreenWidth - 50, ScreenHeight - 70, 30, 30);
        self.sosBtn.frame = CGRectMake(ScreenWidth - 100, ScreenHeight - 70, 30, 30);
        self.shouDianTongBtn.frame = CGRectMake(ScreenWidth - 206, ScreenHeight -75, 42, 42);
        self.shanShuoBtn.frame = CGRectMake(ScreenWidth - 150, ScreenHeight - 70, 30, 30);
        self.shanShuoBtn.frame = CGRectMake(ScreenWidth - 150, ScreenHeight - 70, 30, 30);

    }
}

- (void)clickLockBtn:(UIButton *)sender{
    
    
    _lockOn = !_lockOn;
    
    sender.transform = CGAffineTransformMakeScale(0.9, 0.9);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        sender.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    if (_lockOn) {
        
    
    
        sender.selected = YES;
        self.maskView = [[UIView alloc]initWithFrame:self.view.bounds];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.8;
        self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.effectView = [[UIVisualEffectView alloc] initWithEffect:self.effect];
        self.effectView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.effectView.alpha = 1.f;
        self.effectView.userInteractionEnabled = YES;
        [self.maskView addSubview:self.effectView];
        [self.view addSubview:self.maskView];
    }else{
        sender.selected = NO;
        [self.maskView removeFromSuperview];
    }
   
}

-(void)clickShouDianTongBtn:(UIButton *)sender{
    
//    [self stopSOSMode:sender];
    [self closedShouDianTong];
    
    [self.sosTimer invalidate];
    self.sosTimer = nil;
    self.shouDianTongBtn.selected = YES;
    self.shouDianTongBtnView.hidden = NO;
    self.sosBtn.selected = NO;
    self.sosBtnView.hidden = YES;
    self.shanShuoBtn.selected = NO;
    self.shanShuoBtnView.hidden = YES;
    [self closeTimer];
}
- (void)clickShanShuoBtn:(UIButton *)sender{
    _lightOn = YES;
    [self stopSOSMode:sender];

    [self OnLight];
    self.shouDianTongBtn.selected = NO;
    self.shouDianTongBtnView.hidden = YES;
    self.sosBtn.selected = NO;
    self.sosBtnView.hidden = YES;
    self.shanShuoBtn.selected = YES;
    self.shanShuoBtnView.hidden = NO;
    [self openTimer];
    
}
- (void)clickSosBtn:(UIButton *)sender{
    _lightOn = YES;
    [self OnLight];
    self.shouDianTongBtn.selected = NO;
    self.shouDianTongBtnView.hidden = YES;
    self.sosBtn.selected = YES;
    self.sosBtnView.hidden = NO;
    self.shanShuoBtn.selected = NO;
    self.shanShuoBtnView.hidden = YES;

    if (sender.selected) {
        [self startSOSMode:sender];
    }else{
        [self stopSOSMode:sender];
    }
}


- (void)pushScreenShouDianTong{
    __weak typeof (self) vc = self;
    [self closedShouDianTong];
    [self closeTimer];
    [self stopSOSMode:nil];
    [vc.navigationController.view.layer addAnimation:[self createTransitionAnimation] forKey:nil];
    ScreenDengViewController *svc = [[ScreenDengViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
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
    animation.subtype = kCATransitionFromLeft;
    //设置动画的持续时间
    animation.duration = 1.5;
    //设置动画速率(可变的)
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画添加到切换的过程中
    return animation;
}

- (void)presentAboutMeController:(UIButton *)sender{
    
    // 先缩小
    sender.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        sender.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    SettingViewController *aVc = [[SettingViewController alloc]init];
    [self presentViewController:aVc animated:YES completion:nil];
}
//滑动滑块的点击事件
- (void)pressSlider:(UISlider *)sender{
    NSLog(@"value=%f",_slider.value);
    
    NSUInteger index = (NSUInteger)(sender.value );
    [_slider setValue:index animated:YES];
    NSNumber *number = _numbers[index];
//    vstr = [NSString stringWithFormat:@"%@",number];
//    [self tiaoJieShouDianTongWithValue:]
    if (number == 0) {
        [self closedShouDianTong];
    }else{
        [self tiaoJieShouDianTongWithValue:[number floatValue]];
    }
}

- (void)progressBtnClicked:(UIButton *)sender{
    // 先缩小
    sender.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [self kaiShiZhenDong];
    
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        sender.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self initTanChuView];
        CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        baseAnimation.duration = 0.4;
        baseAnimation.repeatCount = 1;
        baseAnimation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
        baseAnimation.toValue = [NSNumber numberWithFloat:M_PI]; // 终止角度
        [self.progressBtn.layer addAnimation:baseAnimation forKey:@"rotate-layer"];
    }else{
        [self removeTanChuShiTu];
        CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        baseAnimation.duration = 0.4;
        baseAnimation.repeatCount = 1;
        baseAnimation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
        baseAnimation.toValue = [NSNumber numberWithFloat:-M_PI]; // 终止角度
        [self.progressBtn.layer addAnimation:baseAnimation forKey:@"rotate-layer"];
    }
}


//-(void)initShouDianTong{
//    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    /**
//     *  hasTorch :返回YES表明手机上有手电筒
//     */
//    if (![_captureDevice hasTorch]) {
//        NSLog(@"手电筒坏了");
//        return;
//    }
//}
//初始化点击手势
- (void)initShouShi{
  
}
//震动马达
- (void)kaiShiZhenDong{
    AudioServicesPlaySystemSound(1519);
}
- (void)kaiShiLianXuZhenDong{
    AudioServicesPlaySystemSound(1521);
}

- (void)openShouDianTong{
    //开启手电筒
    
    
    @try {

        NSLog(@"这一步没蹦1");
        if (self.captureDevice.torchMode == AVCaptureFlashModeOff) {
            NSLog(@"这一步没蹦2");
            
            [self.captureSession beginConfiguration];
            NSLog(@"这一步没蹦3");
            
            [self.captureDevice lockForConfiguration:nil];
            NSLog(@"这一步没蹦4");
            
            [self.captureDevice setTorchMode:AVCaptureTorchModeOn];
            NSLog(@"这一步没蹦5");
            
            [self.captureDevice setFlashMode:AVCaptureFlashModeOn];
            NSLog(@"这一步没蹦6");
            
            [self.captureDevice unlockForConfiguration];
            NSLog(@"这一步没蹦7");
            
            [self.captureSession commitConfiguration];
            NSLog(@"这一步没蹦8");
            
            [self.captureSession startRunning];
            NSLog(@"这一步没蹦9");
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%s\n%@", __FUNCTION__, exception);
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"当前手机手电筒不可用"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  //响应事件
                                                                  NSLog(@"action = %@", action);
                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                 NSLog(@"action = %@", action);
                                                             }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    @finally {
       
    }
    
    
    

    
}
- (void)closedShouDianTong{
    
    @try {
        
        if (self.captureDevice.torchMode == AVCaptureFlashModeOn) {
            [self.captureSession beginConfiguration];
            [self.captureDevice lockForConfiguration:nil];
            [self.captureDevice setTorchMode:AVCaptureTorchModeOff];
            [self.captureDevice setFlashMode:AVCaptureFlashModeOff];
            [self.captureDevice unlockForConfiguration];
            [self.captureSession commitConfiguration];
            [self.captureSession stopRunning];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%s\n%@", __FUNCTION__, exception);
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"当前手机手电筒不可用"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  //响应事件
                                                                  NSLog(@"action = %@", action);
                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                 NSLog(@"action = %@", action);
                                                             }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    @finally {
        
    }
    
  
    
}

- (void)tiaoJieShouDianTongWithValue:(float)value{
    
    if (self.captureDevice.torchMode == AVCaptureFlashModeOn) {
        [self.captureSession beginConfiguration];
        [self.captureDevice lockForConfiguration:nil];
        [self.captureDevice setTorchMode:AVCaptureTorchModeOn];
        [self.captureDevice setFlashMode:AVCaptureFlashModeOn];
        [self.captureDevice setTorchModeOnWithLevel:value/10 error:nil];
        [self.captureDevice unlockForConfiguration];
        [self.captureSession commitConfiguration];
        [self.captureSession startRunning];
    }
    
  
}
- (void)OnLight{
    [self kaiShiZhenDong];
    _lightOn = !_lightOn;
    //根据ligthOn状态判断打开还是关闭
    if (_lightOn) {
        self.progressBtn.enabled = YES;
        [self openShouDianTong];
        self.blackImageView.image = [UIImage imageNamed:@"手电筒 (1)的副本kai.png"];
        self.blackImageView.layer.shadowOffset = CGSizeMake(0, 0);
        self.blackImageView.layer.shadowRadius = 4.21f;
        self.blackImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.blackImageView.layer.shadowOpacity = 0.9f;
        self.dengGuangImageView.hidden = NO;
        self.dengGuangImageView.alpha = 1;
        self.dengGuangImageView.layer.shadowOffset = CGSizeMake(0, - 1);
        self.dengGuangImageView.layer.shadowRadius = 2.21f;
        self.dengGuangImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.dengGuangImageView.layer.shadowOpacity = 1.f;
        
        
    }else{
        self.progressBtn.enabled = NO;
        self.progressBtn.selected = NO;
        [self removeTanChuShiTu];
        CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        baseAnimation.duration = 0.4;
        baseAnimation.repeatCount = 1;
        baseAnimation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
        baseAnimation.toValue = [NSNumber numberWithFloat:-M_PI]; // 终止角度
        [self.progressBtn.layer addAnimation:baseAnimation forKey:@"rotate-layer"];
        
        
        self.dengGuangImageView.hidden = YES;
        self.blackImageView.layer.shadowOffset = CGSizeMake(0, 0);
        self.blackImageView.layer.shadowRadius = 0;
        self.blackImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.blackImageView.layer.shadowOpacity = 0;
        self.blackImageView.image = [UIImage imageNamed:@"手电筒 (1)的副本.png"];
        [self closedShouDianTong];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//打开定时器
- (void)openTimer{
    
    if(self.uiTimer != nil)
    {
        [self.uiTimer invalidate];
        self.uiTimer = nil;
    }
    
    _uiTimer = [NSTimer scheduledTimerWithTimeInterval:(11 - [@"1" integerValue])*0.075 target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
    [_uiTimer fire];
    
}
//关闭定时器
- (void)closeTimer{
    [_uiTimer invalidate];
    _uiTimer = nil;
}

//定时器事件
- (void)timerFire:(NSTimer *)sender{
    
    if (self.captureDevice.torchMode == AVCaptureTorchModeOn){
        [self closedShouDianTong];
        self.shanShuoBtnView.layer.borderWidth = 2.f;
        return;
    }else if (self.captureDevice.torchMode == AVCaptureTorchModeOff){
        self.shanShuoBtnView.layer.borderWidth = 1.f;
        [self openShouDianTong];
    }
}



//开始sos模式
- (void)startSOSMode:(UIButton *)sender {
    
    //    [self performSelectorOnMainThread:@selector(sosTimer:) withObject:nil waitUntilDone:YES];
    
//    self.swith.enabled = NO;
//    self.sosStartBtn.hidden = YES;
//    self.sosStopBtn.hidden = NO;
//
    
    if(self.sosTimer != nil)
    {
        [self.sosTimer invalidate];
        self.sosTimer = nil;
    }
    
    //使用定时器
    self.sosTimer = [NSTimer scheduledTimerWithTimeInterval:300.0/1000.0f target:self selector:@selector(sosTimer:) userInfo:nil repeats:YES];
    [self.sosTimer fire];
    
   
//    if(self.sosChangTimer != nil)
//    {
//        [self.sosChangTimer invalidate];
//        self.sosChangTimer = nil;
//    }
//    
//    //使用定时器
//    self.sosChangTimer = [NSTimer scheduledTimerWithTimeInterval:600.0/1000.0f target:self selector:@selector(sosTimer:) userInfo:nil repeats:YES];
//    
//    
//    [self.sosChangTimer fire];
    
}


//停止sos模式
- (void)stopSOSMode:(UIButton *)sender {
    
//    self.swith.enabled = YES;
//    self.sosStopBtn.hidden = YES;
//    self.sosStartBtn.hidden = NO;
    [self.sosTimer invalidate];
    self.sosTimer = nil;
    
    [self.sosChangTimer invalidate];
    self.sosChangTimer = nil;
    
    //当你取消定时器时，有可能闪光灯还亮着，这里要判断一下，如果还亮着，就关闭它
    if(self.captureDevice.torchMode == AVCaptureFlashModeOn)
    {
        [self.captureSession beginConfiguration];
        [self.captureDevice lockForConfiguration:nil];
        [self.captureDevice setTorchMode:AVCaptureTorchModeOff];
        [self.captureDevice setFlashMode:AVCaptureFlashModeOff];
        [self.captureDevice unlockForConfiguration];
        [self.captureSession commitConfiguration];
        [self.captureSession stopRunning];
    }
    
    
    
}

//定时执行方法
-(void)sosTimer:(NSTimer *)timer
{
    self.timeAdd ++;
    NSLog(@"SOS %d",self.timeAdd);
    [self.captureSession beginConfiguration];
    [self.captureDevice lockForConfiguration:nil];
    //判断闪光灯是否亮着
    if(self.captureDevice.torchMode == AVCaptureTorchModeOff){
        //打开闪光灯
        [self.captureDevice setTorchMode:AVCaptureTorchModeOn];
        [self.captureDevice setFlashMode:AVCaptureFlashModeOn];
        
    }else{
        //关闭闪光灯
        [self.captureDevice setTorchMode:AVCaptureTorchModeOff];
        [self.captureDevice setFlashMode:AVCaptureFlashModeOff];
    }
    [self.captureDevice unlockForConfiguration];
    [self.captureSession commitConfiguration];
    
    if(self.captureDevice.torchMode == AVCaptureTorchModeOff){
        [self.captureSession startRunning];
    }else{
        [self.captureSession stopRunning];
    }
    
}

-(AVCaptureSession *)captureSesion
{
    if(_captureSession == nil)
    {
        _captureSession = [[AVCaptureSession alloc] init];
    }

    return _captureSession;
}

-(AVCaptureDevice *)captureDevice
{
    if(_captureDevice == nil){
        _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if (![_captureDevice hasTorch]) {
            NSLog(@"手电筒坏了");
            return nil;
        }
    }
    return _captureDevice;
}


@end
