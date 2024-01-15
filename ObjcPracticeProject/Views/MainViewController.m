//
//  MainViewController.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/8/24.
//

#import "MainViewController.h"

@interface MainViewController ()
// MARK: UI
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *moveBtn;

@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"MainViewController ViewDidLoad");
    
    // 다른 화면으로 이동하여 다른 화면에 머무르고 있을 경우 스와이프 제스쳐를 통해 이전 화면으로 돌아가는 동작 방지
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // 버튼 텍스트 세팅 및 제스쳐 추가
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveMyPage:)];
    [self.moveBtn addGestureRecognizer:tap];
    
    // Notification Center addObserver
    // refresh control 세팅
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(refreshControlAction) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    self.collectionView.alwaysBounceVertical = true;
    
    // collectionView Cell NIB register
    // MainData 호출
    // floatingView 세팅
    // 앱 최초 구동 시 튜토리얼 표시 (튜토리얼 닫힐 때 이미지 팝업 show -> TutorialVC 에서)
    //          -> 최초가 아닐 경우 : 이미지 팝업 show
    // 로그인 세팅
}

// MARK: Action
-(void)moveMyPage:(UITapGestureRecognizer *)tapGestureRecognizer {
    BOOL isLogin = [UserDefaults isLogin];
    if(isLogin) {
        // 로그인 O
//        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:SB_MAIN bundle:nil];
//        WebViewController *webVC = (WebViewController *)[mainSB instantiateViewControllerWithIdentifier:NSStringFromClass([WebViewController class])];
        WebViewController *webVC = [CommonUtils getWebView:testPage params:nil headerTitle:nil];
        if (webVC != nil) {
            [self.navigationController pushViewController:webVC animated:YES];            
        }
    }
}

// MARK: Request Data and Refresh Data
-(void) refreshControlAction {
    // 새로고침 시 업데이트 유무 필요 유무 확인하여 main data request
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self finishRequestData];
    });
}

-(void) finishRequestData {
    // 데이터 로딩 확인 후 refreshControl 종료
    if (self.refreshControl && self.refreshControl.isRefreshing) {
        [self.refreshControl endRefreshing];
    }
}

@end
