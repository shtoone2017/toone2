//
//  DrawerController.m
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "MyViewController.h"
#import "DrawerController.h"
#import "MySJView.h"
@interface MyViewController ()
{
    BOOL isShowScreenView;
}

@property (nonatomic,strong) DrawerController * drawer;

@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_scView)
    {
        [_scView.tbView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_screenViewTitleArr && _screenViewTitleArr.count > 0)
    {
        [self addRightScreenBtn];
    }
    

}
-(NSString *)startTime{
    if (!_startTime) {
        self.startTime = [TimeTools time_3_monthsAgo];
    }
    return _startTime;
}
-(NSString *)endTime{
    if (!_endTime) {
        self.endTime = [TimeTools currentTime];
    }
    return _endTime;
}

#pragma mark - 添加筛选视图
- (void)addRightScreenBtn
{
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self createScreenViewWithTitlrArr:_screenViewTitleArr];
}

- (void)createScreenViewWithTitlrArr:(NSArray *)titleArr
{
    _scView = [[ScreenView alloc] initWithFrame: CGRectMake(Screen_w, 60, Screen_w-30, Screen_h) titleArr:titleArr type:ScreenViewTypeBF_JC];
    //    _scView.backgroundColor = [UIColor cyanColor];
    _scView.block = ^(BOOL isShow) {
        isShowScreenView = isShow;
    };
    
//    WS(weakSelf);
//    _scView.paraBlock = ^(NSDictionary *paraDic) {
//        NSMutableDictionary *tempDic = [weakSelf getParaDic];
//        [tempDic setValuesForKeysWithDictionary:paraDic];
//        [tempDic setObject:@"1341763200" forKey:jinchangshijian1];
//        [tempDic setObject:@"1246723200" forKey:chuchangshijian1];
//        [weakSelf refreshDataWithParaDic:tempDic];
//    };
    [self.view addSubview:_scView];
    [self.view bringSubviewToFront:_scView];
}



- (void)rightBtnClick
{
    if (isShowScreenView == YES)
    {
        [self hidenScreenView];
    }
    else
    {
        [self showScreenView];
    }
}

- (void)showScreenView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        _scView.frame = CGRectMake(30, 60, Screen_w-30, Screen_h);
    } completion:nil];
    isShowScreenView = !isShowScreenView;
    
}

- (void)hidenScreenView
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        _scView.frame = CGRectMake(Screen_w, 60, Screen_w-30, Screen_h);
    } completion:nil];
    isShowScreenView = !isShowScreenView;
    
}

#pragma mark - 添加搜索按钮
-(void)addSearchButton{
    //1.     ic_search_white_18dp
    UIButton * btn = [UIButton img_20WithName:@"ic_search_white_18dp"];
    btn.center = CGPointMake(Screen_w-40, Screen_h-49-40);
    btn.backgroundColor = [UIColor indigoColor];
    btn.alpha = 0.8;
    btn.tag = 1;
    btn.layer.cornerRadius = 20.0;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - 提供一个可供子类继承/重写的buttonClick:
-(void)searchButtonClick:(UIButton*)sender{}
#pragma mark - 封装3rd时间组件
-(void)calendarWithTimeString:(NSString*)timeString  obj:(id)obj{
    CJCalendarViewController *calendarController = [[CJCalendarViewController alloc] init];
    calendarController.view.frame = self.view.frame;
    calendarController.obj = obj;
    calendarController.delegate = self;
    NSArray *arr = [timeString componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"- "]];
    if (arr.count > 1) {
        [calendarController setYear:arr[0] month:arr[1] day:arr[2]];
    }
    
    [self presentViewController:calendarController animated:YES completion:nil];
}
//可选协议 @optional
-(void)CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    //获取时间
    if ([month intValue] <10) {
        month = [NSString stringWithFormat:@"0%d",[month intValue]];
    }
    if ([day intValue] <10) {
        day = [NSString stringWithFormat:@"0%d",[day intValue]];
    }
    __block NSString * timeString = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    
    __block CJCalendarViewController * weakcontroller = controller;
    //2.添加SJ
    MySJView * c = [[MySJView alloc] init];
    c.callBack = ^(SJButtonClickType type,NSString * time){
        if (type == SJOkClick) {
            timeString = [NSString stringWithFormat:@"%@ %@",timeString,time];
            if ([weakcontroller.obj isKindOfClass:[UIButton class]])
            {
                [(UIButton*)weakcontroller.obj setTitle:timeString forState:UIControlStateNormal];
            }
            else
            {
                UITextField *txtF = (UITextField *)weakcontroller.obj;
                txtF.text = timeString;
            }

            if (_block)
            {
                _block();
            }
        }
    };
    FuncLog;
}
//--------------------------------------------------------------------
#pragma mark - 添加手势
-(void)addPanGestureRecognizer{
    //1.移动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [self.view  addGestureRecognizer:pan];
}
// 和抽屉有关
-(DrawerController *)drawer{
    if (!_drawer) {
        self.drawer = [[DrawerController alloc] init];
    }
    return _drawer;
}
//// 手势代理，解决冲突
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
//        return YES;
//    }
//    return NO;
//}
-(void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.view];
    [pan setTranslation:CGPointZero inView:self.view];
    if (point.x > 20) {
        @synchronized (self) {
           [self.drawer show];
        }
    }
}
-(void)pan{
    @synchronized (self) {
        [self.drawer show];
    }
}
#pragma  mark - dealloc
-(void)dealloc{
    FuncLog;
}


@end
