//
//  ZQSearchViewController.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/20.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQSearchViewController.h"
#import "ZQSearchNormalViewController.h"
#import "ZQSearchEditViewController.h"

#define padding 20.f
#define bottomPadding 0.f
#define naviPadding 50.f
#define itemWidth 30.f
#define itemHeight 30.f
#define searchBarH 36.f
#define naviHeight (IS_PhoneXAll ? 84.f : 64.f)

@interface ZQSearchViewController ()<UITextFieldDelegate, ZQSearchChildViewDelegate>


@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) UITextField *searchBar;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, assign) ZQSearchState sState;
@property (nonatomic, assign) ZQSearchBarStyle sStyle;

//子控制器
@property (nonatomic, strong) UIViewController *ctr1;//结果界面
@property (nonatomic, strong) ZQSearchEditViewController *ctr2;//匹配界面
@property (nonatomic, strong) ZQSearchNormalViewController *ctr3;//默认界面

//
@property (nonatomic, assign) NSInteger inputCount;

@end

@implementation ZQSearchViewController

- (void)dealloc {
    NSLog(@"dealloc");
}

- (instancetype)initSearchViewWithHotDatas:(NSArray *)hotList resultController:(UIViewController *)resultController{
    self = [super init];
    if (self) {
        resultController.view.frame = self.baseView.bounds;
        self.ctr1 = resultController;
        
        [self configBaseUI];
        [self setupChildViewWithState:ZQSearchStateNormal];
        [self.ctr3 setHotDataSource:hotList];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self showSearchViewAnimation];
    [self.searchBar becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - config UI
/*
 * 顶部导航栏view
 * 子控制器view
 */
- (void)configBaseUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.baseView];
    [self.view addSubview:self.naviView];
    
    [self.naviView addSubview:self.searchBar];
    [self.naviView addSubview:self.backBtn];
    [self.naviView addSubview:self.cancelBtn];
    
    [self.baseView addSubview:self.ctr1.view];
    [self.baseView addSubview:self.ctr2.view];
    [self.baseView addSubview:self.ctr3.view];
    
    [self addChildViewController:self.ctr1];
    [self addChildViewController:self.ctr2];
    [self addChildViewController:self.ctr3];
}

- (void)setupChildViewWithState:(ZQSearchState)state {
    self.sState = state;
    
    self.ctr2.view.hidden = YES;
    switch (self.sState) {
        case ZQSearchStateNormal:
            [self.baseView sendSubviewToBack:self.ctr1.view];
            break;
        case ZQSearchStateEditing:
            self.ctr2.view.hidden = NO;
            break;
        case ZQSearchStateResult:
            [self.baseView sendSubviewToBack:self.ctr3.view];
            break;
        default:
            break;
    }
    [self.baseView bringSubviewToFront:self.ctr2.view];
}

- (void)beginEditState {
    self.ctr2.view.hidden = NO;
}

- (void)endEditState {
    self.ctr2.view.hidden = YES;
}


#pragma mark - animation
- (void)showSearchViewAnimation {
    if (self.sStyle != ZQSearchBarStyleNone) {
        return;
    }
    self.sStyle = ZQSearchBarStyleCannel;
    [UIView animateWithDuration:0.25f animations:^{
        self.searchBar.frame = CGRectMake(padding, naviHeight - bottomPadding - searchBarH, ZQSearchWidth - padding - itemWidth - padding, searchBarH);
    } completion:nil];
}

- (void)showCanncelAnimation {
    if (self.sStyle == ZQSearchBarStyleCannel) {
        return;
    }
    [UIView animateWithDuration:0.25f animations:^{
        CGRect cannelF = self.cancelBtn.frame;
        CGRect searchF = self.searchBar.frame;
        CGRect backF = self.backBtn.frame;
        
        CGFloat offset = itemWidth + padding/2;
        
        backF.origin.x -= offset;
        searchF.origin.x -= offset;
        cannelF.origin.x -= offset;
        
        self.backBtn.frame = backF;
        self.searchBar.frame = searchF;
        self.cancelBtn.frame = cannelF;
        
    } completion:^(BOOL finished) {
        self.sStyle = ZQSearchBarStyleCannel;
    }];
}

- (void)showBackAnimation {
    if (self.sStyle == ZQSearchBarStyleBack) {
        return;
    }
    [UIView animateWithDuration:0.25f animations:^{
        CGRect cannelF = self.cancelBtn.frame;
        CGRect searchF = self.searchBar.frame;
        CGRect backF = self.backBtn.frame;
        
        CGFloat offset = itemWidth + padding/2;
        
        backF.origin.x += offset;
        searchF.origin.x += offset;
        cannelF.origin.x += offset;
        
        self.backBtn.frame = backF;
        self.searchBar.frame = searchF;
        self.cancelBtn.frame = cannelF;
        
    } completion:^(BOOL finished) {
        self.sStyle = ZQSearchBarStyleBack;
    }];
}

#pragma mark - actions
- (void)cancelBtnClicked:(UIButton *)sender {
    if (self.searchBar.text.length) {
        [self endEditState];
        [self showBackAnimation];
        [self.searchBar resignFirstResponder];
    } else {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)backBtnClicked:(UIButton *)sender {
     [self.navigationController popViewControllerAnimated:NO];
}


- (void)searchEditViewNeedRefresh:(NSNumber *)count {
    if (count.intValue != self.inputCount) {
        return;
    }
    //刷新模糊搜索界面
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchEditViewRefreshWithKeyString:DataBlock:)]) {
        @weakify(self)
        [self.delegate searchEditViewRefreshWithKeyString:self.searchBar.text DataBlock:^(id data) {
            @strongify(self)
            [self.ctr2 refreshSearchEditViewWith:data];
        }];
    }
}

