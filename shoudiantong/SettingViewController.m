//
//  MEEEEViewController.m
//  leisure
//
//  Created by qianfeng0 on 16/3/3.
//  Copyright © 2016年 陈希. All rights reserved.
//

#import "SettingViewController.h"
//#import "CollectionViewController.h"
//#import "HXViewController.h"
//#import "SDCycleScrollView.h"
//#import "UserFeedBackViewController.h"
#import "MainContentCell.h"
#import <StoreKit/StoreKit.h>
#import <MessageUI/MessageUI.h>
//#import "AboutUSViewController.h"
#import "AboutViewController.h"
const CGFloat kNavigationBarHeight = 44;
const CGFloat kStatusBarHeight = 20;
@interface SettingViewController ()<UITableViewDataSource,SKStoreProductViewControllerDelegate, UITableViewDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, strong) UIView *headerContentView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) CGFloat scale;

@property(nonatomic,strong)UIAlertController *alert;


//@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView * backGroundImage;
@property(nonatomic,strong)UIVisualEffectView *effectView;
@property(nonatomic,strong)UIBlurEffect *effect;


@end


@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *pin = [[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 60, 30)];
    pin.image = [UIImage imageNamed:@"pin"];
    
    [self.navigationController.navigationBar addSubview:pin];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    image.image = [UIImage imageNamed:@"titlebar_shadow"];
    
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titlebar_bg1.png"] forBarMetrics:(UIBarMetricsDefault)];
    //    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.title =@"ME";
    
    //信息内容
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(108, self.headerContentView.bounds.size.height-60-12, ScreenWidth-108-12, 50)];
    label.text = @"      注册 / 登录";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    [self createUI];
    [self.view insertSubview:image aboveSubview:self.tableView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)backAction{
  
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainContentCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    UIImageView * backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:backimage];
    backimage.image = [[UIImage imageNamed:@"QQ20180311-1.jpg"] applyBlurWithRadius:5 tintColor:nil saturationDeltaFactor:1 maskImage:nil];
    backimage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view insertSubview:self.tableView aboveSubview:backimage];
    
    UIButton * backBtn = [Factory createButtonWithTitle:@"" frame:CGRectMake(20, 28, 25, 25) backgroundColor:[UIColor clearColor] backgroundImage:[UIImage imageNamed:@""] target:self action:@selector(backAction)];
    
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    UILabel * label = [Factory createLabelWithTitle:@"设置" frame:CGRectMake(60, 20, 60, 40) fontSize:16.f];
    label.font = [UIFont fontWithName:@"Heiti SC" size:20.f];
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    UIView *label111 = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-80)/2, ScreenHeight-150, 80, 80)];
    label111.backgroundColor = [UIColor whiteColor];
    label111.layer.cornerRadius=12;
    label111.layer.shadowColor=[UIColor grayColor].CGColor;
    label111.layer.shadowOffset=CGSizeMake(0.5, 0.5);
    label111.layer.shadowOpacity=0.8;
    label111.layer.shadowRadius=1.2;
    //    [self.view addSubview:label111];
    
    
    //    UIImageView *  iconImage = [[UIImageView alloc]init];
    //    iconImage.frame = CGRectMake(0, 0, 80, 80);
    //    iconImage.layer.cornerRadius=12;
    //    iconImage.layer.masksToBounds = YES;
    //    iconImage.image = [UIImage imageNamed:@"iconcheng.png"];
    //
    //
    //    [label111 addSubview:iconImage];
    //
    //
    //    UILabel * label1 = [Factory createLabelWithTitle:[NSString stringWithFormat:@"Version：v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]
    //                                               frame:CGRectMake((ScreenWidth-120)/2, ScreenHeight-60, 120, 40) fontSize:16.f];
    //
    //    label1.font = [UIFont fontWithName:@"Heiti SC" size:15.f];
    //    label1.textAlignment = NSTextAlignmentCenter;
    //    label1.backgroundColor = [UIColor clearColor];
    //    label1.textColor = [UIColor whiteColor];
    //    [self.view addSubview:label1];
    
    
    
}

