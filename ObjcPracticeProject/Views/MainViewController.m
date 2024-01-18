//
//  MainViewController.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/8/24.
//

#import "MainViewController.h"

@interface MainViewController ()
// MARK: UI
@property (weak, nonatomic) IBOutlet UIButton *moveBtn;
@property (weak, nonatomic) IBOutlet UIView *mainContentsView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIStackView *stackView;
@property (strong, nonatomic) NSMutableArray<UIImageView *> *tempImageViewArray;

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
    [self initRefreshControl];
    
    // collectionView Cell NIB register
    // MainData 호출
    // floatingView 세팅
    // 앱 최초 구동 시 튜토리얼 표시 (튜토리얼 닫힐 때 이미지 팝업 show -> TutorialVC 에서)
    //          -> 최초가 아닐 경우 : 이미지 팝업 show
    // 로그인 세팅
    
    
    
    // test
    [self initImageViewArray];
    [self initSubViews];
    [self initRefreshControl];
}

-(void)initSubViews {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
    self.stackView = [[UIStackView alloc] initWithArrangedSubviews:self.tempImageViewArray];
    self.stackView.translatesAutoresizingMaskIntoConstraints = false;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.distribution = UIStackViewDistributionFillProportionally;
    self.stackView.spacing = 10;
    [self.mainContentsView addSubview:self.scrollView];
    [self.scrollView addSubview:self.stackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.mainContentsView.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.mainContentsView.trailingAnchor],
        [self.scrollView.topAnchor constraintEqualToAnchor:self.mainContentsView.topAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.mainContentsView.bottomAnchor],
        
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.stackView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.stackView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor],
    ]];
    
}

-(void)initImageViewArray {
    UIImage *image1 = [UIImage systemImageNamed:@"1.circle.fill"];
    UIImage *image2 = [UIImage systemImageNamed:@"2.circle.fill"];
    UIImage *image3 = [UIImage systemImageNamed:@"3.circle.fill"];
    UIImage *image4 = [UIImage systemImageNamed:@"4.circle.fill"];
    UIImage *image5 = [UIImage systemImageNamed:@"5.circle.fill"];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image1];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:image3];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:image4];
    UIImageView *imageView5 = [[UIImageView alloc] initWithImage:image5];
    NoticeView *noticeView = [[NoticeView alloc] init];
        
    self.tempImageViewArray = [NSMutableArray arrayWithObjects:imageView1, imageView2, imageView3, imageView4, imageView5, noticeView, nil];
    for (UIImageView *imageView in self.tempImageViewArray) {
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView.widthAnchor constraintEqualToConstant:self.mainContentsView.frame.size.width].active = true;
        [imageView.heightAnchor constraintEqualToConstant:500].active = true;
    }
}

// MARK: Action
-(void)moveMyPage:(UITapGestureRecognizer *)tapGestureRecognizer {
    BOOL isLogin = [UserDefaults isLogin];
    if(isLogin) {
        // 로그인 O
        WebViewController *webVC = [CommonUtils getWebView:testPage params:nil headerTitle:nil];
        if (webVC != nil) {
            [self.navigationController pushViewController:webVC animated:YES];            
        }
    }
}

// MARK: Request Data and Refresh Data
-(void) initRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(refreshControlAction) forControlEvents:UIControlEventValueChanged];
    
    // scrollable view에서만 작동 가능
    [self.scrollView addSubview:self.refreshControl];
}
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
