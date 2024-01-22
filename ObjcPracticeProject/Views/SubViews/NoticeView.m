//
//  NoticeView.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/17/24.
//

#import "NoticeView.h"

@interface NoticeView()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UILabel *headerTitleLabel;
@property (strong, nonatomic) UIButton *headerMoreBtn;

@end

@implementation NoticeView
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        NSLog(@"init");
//        [self initTableView];
//    }
//    return self;
//}

/*
 UIView의 생성자
 initWithFrame, initWithCoder
 
 UIViewController의 생성자
 initWithNibName, initWithCoder
 
 initWithCoder: nib에서 로드할 때 호출되는 생성자 (xib, storyboard 이용)
                 호출 시점에 outlet, action 연결 X
 
 initWithFrame: UIView의 지정생성자 (by code, programatically)
 initWithNibName: UIViewController의 지정생성자 (by code, programatically)
 
 awakeFromNib: nib에서 모든 것이 로드되고 outlet, action이 모두 연결되면 호출되는 것이 보장됨
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame");
        [self initTableView];
    }
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        // xib나 storyboard에 없으면 호출도 안 되나?
//        NSLog(@"initWithCoder");
//        [self initTableView];
//    }
//    return self;
//}

-(void)registerNib {
    NSString *cellId = NSStringFromClass([NoticeTVCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
}

-(void)initHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 150)];
    self.headerView.translatesAutoresizingMaskIntoConstraints = false;
    
    self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headerView.bounds.origin.x, self.headerView.bounds.origin.y, (self.headerView.bounds.size.width)*0.6, self.headerView.bounds.size.height)];
    self.headerMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.headerView.bounds.origin.x, self.headerView.bounds.origin.y, (self.headerView.bounds.size.width)*0.3, (self.headerView.bounds.size.height)*0.5)];
    
    self.headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.headerMoreBtn.translatesAutoresizingMaskIntoConstraints = false;
    
    self.headerTitleLabel.text = @"공지사항";
    [self.headerTitleLabel setTextColor:[UIColor blackColor]];
    [self.headerTitleLabel setFont:[UIFont boldSystemFontOfSize:25]];
    self.headerTitleLabel.textAlignment = NSTextAlignmentLeft;
    
    // title의 appearance 변경 -> setAttributedTitle
    [self.headerMoreBtn setTitle:@"더보기" forState:UIControlStateNormal];
    [self.headerMoreBtn setTitleColor:[UIColor systemGrayColor] forState:UIControlStateNormal];
//    [self.headerMoreBtn setBackgroundColor:[UIColor systemGrayColor]];
//    [self.headerMoreBtn.layer setMasksToBounds:true];
//    [self.headerMoreBtn.layer setCornerRadius:10.0];
    [self.headerMoreBtn addTarget:self action:@selector(moreBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerView addSubview:self.headerTitleLabel];
    [self.headerView addSubview:self.headerMoreBtn];
}

-(void)initTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self registerNib];
    
    [self addSubview:self.tableView];
    
    [self initHeaderView];
    [self.tableView setTableHeaderView:self.headerView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setLayout];
}

-(void)setLayout {
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        
        [self.headerView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [self.headerView.heightAnchor constraintEqualToConstant:150],
        [self.headerView.leadingAnchor constraintEqualToAnchor:self.tableView.leadingAnchor],
        [self.headerView.topAnchor constraintEqualToAnchor:self.tableView.topAnchor],
        
        [self.headerTitleLabel.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
        [self.headerTitleLabel.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor constant:35],
        
        [self.headerMoreBtn.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
        [self.headerMoreBtn.leadingAnchor constraintEqualToAnchor:self.headerTitleLabel.trailingAnchor constant:20],
//        [self.headerMoreBtn.widthAnchor constraintEqualToConstant:(self.headerView.bounds.size.width)*0.6],
    ]];
    
//    [self.headerView layoutIfNeeded];
}

// MARK: Action
-(void)moreBtnTouched:(UIButton *)sender {
    NSLog(@"더보기 버튼 클릭");
    WebViewController *webVC = [CommonUtils getWebView:@"https://www.google.com" params:nil headerTitle:nil];
    // delegate
//    if (webVC != nil && self.delegate != nil) {
//        [self.delegate moveToNoticeWebView:webVC];
//    }
    
    // notification Center
    if (webVC != nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_GO_WEB_VIEW object:webVC];        
    }
}

// MARK: tableView Delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *cellId = NSStringFromClass([NoticeTVCell class]);
    NoticeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    // bindData
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Section Header";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0;
}

@end