//
//
//- (void)createView
//{
//    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.view addSubview:self.tableView];
//
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//
//    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
//    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"head"];
//
//}
//
//
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if (indexPath.section == 0&&indexPath.row==0) {
//        cell.textLabel.text = @"";
//        return cell;
//    }else if (indexPath.section == 0&&indexPath.row==1){
//        cell.textLabel.text = @"联系我们";
//
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//        return cell;
//
//    }else if (indexPath.section == 1&&indexPath.row==0){
//        cell.textLabel.text = @"意见反馈";
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//        return cell;
//    }else if (indexPath.section == 1&&indexPath.row==1){
//        cell.textLabel.text = @"清除缓存";
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//        return cell;
//    }else if (indexPath.section == 2&&indexPath.row==0){
//        cell.textLabel.text = @"我的收藏";
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//        return cell;
//    }else if (indexPath.section == 2&&indexPath.row==1){
//        cell.textLabel.text = @"夜间模式";
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//        return cell;
//    }
//
//
//
//    else
//
//
//    cell.textLabel.text = [NSString stringWithFormat:@"cell %ld", (long)indexPath.row];
//
//    return cell;
//}
//
//
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//
//
//
//    if (indexPath.section == 1&&indexPath.row==0) {
//        UserFeedBackViewController *uvc = [[UserFeedBackViewController alloc]init];
//        [self.navigationController pushViewController:uvc animated:YES];
//    }else if (indexPath.section==1&&indexPath.row==1){
//
//        [self clearHuancun];
//    }else if (indexPath.section==0&&indexPath.row==1){
//        AboutUsViewController *avc = [[AboutUsViewController alloc]init];
//        [self.navigationController pushViewController:avc animated:YES];
//
//    }
//
//
//
//
//    else if (indexPath.section == 2&&indexPath.row==0) {
//        CollectionViewController *cvc = [[CollectionViewController alloc]init];
//        [self.navigationController pushViewController:cvc animated:YES];
//    }else if (indexPath.section == 2&&indexPath.row==0){
//        HXViewController *hvc = [[HXViewController alloc]init];
//        [self.navigationController pushViewController:hvc animated:YES];
//    }else if (indexPath.section == 3&&indexPath.row==0){
//        self.alert = [UIAlertController alertControllerWithTitle:@"暂无更新" message:@"当前版本1.0" preferredStyle:UIAlertControllerStyleAlert];
//        //使用类方法创建一个AlertAction，第一个参数按钮的名称，第二个参数按钮的类型，第三个block表示按钮点击后的行为。
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //点击按钮之后的回调，可以在这里写出对应按钮的行为，不再是delegate中判断按钮是第几个了。
//            //NSLog(@"确定被点击");
//        }];
//        //使用类方法创建一个AlertAction，第一个参数按钮的名称，第二个参数按钮的类型，第三个block表示按钮点击后的行为。
//        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            //点击按钮之后的回调，可以在这里写出对应按钮的行为，不再是delegate中判断按钮是第几个了。
//            //NSLog(@"取消被点击");
//        }];
//        //为警告视图控制器添加按钮
//        [self.alert addAction:action];
//        [self.alert addAction:action2];
//        //使用模态跳转弹出警告视图控制器
//        [self presentViewController:self.alert animated:YES completion:NULL];
//
//    }else if (indexPath.section == 2&&indexPath.row ==1)
//    {
//         self.alert = [UIAlertController alertControllerWithTitle:@"暂无该功能" message:@"敬请期待..." preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //点击按钮之后的回调，可以在这里写出对应按钮的行为，不再是delegate中判断按钮是第几个了。
//            //NSLog(@"确定被点击");
//        }];
//        //使用类方法创建一个AlertAction，第一个参数按钮的名称，第二个参数按钮的类型，第三个block表示按钮点击后的行为。
//        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            //点击按钮之后的回调，可以在这里写出对应按钮的行为，不再是delegate中判断按钮是第几个了。
//            //NSLog(@"取消被点击");
//        }];
//        //为警告视图控制器添加按钮
//        [self.alert addAction:action];
//        [self.alert addAction:action2];
//        //使用模态跳转弹出警告视图控制器
//        [self presentViewController:self.alert animated:YES completion:NULL];
//
//
//    }
//}
//
//- (void)clearHuancun{
//    //第0分区
//    NSString *sizeStr = [NSString stringWithFormat:@"%.2fM",[self getCacheSize]];
//    UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:@"清除缓存" message:sizeStr preferredStyle:UIAlertControllerStyleActionSheet];
//    [actionsheet addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//        //删除按钮
//        //1.删除sd
//        [[SDImageCache sharedImageCache] clearMemory];//清除内存缓存
//        [[SDImageCache sharedImageCache] clearDisk];//磁盘
//        //2.界面下载的缓存
//        NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
//        //删除
//        [[NSFileManager defaultManager] removeItemAtPath:myPath error:nil];
//
//    }]];
//    [actionsheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        //NSLog(@"取消");
//    }]];
//    [self presentViewController:actionsheet animated:YES completion:nil];
//}
////获取所有缓存大小
//- (CGFloat)getCacheSize {
//    //缓存 有两类 sdwebimage 还有 每个界面保存的缓存
//    CGFloat sdSize = [[SDImageCache sharedImageCache] getSize];
//    NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
//    //获取文件夹中的所有的文件
//    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:myPath error:nil];
//    unsigned long long size = 0;
//    for (NSString *fileName in arr) {
//        NSString *filePath = [myPath stringByAppendingPathComponent:fileName];
//        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
//        size += dict.fileSize;
//    }
//    //1M = 1024 K = 1024*1024字节
//    CGFloat totalSize = (sdSize+size) * 3/1024.0/1024.0;
//    return totalSize;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    if (section == 0) {
//        NSArray *imageNames = @[@"S_23.jpg",@"S_24.jpg",@"S_26.jpg",@"S_10.jpg",@"S_21.jpg"];
//
//
//
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 160) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
//    cycleScrollView.delegate = self;
//    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//
//    cycleScrollView.autoScrollTimeInterval = 4.0f;
//    UIView *header = (UIView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
//
//    [header addSubview:cycleScrollView];
//
//        CGRect icon_frame = CGRectMake(30 ,120,80,80);
//        UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
//        icon.backgroundColor = [UIColor clearColor];
//        icon.image = [UIImage imageNamed:@"iconP1@3x.png"];
//        icon.layer.cornerRadius = 6.f;
//        icon.layer.masksToBounds = YES;
////        icon.layer.borderWidth = 1.0f;
//        icon.layer.borderColor = [UIColor lightGrayColor].CGColor;
//
//        [header bringSubviewToFront:icon];
//        [header addSubview:icon];
//
//
//
//
//
//
//        return header;
//    }else{
//        UIView*head =  (UIView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
//        return head;
//    }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 160;
//    }else{
//        return 20;
//    }
//
//}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        return 180;
    }
    
    if (indexPath.row == 0) {
        NSString *statusString = [[NSUserDefaults standardUserDefaults] objectForKey:@"KaiGuanShiFouDaKai"];
        if ([statusString isEqualToString:@"关"]) {
            return 1;
            
        }else if ([statusString isEqualToString:@"开"]){
            return 62;
        }else{
            return 1;
        }
    }
    
    
    return 62;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainContentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    if (indexPath.row == 0) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"更多独立精品App";
        cell.imageView.image = [UIImage imageNamed:@"沙漏"];
        
        NSString *statusString = [[NSUserDefaults standardUserDefaults] objectForKey:@"KaiGuanShiFouDaKai"];
        if ([statusString isEqualToString:@"开"]) {
            cell.contentView.hidden = NO;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if ([statusString isEqualToString:@"关"]){
            cell.contentView.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.contentView.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }else if (indexPath.row == 6){
        cell.textLabel.text = @"我的收藏";
        cell.imageView.image = [UIImage imageNamed:@"星级2"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if (indexPath.row == 1){
        cell.textLabel.text = @"意见反馈";
        cell.imageView.image = [UIImage imageNamed:@"反馈问题"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if (indexPath.row == 7){
        
        cell.textLabel.text = @"清除缓存";
        cell.imageView.image = [UIImage imageNamed:@"new2清除缓存"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
        
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"给个赞";
        cell.imageView.image = [UIImage imageNamed:@"星级2"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if (indexPath.row == 3){
        
        cell.label.frame = CGRectMake(10, 10, ScreenWidth-20, 180);
        if (!_backGroundImage) {
            _backGroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 180)];
        }
        [cell.label addSubview:_backGroundImage];
        _backGroundImage.backgroundColor = [UIColor clearColor];
        _backGroundImage.image = [UIImage imageNamed:@"backImage1"];
        _backGroundImage.layer.cornerRadius = 6;
        _backGroundImage.layer.masksToBounds = YES;
        _backGroundImage.alpha = 0.6;
        _backGroundImage.contentMode = UIViewContentModeScaleAspectFill;
        
        self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        self.effectView = [[UIVisualEffectView alloc] initWithEffect:self.effect];
        
        self.effectView.frame = CGRectMake(0, 0, ScreenWidth-40, 180);
        
        self.effectView.alpha = 1.f;
        self.effectView.userInteractionEnabled = YES;
        [_backGroundImage addSubview:self.effectView];
        
        UILabel * label2 = [Factory createLabelWithTitle:@"* 这就是我心里的一座城池，其他人眼中的一片废墟。" frame:CGRectMake(5,20 ,ScreenWidth-40,55) fontSize:12.f];
        label2.numberOfLines = 0;
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont fontWithName:@"Heiti SC" size:12.f];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.backgroundColor = [UIColor clearColor];
        label2.textColor = [UIColor whiteColor];
//        [cell addSubview:label2];
        
        UILabel * label1 = [Factory createLabelWithTitle:@"春日傍晚\n落日西斜\n远海的岛屿渐渐看不见了\n忽然岛上亮起了一盏盏灯火\n指明了它们的所在\n— 正冈子规" frame:CGRectMake(0,20 ,ScreenWidth-20,120) fontSize:12.f];
        label1.numberOfLines = 0;
        
        label1.font = [UIFont fontWithName:@"Heiti SC" size:13.f];
        label1.textAlignment = NSTextAlignmentCenter;
//        label1.backgroundColor = [UIColor redColor];
        label1.textColor = [UIColor blackColor];
        [cell.contentView addSubview:label1];
        
//        cell.label.backgroundColor = [UIColor blackColor];
        cell.label.alpha = 0.5f;
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        NSString * url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1358074351"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

    }
    
    
    
    if (indexPath.row == 4) {
        //        NSString * appstoreUrlString = @"https://appsto.re/cn/8phbbb.i";
        //
        //        NSURL * url = [NSURL URLWithString:appstoreUrlString];
        //
        //        if ([[UIApplication sharedApplication] canOpenURL:url])
        //        {
        //            [[UIApplication sharedApplication] openURL:url];
        //        }
        //        else
        //        {
        //            NSLog(@"can not open");
        //        }
        //
        //        //初始化控制器
        //        SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
        //        //设置代理请求为当前控制器本身
        //        storeProductViewContorller.delegate = self;
        //        //加载一个新的视图展示
        //        [storeProductViewContorller loadProductWithParameters:
        //         //appId唯一的
        //         @{SKStoreProductParameterITunesItemIdentifier : @"1150478784"} completionBlock:^(BOOL result, NSError *error) {
        //             //block回调
        //             if(error){
        //                 NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
        //             }else{
        //                 //模态弹出appstore
        //                 [self presentViewController:storeProductViewContorller animated:YES completion:^{
        //
        //                 }
        //                  ];
        //             }
        //         }];
        [self openAppWithIdentifier:@"1353019343"];
        
        
        
    }else if (indexPath.row == 1){
        
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"手电筒(iOS版)反馈"];
        NSString * device = [[UIDevice currentDevice] model];
        NSString * ios = [[UIDevice currentDevice] systemVersion];
        NSString *body = [NSString stringWithFormat:@"请留下您的宝贵建议和意见：\n\n\n以下信息有助于我们确认您的问题，建议保留。\nDevice: %@\nOS Version: %@\n", device, ios];
        [controller setMessageBody:body isHTML:NO];
        NSArray *toRecipients = [NSArray arrayWithObject:@"506343891@qq.com"];
        [controller setToRecipients:toRecipients];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    
    else if (indexPath.row == 0){
        AboutViewController * ab = [[AboutViewController alloc]init];
        [self presentViewController:ab animated:YES completion:nil];
    }else if (indexPath.row == 1){
//        CollectionViewController *cvc = [[CollectionViewController alloc]init];
//        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.row == 3){
        [self clearHuancun];
        
    }else if (indexPath.row == 5){
        
    }
    
}

- (void)openAppWithIdentifier:(NSString *)appId {
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
        if (result) {
            [self presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
    
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)storeProductVC {
    [storeProductVC dismissViewControllerAnimated:YES completion:^{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

- (void)clearHuancun{
    //第0分区
    NSString *sizeStr = [NSString stringWithFormat:@"%.2fM",[self getCacheSize]];
    UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:@"清除缓存" message:sizeStr preferredStyle:UIAlertControllerStyleActionSheet];
    [actionsheet addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //删除按钮
        //1.删除sd
//        [[SDImageCache sharedImageCache] clearMemory];//清除内存缓存
//        [[SDImageCache sharedImageCache] clearDisk];//磁盘
        //2.界面下载的缓存
        NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
        //删除
        [[NSFileManager defaultManager] removeItemAtPath:myPath error:nil];
        
    }]];
    [actionsheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //NSLog(@"取消");
    }]];
    [self presentViewController:actionsheet animated:YES completion:nil];
}
//获取所有缓存大小
- (CGFloat)getCacheSize {
    //缓存 有两类 sdwebimage 还有 每个界面保存的缓存
//    CGFloat sdSize = [[SDImageCache sharedImageCache] getSize];
    NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    //获取文件夹中的所有的文件
    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:myPath error:nil];
    unsigned long long size = 0;
    for (NSString *fileName in arr) {
        NSString *filePath = [myPath stringByAppendingPathComponent:fileName];
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += dict.fileSize;
    }
    //1M = 1024 K = 1024*1024字节
    CGFloat totalSize = 1024;
//    (sdSize+size) * 3/1024.0/1024.0;
    return totalSize;
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您的反馈发送成功。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
//    [self dismissViewControllerAnimated:YES completion:^{
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}






@end
