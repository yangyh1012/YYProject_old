//
//  YYBaseViewController.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "YYBaseViewController.h"
#import "YYTestData.h"

@interface YYBaseViewController ()<YYCommunicationDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>

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
    //
    //
    //
    
    BOOL flag = NO;
    
    //添加视图
    if (flag) {
        
        //添加导航条
        [self addNavItem];
        
        //添加表格
        [self addTableView];
    }
    
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    BOOL flag = NO;
    if (flag) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notificationTestHandle:)
                                                     name:YYTestNotification object:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    BOOL flag = NO;
    if (flag) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:YYTestNotification object:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)dealloc {
    
    [YYCommunication sharedManager].delegate = nil;
    
    BOOL flag = NO;
    if (flag) {
     
        //解除键盘出现通知
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillShowNotification object:nil];
        //解除键盘隐藏通知
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillHideNotification object:nil];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Init

- (void)addNavItem {
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"厦门" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftNavigationItemHandle:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0, 0, 40, 18);
    [leftButton sizeToFit];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightNavigationItemHandle:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    
    UIBarButtonItem *leftMenuButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem *rightMenuButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects: leftMenuButton, nil] animated:YES];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: rightMenuButton, nil] animated:YES];
}

- (void)addTableView {
    
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    
    //去掉多余的分割线
    self.tableView1.tableFooterView = [[UIView alloc] init];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadArticleListData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadListDataForStart)];
    header.automaticallyChangeAlpha = YES;// 设置自动切换透明度(在导航栏下面自动隐藏)
    header.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
    [header beginRefreshing];// 马上进入刷新状态
    self.tableView1.mj_header = header;// 设置header
    
    // 上拉刷新
    __weak YYBaseViewController *wself = self;
    self.tableView1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [wself loadListDataForMore];
    }];
}

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

- (void)requestResult:(nullable id)responseObject URLString:(nullable NSString *)URLString otherParams:(nullable id)otherParams {
    
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

- (void)requestFailure:(NSString *)URLString error:(nullable NSError *)error otherParams:(id)otherParams {
    
    //打印错误信息
    [self showHUDWithText:[NSString codeDescription:[error code]] mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
    [self.HUD hide:YES afterDelay:YYProjectHUDTipTime];
    
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
            
            [self.HUD hide:YES afterDelay:YYProjectHUDTipTime];
        }
        
    } else {
        
        [self.HUD hide:YES afterDelay:YYProjectHUDTipTime];
    }
    
    if ([otherParams objectForKey:YYNotificationPageLoad]) {
        
        [self stopLoadingAndPageInit];
    }
}

- (void)requestSuccess:(id)responseObject otherParams:(id)otherParams {
    
    
}

#pragma mark - Button

- (void)leftNavigationItemHandle:(id)sender {
    
    
}

- (void)rightNavigationItemHandle:(id)sender {
    
    
}

#pragma mark - Action

- (void)showLogin:(id)sender {
    
    [self.HUD hide:YES];
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

- (CGFloat)HUDOffsetY {
    
    return self.view.frame.size.height/2.0 - 100;
}

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

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr {
    
    return [self attributedStringSetting:allStr rangeStr:rangeStr textColor:[UIColor redColor]];
}

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color {
    
    if (!rangeStr) {
        
        rangeStr = @"";
    }
    
    NSString *brandLabelStr = allStr;
    NSMutableAttributedString *brandLabelText = [[NSMutableAttributedString alloc] initWithString:brandLabelStr];
    NSRange brandLabelRange = [brandLabelStr rangeOfString:rangeStr];
    [brandLabelText addAttribute:NSForegroundColorAttributeName value:color range:brandLabelRange];
    
    return brandLabelText;
}




- (void)layerSettingWithView:(UIView *)view borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    [self layerSettingWithView:view borderWidth:borderWidth borderColor:borderColor cornerRadius:0 masksToBounds:YES];
}

- (void)layerSettingWithView:(UIView *)view borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds {
    
    [self layerSettingWithView:view borderWidth:borderWidth borderColor:borderColor cornerRadius:0 masksToBounds:masksToBounds];
}

- (void)layerSettingWithView:(UIView *)view borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds {
    
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
    
    if (cornerRadius != 0) {
        
        view.layer.cornerRadius = cornerRadius;
    }
    
    view.layer.masksToBounds = masksToBounds;
}



- (NSString *)nullStrSetting:(NSString *)str {
    
    if (!str) {
        
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
        [self.HUD hide:YES afterDelay:YYProjectHUDTipTime];
        
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
                
                [self.HUD hide:YES afterDelay:YYProjectHUDTipTime];
            }
            
        } else {//成功
            
            [self.HUD hide:YES];
            
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
        [self.HUD hide:YES afterDelay:YYProjectHUDTipTime];
        
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
                
                [self.HUD hide:YES afterDelay:YYProjectHUDTipTime];
            }
            
            [self stopLoadingAndPageInit];
            
        } else {//成功
            
            [self.HUD hide:YES];
            
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    DLog(@"row:%@",@(row));
    DLog(@"section:%@",@(section));
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 5;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 5;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    NSInteger section = indexPath.section;
//    NSInteger row = indexPath.row;
//    
//    DLog(@"row:%@",@(row));
//    DLog(@"section:%@",@(section));
//}

#pragma mark - MBProgressHUDDelegate

- (void)showHUDWithText:(NSString *)text mode:(MBProgressHUDMode)mode yOffset:(CGFloat)yOffset font:(CGFloat)fontSize {
    
    if (!self.HUD) {
        
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:self.HUD];
        self.HUD.delegate = self;
    }
    
    self.HUD.labelFont = [UIFont systemFontOfSize:fontSize];
    self.HUD.yOffset = yOffset;
    self.HUD.mode = mode;
    self.HUD.labelText = text;
    [self.HUD show:YES];
}

- (void)hide:(BOOL)animated {
    
    [self hide:animated afterDelay:0];
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    
    if (delay > 0) {
        
        [self.HUD hide:YES afterDelay:YYProjectHUDTipTime];
    } else {
        
        [self.HUD hide:YES];
    }
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    [self.HUD removeFromSuperview];
    self.HUD = nil;
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
