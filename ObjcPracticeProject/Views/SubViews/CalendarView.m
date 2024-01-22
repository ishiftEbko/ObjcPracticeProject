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
        [self initCalendar];
        [self setLocale];
        
    }
    return self;
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

// MARK: FSCalendar Delegate


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
