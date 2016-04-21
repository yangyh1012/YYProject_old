//
//  ViewController.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "ViewController.h"
#import "YYTestData.h"

@interface ViewController ()<YYCommunicationDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UIAlertController *faceImageAlertController;

@property (nullable, nonatomic, strong) UITableView *tableView;

@property (nullable, nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self viewLoadSettingForTitle:@"这是标题" navItemFlag:NO tableFlag:YES tablePageFlag:NO collectionFlag:NO collectionPageFlag:NO requestFlag:NO keyboardFlag:NO];
}

- (void)viewLoadSettingForTitle:(NSString *)title navItemFlag:(BOOL)navItemFlag tableFlag:(BOOL)tableFlag tablePageFlag:(BOOL)tablePageFlag  collectionFlag:(BOOL)collectionFlag collectionPageFlag:(BOOL)collectionPageFlag requestFlag:(BOOL)requestFlag keyboardFlag:(BOOL)keyboardFlag {
    
    //============================添加视图============================
    
//    BOOL navItemFlag = NO;
    if (navItemFlag) {
        
        //添加导航条
        [self addNavItem];
    }
    
    
//    BOOL tableFlag = YES;
//    BOOL tablePageFlag = NO;
    if (tableFlag) {
        
        //添加表格
        [self addTableView:tablePageFlag];
    }
    
    
//    BOOL collectionFlag = NO;
//    BOOL collectionPageFlag = NO;
    if (collectionFlag) {
        
        //添加集合视图
        [self addCollectionView:collectionPageFlag];
    }
    
    //============================数据初始化============================
    
//    self.title = @"这是标题";
    self.title = title;
    [YYCommunication sharedManager].delegate = self;
    
    
    //============================数据请求============================
    
//    BOOL requestFlag = NO;
    if (requestFlag) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"sd_id",@"sd_id", nil];
        NSMutableDictionary *otherParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:YYTestNotification,YYNotificationKey, nil];
        [self requestDataList:params otherParams:otherParams];
    }
    
    //============================添加通知============================
    
//    BOOL keyboardFlag = NO;
    if (keyboardFlag) {
        
        //注册键盘出现通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        //注册键盘隐藏通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    
    [YYCommunication sharedManager].delegate = nil;
    
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification object:nil];
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewInit

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

- (void)addTableView:(BOOL)tablePageFlag {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //不要分割线
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //去掉多余的分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //默认选中第一行
    //[self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    if (tablePageFlag) {
        
        self.pageNum = YYProjectStartPage;
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadArticleListData方法）
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadListDataForStart)];
        header.automaticallyChangeAlpha = YES;// 设置自动切换透明度(在导航栏下面自动隐藏)
        header.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
        [header beginRefreshing];// 马上进入刷新状态
        self.tableView.mj_header = header;// 设置header
        
        // 上拉刷新
        __weak ViewController *wself = self;
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [wself loadListDataForMore];
        }];
    }
}

- (void)addCollectionView:(BOOL)collectionPageFlag {
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 65.0f) / 3.0f, 85.0f);
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewFlowLayout.minimumLineSpacing = 10;
    collectionViewFlowLayout.minimumInteritemSpacing = 10 * [self multiplesForPhone];
    collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10 * [self multiplesForPhone], 0, 10 * [self multiplesForPhone]);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.collectionViewLayout = collectionViewFlowLayout;
    
    if (collectionPageFlag) {
        
        self.pageNum = YYProjectStartPage;
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadArticleListData方法）
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadListDataForStart)];
        header.automaticallyChangeAlpha = YES;// 设置自动切换透明度(在导航栏下面自动隐藏)
        header.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
        [header beginRefreshing];// 马上进入刷新状态
        self.collectionView.mj_header = header;// 设置header
        
        // 上拉刷新
        __weak ViewController *wself = self;
        self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [wself loadListDataForMore];
        }];
    }
}

#pragma mark - Button

- (void)leftNavigationItemHandle:(id)sender {
    
    //TODO:leftNavigationItemHandle
}

- (void)rightNavigationItemHandle:(id)sender {
    
    //TODO:rightNavigationItemHandle
}