#pragma mark - UITextFieldActions
- (void)textFieldDidBegin:(UITextField *)field {
    self.inputCount = 0;
    [self showCanncelAnimation];
    if (field.text.length) {
        [self beginEditState];
    }
}

- (void)textFieldChanged:(UITextField *)field {
    NSString *text = field.text;
    if (text.length == 0) {
        [self setupChildViewWithState:ZQSearchStateNormal];
    } else {
        [self setupChildViewWithState:ZQSearchStateEditing];
        self.inputCount++;
        [self performSelector:@selector(searchEditViewNeedRefresh:) withObject:@(self.inputCount) afterDelay:0.5f];
    }
}

- (void)textFieldDidExit:(UITextField *)field {
    //历史记录
    [self saveSearchCacheWith:field.text];
    
    [self setupChildViewWithState:ZQSearchStateResult];
    [self showBackAnimation];
    //刷新结果界面
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchFuzzyResultWithKeyString:Data:resultController:)]) {
        [self.delegate searchFuzzyResultWithKeyString:field.text Data:nil resultController:self.ctr1];
    }
    NSLog(@"edit exit");
}

#pragma mark - private
- (void)saveSearchCacheWith:(NSString *)searchText {
    if (searchText.length > 0) {
        [self.ctr3.historyList removeObject:searchText];
        [self.ctr3.historyList insertObject:searchText atIndex:0];
        
        [NSKeyedArchiver archiveRootObject:self.ctr3.historyList toFile:ZQ_SEARCH_HISTORY_CACHE_PATH];
        [self.ctr3 refreshHistoryView];
    }
}


#pragma mark - ZQSearchChildViewDelegate
- (void)searchChildViewDidScroll {
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
    }
}

- (void)searchChildViewDidSelectItem:(id)value {
    //保存历史
    [self saveSearchCacheWith:value];
    //更新界面
    self.searchBar.text = value;
    [self setupChildViewWithState:ZQSearchStateResult];
    [self showBackAnimation];
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
    }
    //刷新模糊搜索界面
    [self searchEditViewNeedRefresh:@(self.inputCount)];
    //刷新结果界面
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchFuzzyResultWithKeyString:Data:resultController:)]) {
        [self.delegate searchFuzzyResultWithKeyString:value Data:nil resultController:self.ctr1];
    }
}

- (void)searchChildViewDidSelectRow:(id<ZQSearchData>)value {
    //保存历史
    [self saveSearchCacheWith:value.title];
    
    //更新界面
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
    }
    
    //模糊搜索，刷新结果界面
    if (value.editType == SearchEditTypeFuzzy) {
        [self setupChildViewWithState:ZQSearchStateResult];
        [self showBackAnimation];
        //刷新结果界面
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchFuzzyResultWithKeyString:Data:resultController:)]) {
            [self.delegate searchFuzzyResultWithKeyString:value.title Data:value resultController:self.ctr1];
        }
        self.searchBar.text = value.title;
    } else {
        //找到结果，回调
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchConfirmResultWithKeyString:Data:resultController:)]) {
            [self.delegate searchConfirmResultWithKeyString:value.title Data:value resultController:self.ctr1];
        }
    }
    
}

#pragma mark - getter & setter
- (UITextField *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(60, naviHeight - searchBarH, ZQSearchWidth - 60 - itemWidth - padding, searchBarH)];
        _searchBar.placeholder = @"搜索";
        _searchBar.layer.cornerRadius = 2.f;
        _searchBar.font = [UIFont systemFontOfSize:14];
        _searchBar.leftView = [self leftView];
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        _searchBar.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        _searchBar.delegate = self;
        _searchBar.returnKeyType = UIReturnKeySearch;
        _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_searchBar addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [_searchBar addTarget:self action:@selector(textFieldDidExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [_searchBar addTarget:self action:@selector(textFieldDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    }
    return _searchBar;
}

- (UIView *)leftView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 32, searchBarH)];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_search@3x"]];
    imgView.frame = CGRectMake(15, 12, 12, 12);
    [view addSubview:imgView];
    return view;
}

- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZQSearchWidth, naviHeight)];
        _naviView.backgroundColor = [UIColor whiteColor];
    }
    return _naviView;
}

- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, naviHeight, ZQSearchWidth, ZQSearchHeight - naviHeight)];
        _baseView.backgroundColor = [UIColor redColor];
    }
    return _baseView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(ZQSearchWidth - 10 - itemWidth, naviHeight - itemHeight - 3, itemWidth, itemHeight);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(-itemWidth, naviHeight - itemHeight - 8, itemWidth, itemHeight);
        [_backBtn setImage:[UIImage imageNamed:@"ic_back@2x"] forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIViewController *)ctr1 {
    if (!_ctr1) {
        _ctr1 = [[UIViewController alloc] init];
        _ctr1.view.frame = self.baseView.bounds;
    }
    return _ctr1;
}

- (ZQSearchEditViewController *)ctr2 {
    if (!_ctr2) {
        _ctr2 = [[ZQSearchEditViewController alloc] init];
        _ctr2.view.frame = self.baseView.bounds;
        _ctr2.delegate = self;
    }
    return _ctr2;
}

- (ZQSearchNormalViewController *)ctr3 {
    if (!_ctr3) {
        _ctr3 = [[ZQSearchNormalViewController alloc] init];
        _ctr3.view.frame = self.baseView.bounds;
        _ctr3.delegate = self;
    }
    return _ctr3;
}

- (void)setCloseFuzzyTable:(BOOL)closeFuzzyTable {
    _closeFuzzyTable = closeFuzzyTable;
    [self.ctr2.view removeFromSuperview];
    self.ctr2 = nil;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder.copy;
    self.searchBar.placeholder = _placeholder;
}

@end
