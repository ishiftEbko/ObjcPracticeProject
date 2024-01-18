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
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTableView];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self initTableView];
//    }
//    return self;
//}
//
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initTableView];
    }
    return self;
}

-(void)registerNib {
    NSString *cellId = NSStringFromClass([NoticeTVCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
}

-(void)initHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 150)];
    self.headerView.translatesAutoresizingMaskIntoConstraints = false;
    
    self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headerView.bounds.origin.x, self.headerView.bounds.origin.y, (self.headerView.bounds.size.width)*0.6, self.headerView.bounds.size.height)];
    self.headerMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.headerView.bounds.origin.x, self.headerView.bounds.origin.y, (self.headerView.bounds.size.width)*0.2, (self.headerView.bounds.size.height)*0.5)];
    
    self.headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.headerMoreBtn.translatesAutoresizingMaskIntoConstraints = false;
    
    self.headerTitleLabel.text = @"공지사항";
    [self.headerTitleLabel setTextColor:[UIColor blackColor]];
    [self.headerTitleLabel setFont:[UIFont boldSystemFontOfSize:25]];
    self.headerTitleLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.headerMoreBtn setBackgroundColor:[UIColor systemRedColor]];
    [self.headerMoreBtn.titleLabel setText:@"더보기"];
    [self.headerMoreBtn.titleLabel setTextColor:[UIColor systemGrayColor]];
    self.headerMoreBtn.titleLabel.textAlignment = NSTextAlignmentRight;
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
        
        [self.headerTitleLabel.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
        [self.headerTitleLabel.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor constant:35],
        
        [self.headerMoreBtn.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
        [self.headerMoreBtn.leadingAnchor constraintEqualToAnchor:self.headerTitleLabel.trailingAnchor constant:20],
        [self.headerMoreBtn.widthAnchor constraintEqualToConstant:150],
    ]];
    
//    [self.headerView layoutIfNeeded];
}

// MARK: Action
-(void)moreBtnTouched:(UIButton *)sender {
    NSLog(@"더보기 버튼 클릭");
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
