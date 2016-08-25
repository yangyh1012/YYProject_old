//
//  YYBaseViewController.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "YYBaseViewController.h"
#import "YYTestData.h"

@interface YYBaseViewController ()<YYCommunicationDelegate,MBProgressHUDDelegate>

@property (nullable, nonatomic, strong) UITableView *tableView1;

@property (nullable, nonatomic, strong) UICollectionView *collectionView1;



@property (nullable, nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UILabel *dataEmptyTipLabel;

@end

@implementation YYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //我常用的Xcode快捷键
    // ctrl+6 打开方法导航
    // shift+↑ 选取
    // command+L 输入行数跳到指定行
    // command+/ 添加注释
    // command+[ 左移代码块
    // command+←或者↑ 跳到该文件的头部
    // command+ctrl+← 跳到上一个页面
    // command+ctrl+↑ h文件和m文件互换
    // command+shift+J 打开文件导航
    
    self.automaticallyAdjustsScrollViewInsets = NO;//去掉多余的滚动间距
    
    [YYCommunication sharedManager].delegate = self;//网络请求代理
    
    self.navigationController.navigationBar.translucent = NO;//去掉导航透明
    
    self.tabBarController.tabBar.translucent = NO;//去掉底部透明
    
    
    
    {
        BOOL flag = NO;
        
        //数据初始化
        if (flag) {
        
            self.title = @"这是标题";
            
            self.pageNum = YYProjectStartPage;
            
            [YYCommunication sharedManager].delegate = self;
        }
        
        //数据请求
        if (flag) {
        
            [self requestDataList:nil otherParams:nil];
        }
        
        //添加通知
        if (flag) {
         
            //注册键盘出现通知
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillShow:)
                                                         name:UIKeyboardWillShowNotification object:nil];
            //注册键盘隐藏通知
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillHide:)
                                                         name:UIKeyboardWillHideNotification object:nil];
        }
        
        if (flag) {
            
            //可以使界面的View的frame有值
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    {
        BOOL flag = NO;
        if (flag) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(notificationTestHandle:)
                                                         name:YYTestNotification object:nil];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    {
        BOOL flag = NO;
        if (flag) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:YYTestNotification object:nil];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)dealloc {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];//去掉动作
    [YYCommunication sharedManager].delegate = nil;//去除代理
    [[NSNotificationCenter defaultCenter] removeObserver:self];//去除通知
    [self hide:NO];//去除提示框
    
    {
        BOOL flag = NO;
        if (flag) {
         
            //解除键盘出现通知
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIKeyboardWillShowNotification object:nil];
            //解除键盘隐藏通知
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIKeyboardWillHideNotification object:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Init

- (void)navigationSetting {
    
    //隐藏后退按钮
    [self.navigationItem setHidesBackButton:YES];
    
    //设置导航栏字体颜色
    UINavigationController *navigationController = self.navigationController;
    if ([navigationController isKindOfClass:[UINavigationController class]]) {
        
        navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
        [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //登录取消时，自动跳转到首页
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    //跳转到指定的控制器
    for (UIViewController *temp in self.navigationController.viewControllers) {
        
        if ([temp isKindOfClass:[UITabBarController class]]) {

            UITabBarController *tabBarController = (UITabBarController *)temp;
            [tabBarController.navigationController popToViewController:temp animated:YES];
        }
    }
    
    //取消透明
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark - Request

/**
 *  废弃的网络请求
 *
 *  @param params 参数
 */
- (void)requestDataListForNotification:(id)params {
    
//    [self showHUDWithText:YYProjectHUDRequestTipText mode:MBProgressHUDModeIndeterminate yOffset:0 font:YYProjectHUDLoadTextFont];
//    [[YYCommunication sharedManager] httpRequest:YYProjectBaseUrl parameters:params mode:YYCommunicationModePost notificationName:YYTestNotification uidAndTokenFlag:YES];
}





- (void)requestDataList:(id)requestParams otherParams:(id)otherParams {
    
    [self showHUDWithText:YYProjectHUDRequestTipText mode:MBProgressHUDModeIndeterminate yOffset:0 font:YYProjectHUDLoadTextFont];
    [[YYCommunication sharedManager] httpRequest:YYProjectBaseUrl parameters:requestParams otherParams:otherParams mode:YYCommunicationModePost];
}

- (void)requestResult:(id)responseObject URLString:(NSString *)URLString otherParams:(id)otherParams {
    
    NSNumber *responseStatus = (NSNumber *)[[responseObject objectForKey:@"status"] objectForKey:@"succeed"];
    
    //请求失败或者是重新登录
    if ([[responseStatus stringValue] isEqualToString:YYProjectStatusFailed] ||
        [[responseStatus stringValue] isEqualToString:YYProjectStatusLoginFirst]) {//失败
        
        NSString *responseTip = (NSString *)[[responseObject objectForKey:@"status"] objectForKey:@"error_desc"];
        [self requestLoginFirstOrFailedTip:(id)responseTip responseStatus:responseStatus otherParams:otherParams];
    } else {
        
        [self requestSuccess:responseObject otherParams:otherParams];
    }
}

- (void)requestFailure:(NSString *)URLString error:(NSError *)error otherParams:(id)otherParams {
    
    //打印错误信息
    [self showHUDWithText:[NSString codeDescription:[error code]] mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
    [self hide:YES afterDelay:YYProjectHUDTipTime];
    
    if ([otherParams objectForKey:YYNotificationPageLoad]) {
        
        [self stopLoadingAndPageInit];
    }
}

- (void)requestLoginFirstOrFailedTip:(id)responseTip responseStatus:(NSNumber *)responseStatus otherParams:(id)otherParams {
    
    [self showHUDWithText:responseTip mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
    
    //重新登录
    if ([[responseStatus stringValue] isEqualToString:YYProjectStatusLoginFirst]) {
        
        if (![otherParams objectForKey:YYNotificationLoginFirst]) {
            
            [self performSelector:@selector(showLogin:) withObject:nil afterDelay:YYProjectHUDTipTime];
        } else {
            
            [self hide:YES afterDelay:YYProjectHUDTipTime];
        }
        
    } else {
        
        [self hide:YES afterDelay:YYProjectHUDTipTime];
    }
    
    if ([otherParams objectForKey:YYNotificationPageLoad]) {
        
        [self stopLoadingAndPageInit];
    }
}

- (void)requestSuccess:(id)responseObject otherParams:(id)otherParams {
    
    
}

#pragma mark - Action

- (void)showLogin:(id)sender {
    
    [self hide:YES];
    [[YYDataHandle sharedManager] setUserDefaultStringValue:@"" WithKey:YYProjectSid];
    [self performSegueWithIdentifier:@"showLogin" sender:nil];
}

/**
 *  下拉加载数据
 */
- (void)loadListDataForStart {
    
    self.pageNum = YYProjectStartPage;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"sd_id",@"sd_id", nil];
    NSMutableDictionary *otherParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:YYTestNotification,YYNotificationKey, nil];
    [self requestDataList:params otherParams:otherParams];
}

/**
 *  上拉加载数据
 */
- (void)loadListDataForMore {
    
    self.pageNum = self.pageNum + 1;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"sd_id",@"sd_id", nil];
    NSMutableDictionary *otherParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:YYTestNotification,YYNotificationKey, nil];
    [self requestDataList:params otherParams:otherParams];
}

/**
 *  停止刷新
 */
- (void)stopLoading {
    
    if (self.pageNum == YYProjectStartPage) {
        
        [self.tableView1.mj_header endRefreshing];
    } else {
        
        [self.tableView1.mj_footer endRefreshing];
    }
}

- (void)stopLoadingAndPageInit {
    
    [self stopLoading];
    if (self.pageNum > YYProjectStartPage) {
        
        self.pageNum = self.pageNum - 1;
    }
}




//=======================================================================================================


- (void)btnSettingBackgroundImageViewForBtn:(UIButton *)button urlStr:(NSString *)urlStr {
    
    [self btnSettingBackgroundImageViewForBtn:button urlStr:urlStr contentModeFlag:YES];
}

- (void)btnSettingBackgroundImageViewForBtn:(UIButton *)button urlStr:(NSString *)urlStr contentModeFlag:(BOOL)flag {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //BUG FIX:要是button的背景图拉伸，不要设置sd_setImageWithURL，而是设置sd_setBackgroundImageWithURL
    [button sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:[[YYConstants sharedManager] YYProjectDefaultImage] options:SDWebImageRetryFailed];
    
    if (flag) {
        
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}






- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr underLineFlag:(BOOL)flag {
    
    return [self attributedStringSetting:allStr rangeStr:rangeStr textColor:nil fontSize:nil underLineFlag:flag];
}

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color fontSize:(UIFont *)font {
    
    return [self attributedStringSetting:allStr rangeStr:rangeStr textColor:color fontSize:font underLineFlag:NO];
}

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color fontSize:(UIFont *)font underLineFlag:(BOOL)flag {
    
    if ([NSString isStringEmpty:allStr]) {
        
        allStr = @"";
    }
    
    if ([NSString isStringEmpty:rangeStr]) {
        
        rangeStr = @"";
    }
    
    NSString *brandLabelStr = allStr;
    NSMutableAttributedString *brandLabelText = [[NSMutableAttributedString alloc] initWithString:brandLabelStr];
    NSRange brandLabelRange = [brandLabelStr rangeOfString:rangeStr];
    
    if (color) {
        
        [brandLabelText addAttribute:NSForegroundColorAttributeName value:color range:brandLabelRange];
    }
    
    if (font) {
        
        [brandLabelText addAttribute:NSFontAttributeName value:font range:brandLabelRange];
    }
    
    if (flag) {
        
        [brandLabelText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:brandLabelRange];
    }
    
    return brandLabelText;
}






- (NSString *)nullStrSetting:(NSString *)str {
    
    if (str == nil) {
        
        return @"";
    } else {
        
        return str;
    }
}

- (CGFloat)multiplesForPhone {
    
    if (IS_IPHONE_6) {
        
        return Scale_To_iPhone6;
    } else if (IS_IPHONE_6P) {
        
        return Scale_To_iPhone6P;
    } else {
        
        return 1.0f;
    }
}






- (void)showDataEmptyTip:(NSString *)tip positionY:(CGFloat)y {
    
    if (!self.dataEmptyTipLabel) {
        
        self.dataEmptyTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        self.dataEmptyTipLabel.text = tip;
        [self.view addSubview:self.dataEmptyTipLabel];
        [self.dataEmptyTipLabel sizeToFit];
        self.dataEmptyTipLabel.frame = CGRectMake((self.view.frame.size.width - self.dataEmptyTipLabel.frame.size.width) / 2.0, (self.view.frame.size.height - self.dataEmptyTipLabel.frame.size.height) / 2.0 - y, self.dataEmptyTipLabel.frame.size.width, self.dataEmptyTipLabel.frame.size.height);
    }
    
    [self.view bringSubviewToFront:self.dataEmptyTipLabel];
    self.dataEmptyTipLabel.hidden = NO;
}

- (void)hideDataEmptyTip {
    
    self.dataEmptyTipLabel.hidden = YES;
}

#pragma mark - Notification

- (void)notificationTestHandle:(NSNotification *)notification {
    
    if ([[notification object] isKindOfClass:[NSError class]]) {
        
        //打印错误信息
        NSError *error = (NSError *)[notification object];
        [self showHUDWithText:[NSString codeDescription:[error code]] mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
        [self hide:YES afterDelay:YYProjectHUDTipTime];
        
    } else {
        
        id responseObject = [notification object];
        NSNumber *responseStatus = (NSNumber *)[[responseObject objectForKey:@"status"] objectForKey:@"succeed"];
        
        //请求失败或者是重新登录
        if ([[responseStatus stringValue] isEqualToString:YYProjectStatusFailed] ||
            [[responseStatus stringValue] isEqualToString:YYProjectStatusLoginFirst]) {//失败
            
            NSString *responseTip = (NSString *)[[responseObject objectForKey:@"status"] objectForKey:@"error_desc"];
            [self showHUDWithText:responseTip mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
            
            //重新登录
            if ([[responseStatus stringValue] isEqualToString:YYProjectStatusLoginFirst]) {
                
                [self performSelector:@selector(showLogin:) withObject:nil afterDelay:YYProjectHUDTipTime];
                
            } else {
                
                [self hide:YES afterDelay:YYProjectHUDTipTime];
            }
            
        } else {//成功
            
            [self hide:YES];
            
            NSArray *array = (NSArray *)[responseObject objectForKey:@"data"];
            
            if (!self.datas && [array count] > 0) {
                
                self.datas = [[NSMutableArray alloc] init];
            }
            for (NSDictionary *dic in array) {
                
                YYTestData *data = [YYTestData mj_objectWithKeyValues:dic];
                [self.datas addObject:data];
            }
            
            [self.tableView1 reloadData];
        }
    }
}

- (void)notificationPageLoadHandle:(NSNotification *)notification {
    
    if ([[notification object] isKindOfClass:[NSError class]]) {
        
        NSError *error = (NSError *)[notification object];
        [self showHUDWithText:[NSString codeDescription:[error code]] mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
        [self hide:YES afterDelay:YYProjectHUDTipTime];
        
        [self stopLoadingAndPageInit];
        
    } else {
        
        id responseObject = [notification object];
        NSNumber *responseStatus = (NSNumber *)[[responseObject objectForKey:@"status"] objectForKey:@"succeed"];
        
        if ([[responseStatus stringValue] isEqualToString:YYProjectStatusFailed] ||
            [[responseStatus stringValue] isEqualToString:YYProjectStatusLoginFirst]) {//失败
            
            NSString *responseTip = (NSString *)[[responseObject objectForKey:@"status"] objectForKey:@"error_desc"];
            [self showHUDWithText:responseTip mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
            
            if ([[responseStatus stringValue] isEqualToString:YYProjectStatusLoginFirst]) {
                
                [self performSelector:@selector(showLogin:) withObject:nil afterDelay:YYProjectHUDTipTime];
                
            } else {
                
                [self hide:YES afterDelay:YYProjectHUDTipTime];
            }
            
            [self stopLoadingAndPageInit];
            
        } else {//成功
            
            [self hide:YES];
            
            if (self.pageNum <= YYProjectStartPage) {
                
                [self.datas removeAllObjects];
            }
            
            NSArray *array = (NSArray *)[responseObject objectForKey:@"data"];
            
            [self stopLoading];
            if ([array count] <= 0 && self.pageNum > YYProjectStartPage) {
                
                self.pageNum = self.pageNum - 1;
            }
            
            if (!self.datas && [array count] > 0) {
                
                self.datas = [[NSMutableArray alloc] init];
            }
            for (NSDictionary *dic in array) {
                
                YYTestData *data = [YYTestData mj_objectWithKeyValues:dic];
                [self.datas addObject:data];
            }
            
            //BUG FIX:提前刷新，数据崩溃
            [self.tableView1 reloadData];
        }
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    
    /*说明：UIKeyboardFrameEndUserInfoKey获得键盘的尺寸，键盘高度
     
     */
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    DLog(@"%.f",keyboardSize.height);
    
//    self.tableViewBottomConstraint.constant = keyboardSize.height;
//    [self updateViewConstraints];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    
    /*说明：UIKeyboardFrameEndUserInfoKey获得键盘的尺寸，键盘高度
     
     */
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    DLog(@"%.f",keyboardSize.height);
    
//    self.tableViewBottomConstraint.constant = self.tableViewBottomConstraint.constant - keyboardSize.height;
//    [self updateViewConstraints];
}

#pragma mark - MBProgressHUDDelegate

- (void)showHUDWithText:(NSString *)text mode:(MBProgressHUDMode)mode yOffset:(CGFloat)yOffset font:(CGFloat)fontSize {
    
    if (!self.HUD) {
        
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.HUD];
        self.HUD.delegate = self;
    }
    
    self.HUD.label.font = [UIFont systemFontOfSize:fontSize];
    self.HUD.offset = CGPointMake(self.HUD.offset.x, yOffset);
    self.HUD.mode = mode;
    self.HUD.label.text = text;
    [self.HUD showAnimated:YES];
}

- (void)hide:(BOOL)animated {
    
    [self hide:animated afterDelay:0];
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    
    if (delay > 0) {
        
        [self.HUD hideAnimated:YES afterDelay:YYProjectHUDTipTime];
    } else {
        
        [self.HUD hideAnimated:YES];
    }
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    [self.HUD removeFromSuperview];
    self.HUD = nil;
}

- (CGFloat)HUDOffsetY {
    
    return self.view.frame.size.height/2.0 - 100;
}

#pragma mark - UITextFieldDelegate

/**
 *  只能输入数字
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    BOOL flag = NO;
    
    if (flag) {
        
        if ([string length] > 0) {
            
            unichar single = [string characterAtIndex:0];//当前输入的字符
            if ((single >= '0' && single <= '9')) {//数据格式正确
                
                //首字母不能为0
                if([textField.text length] == 0){
                    
                    if (single == '0') {
                        
                        return NO;
                    } else {
                        
                        return YES;
                    }
                } else {
                    
                    return YES;
                }
            } else {//输入的数据格式不正确
                
                return NO;
            }
        } else {
            
            return YES;
        }
    } else {
        
        return YES;
    }
}

#pragma mark - StoryboardSegue

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showTest"]) {
        
        
    } else if ([segue.identifier isEqualToString:@"showTest"]) {
        
        
    }
}


@end