- (void)commitBtnHandle:(id)sender {
    
    [self.view endEditing:YES];
    
    NSString *passwordTextFieldText = @"";
    if ([NSString isStringEmpty:passwordTextFieldText]) {
        
        [self showHUDWithText:@"密码不得为空" mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
        [self hide:YES afterDelay:YYProjectHUDTipTime];
        
        return ;
    }
    
    [self performSegueWithIdentifier:@"showPasswordForget" sender:nil];
}

- (void)faceImageBtnHandle:(id)sender {
    
    __weak ViewController *wself = self;//防止循环引用
    
    if (!self.faceImageAlertController) {
        
        self.faceImageAlertController = [UIAlertController alertControllerWithTitle:nil
                                                                            message:nil
                                                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        [self.faceImageAlertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            DLog(@"%@",wself);
        }]];
        
        [self.faceImageAlertController addAction:[UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        
        [self.faceImageAlertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    }
    
    [self presentViewController:self.faceImageAlertController animated:YES completion:nil];
}

#pragma mark - Action

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
        
        [self.tableView.mj_header endRefreshing];
    } else {
        
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)backHandle {
    
    [self hide:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Request

- (void)requestDataList:(id)requestParams otherParams:(id)otherParams {
    
    [self showHUDWithText:YYProjectHUDRequestTipText mode:MBProgressHUDModeIndeterminate yOffset:0 font:YYProjectHUDLoadTextFont];
    [[YYCommunication sharedManager] httpRequest:YYProjectBaseUrl parameters:requestParams otherParams:otherParams mode:YYCommunicationModePost];
}

- (void)requestSuccess:(id)responseObject otherParams:(id)otherParams {
    
    NSString *notificationName = [otherParams objectForKey:YYNotificationKey];
    
    if ([notificationName isEqualToString:YYTestNotification]) {
        
        [self hide:YES];
        
        NSArray *array = (NSArray *)[responseObject objectForKey:@"data"];
        
        if (!self.datas && [array count] > 0) {
            
            self.datas = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dic in array) {
            
            YYTestData *data = [YYTestData mj_objectWithKeyValues:dic];
            [self.datas addObject:data];
        }
        
        if ([array count] <= 0) {
            
            [self showDataEmptyTip:@"暂无数据" positionY:0];
        } else {
            
            [self hideDataEmptyTip];
        }
        
        [self.tableView reloadData];
    } else if ([notificationName isEqualToString:@""]) {
        
        [self hide:YES];
        
        if (self.pageNum <= YYProjectStartPage) {
            
            [self.datas removeAllObjects];
        }
        
        NSArray *array = (NSArray *)[responseObject objectForKey:@"data"];
        
        if (!self.datas && [array count] > 0) {
            
            self.datas = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dic in array) {
            
            YYTestData *data = [YYTestData mj_objectWithKeyValues:dic];
            [self.datas addObject:data];
        }
        
        if ([array count] <= 0) {
            
            [self showDataEmptyTip:@"暂无数据" positionY:0];
        } else {
            
            [self hideDataEmptyTip];
        }
        
        //BUG FIX:提前刷新，数据崩溃 stopLoading之后跟着reloadData
        [self stopLoading];
        [self.tableView reloadData];
        
        if ([array count] <= 0 && self.pageNum > YYProjectStartPage) {
            
            self.pageNum = self.pageNum - 1;
        }
        
    } else if ([notificationName isEqualToString:@""]) {
        
        NSString *responseTip = (NSString *)[[responseObject objectForKey:@"data"] objectForKey:@"msg"];
        [self showHUDWithText:responseTip mode:MBProgressHUDModeText yOffset:[self HUDOffsetY] font:YYProjectHUDTipTextFont];
        [self performSelector:@selector(backHandle) withObject:nil afterDelay:YYProjectHUDTipTime];
        
    } else if ([notificationName isEqualToString:@""]) {
        
        
    }
}

#pragma mark - Notification

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
    
    //设置单元格不可点击
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    NSInteger section = indexPath.section;
    
    DLog(@"item:%@",@(item));
    DLog(@"section:%@",@(section));
}

#pragma mark - UICollectionViewDataSource

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.datas count];
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger item = indexPath.item;
    NSInteger section = indexPath.section;
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    DLog(@"item:%@",@(item));
    DLog(@"section:%@",@(section));
    
    //设置圆角、边框、边框颜色
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor = [[YYConstants sharedManager] YYProjectLightColor].CGColor;
    cell.layer.cornerRadius = 10.0f;
    cell.layer.masksToBounds = YES;
    
    return cell;
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
