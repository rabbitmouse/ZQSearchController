# ZQSearchController 
仿饿了么搜索栏交互

#### 主要功能
1. 搜索主界面、模糊匹配界面，搜索结果界面之前的状态切换。
2. 可使用自定义结果界面进行搜索结果的展示。
3. 输入内容节流处理，输入完毕后 0.5 秒后再发生搜索事件。
4. 支持搜索历史，
5. 支持热门搜索配置
6. 顶部已适配iPhoneX 或 Xs

#### 效果
![demo](./demo.gif)

#### 依赖项目
SDWebImage

#### 版本要求
+ iOS9.0或更高

#### main
+ `ZQSearchConst`
+ `ZQSearchViewController`
+ `ZQSearchNormalViewController`
+ `ZQSearchEditViewController`

#### 如何使用
* Use CocoaPods:
  - `pod 'ZQSearch', '~> 0.1.9'`
  - `#import <ZQSearchViewController.h>`
* Manual import：
  - `git clone` project 
  - 将ZQSearch文件夹拖入项目
  - `#import "ZQSearchViewController.h"`

##### 使用详情（项目里有demo）

1.初始化ZQSearchController
```objc
NSArray *hots = @[@"热门",@"热门热门",@"热门热门热门",@"热门热门",@"热门",@"热门",@"热热门热门热门门"];

UIViewController *resultController = [UIViewController new];

ZQSearchViewController *vc = [[ZQSearchViewController alloc] initSearchViewWithHotDatas:hots resultController:resultController];
vc.delegate = self;
[self.navigationController pushViewController:vc animated:NO];
```
2.实现代理
```objc
- (void)searchEditViewRefreshWithKeyString:(NSString *)keyString DataBlock:(void (^)(id))block {
//异步调用搜索接口。
将搜索结果通过block回调到searchcontroller内部。
}

//模糊搜索结果列表，显示在传入的resultController
- (void)searchFuzzyResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController{
//1 搜索关键字
NSLog(@"%@",keyString);
//2 搜索返回数据（需遵守<ZQSearchData>协议，可自行扩展）
NSLog(@"%@",data);
//3 刷新resultController
[resultController reloadData];
}

//精确搜索回调
- (void)searchConfirmResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController {
//可以将结果自定义处理。
ResultViewController *vc = [ResultViewController new];
[resultController.navigationController pushViewController:vc animated:YES];
}
```
3.数据模型

搜索结果的对象需遵守 ZQSearchData 协议。用于显示模糊搜索时的匹配结果 UI
```objc
@protocol ZQSearchData <NSObject>
@required
@property (nonatomic, copy) NSString *title;

@optional
@property (nonatomic, assign) SearchEditType editType;//1.模糊内容，2.精确内容
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *desc;

@end
```

#### 感谢
如果你喜欢，可以给我star一下，如果觉得写的不好 也可以留言讨论，或者分享你的看法。
