//
//  MainViewController.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/8/24.
//

#import "MainViewController.h"
typedef enum {
    main,
    empty
} Section;

@interface MainViewController ()
// MARK: UI
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property(nonatomic, weak, nullable) id<UICollectionViewDataSource> dataSource;

@end

@implementation MainViewController
// collectionView -> DiffableDataSource로 안 되나
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"MainViewController ViewDidLoad");
//    
//    [[NSUserDefaults standardUserDefaults] setObject:@"testValue" forKey:@"testKey"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 다른 화면으로 이동하여 다른 화면에 머무르고 있을 경우 스와이프 제스쳐를 통해 이전 화면으로 돌아가는 동작 방지
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // 버튼 텍스트 세팅 및 제스쳐 추가
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
    
     
    // diffable, snapshot 가능 여부 확인
    self.dataSource = [[UICollectionViewDiffableDataSource alloc] initWithCollectionView:self.collectionView cellProvider:^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, id  _Nonnull itemIdentifier) {
        // configure and return cell
        return [[UICollectionViewCell alloc] init];
    }];
    NSDiffableDataSourceSnapshot<NSNumber *, NSUUID *> *snapshot = [[NSDiffableDataSourceSnapshot alloc] init];
//    [self.dataSource applySnapshot:snapshot animatingDifferences:true];
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
