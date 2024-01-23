//
//  CalendarView.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/22/24.
//

#import "CalendarView.h"
#import "FSCalendarExtensions.h"

#define CalendarHeaderHeight 40

@interface CalendarView()
// MARK: Properties
@property (strong, nonatomic) NSMutableArray<NSString *> *arrDisplayDate;
@property (strong, nonatomic) NSCalendar *gregorian;

// MARK: UI
@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeight;
@property (weak, nonatomic) IBOutlet UIButton *calendarShowBtn;
@end


@implementation CalendarView
- (instancetype)init
{
    self = [super init];
    if (self) {
        return [self initWithNibName:NSStringFromClass([CalendarView class])];
    }
    return self;
}

// view 불러낼 때 단순히 init 으로만 하면 밑에 있는 subView가 나타나지 않음
// 왜냠... 당신... xib로 작성햇기 때문입니다
-(instancetype)initWithNibName:(NSString *)nibName {
    NSString *newNibName = nibName ? nibName : NSStringFromClass([CalendarView class]);
    UINib *nib = [UINib nibWithNibName:newNibName bundle:nil];
    NSArray *viewArray = [nib instantiateWithOwner:nil options:nil];
    
    for (id subView in viewArray) {
        if ([[self class] isSubclassOfClass:[subView class]]) {
            self = subView;
            break;
        }
    }
    if (self) {
        return self;
    }
    return nil;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initCalendar];
    [self setLocale];
}

-(void)initCalendar {
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    self.calendarView.layer.cornerRadius = 7.5f;
    
    self.calendar.delegate = self;
    self.calendar.dataSource = self;
    
    self.calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
    self.calendar.firstWeekday = 1;
    self.calendar.scrollEnabled = false;
    self.calendar.appearance.selectionColor = [UIColor whiteColor];
    self.calendar.appearance.headerTitleColor = [UIColor whiteColor];
    
    [self.calendar registerClass:[DIYCalendarCell class] forCellReuseIdentifier:@"DIYCalendarCell"];
    
    if (self.calendar.scope == FSCalendarScopeMonth) {
        [self.calendarShowBtn setImage:[UIImage systemImageNamed:@"arrow.down"] forState:UIControlStateNormal];
    } else {
        [self.calendarShowBtn setImage:[UIImage systemImageNamed:@"arrow.up"] forState:UIControlStateNormal];
    }
    
    [self.calendar reloadData];
}

/**
 system Locale에 따라 locale 설정
 */
- (void)setLocale {
    self.calendar.appearance.headerDateFormat = @"MMMM yyyy";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"];
    [self.calendar setLocale:locale];
    // UserDefaults에 있는 locale 값에 따라 -> self.calendar setLocale
}

/**
 경매 일정 정보 조회 후 binding Data
 */
- (void)bindingData:(DMAuctionScheduleInfo *)scheduleInfo {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMM"];
    NSString *yearMonth = [formatter stringFromDate:[NSDate date]];
    self.arrDisplayDate = [[NSMutableArray alloc] init];
    for ( DMAuctionScheduleInfoResult *result in scheduleInfo.result ) {
        NSString *day = result.displayDate;
        NSString *date = [NSString stringWithFormat:@":%@%@", yearMonth, day];
        [self.arrDisplayDate addObject:date];
    }
    
    if (self.calendar.selectedDate) {
        [self.calendar deselectDate:self.calendar.selectedDate];
    }
    
    [self.calendar setCurrentPage:[NSDate date]];
    
    [self.calendar reloadData];
}

// MARK: Button Action
- (IBAction)changeCalendarType:(id)sender {
    if (self.calendar.scope == FSCalendarScopeMonth) {
        [self.calendar setScope:FSCalendarScopeWeek animated:YES];
        [self.calendarShowBtn setImage:[UIImage systemImageNamed:@"arrow.up"] forState:UIControlStateNormal];
    } else {
        [self.calendar setScope:FSCalendarScopeMonth animated:YES];
        [self.calendarShowBtn setImage:[UIImage systemImageNamed:@"arrow.down"] forState:UIControlStateNormal];
    }
}

- (IBAction)goPreviousMonth:(id)sender {
    NSLog(@"previous month");
    [self changeMonth:-1];
    [self.calendar reloadData];
}

- (IBAction)goNextMonth:(id)sender {
    NSLog(@"next month");
    [self changeMonth:1];
    [self.calendar reloadData];
}

- (void)changeMonth:(NSInteger)value {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *changedMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:value toDate:currentMonth options:0];
    [self.calendar setCurrentPage:changedMonth animated:YES];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMM"];
    NSString *yearMonth = [formatter stringFromDate:changedMonth];
    // API 호출해서 summary도 변경
}

// MARK: FSCalendar Delegate
- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    if (self.delegate) {
        [self.delegate changeCalendarViewHeight:CGRectGetHeight(bounds) scope:self.calendar.scope];
    }
    
    self.calendarHeight.constant = CGRectGetHeight(bounds);
    [self layoutIfNeeded];
    if (self.calendar.selectedDate && [self.calendar.selectedDate isEqualToDate:self.calendar.today]) {
        [self.calendar deselectDate:self.calendar.selectedDate];
    }
}

@end


// cell을 구현해야 캘린더도 뜨는 듯???? 확인 필요
@implementation DIYCalendarCell
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 어쩌고저쩌고
    }
    return self;
}

@end
