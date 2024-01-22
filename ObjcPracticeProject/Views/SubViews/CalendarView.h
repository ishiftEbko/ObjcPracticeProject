//
//  CalendarView.h
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/22/24.
//

#import <UIKit/UIKit.h>
#import <FSCalendar/FSCalendar.h>

typedef NS_ENUM(NSUInteger, SelectionType) {
    None,
    Single,
    LeftBorder,
    Middle,
    RightBorder
};

NS_ASSUME_NONNULL_BEGIN
@protocol CalenderViewDelegate
@required
-(void)changeCalendarViewHeight:(CGFloat)height scope:(FSCalendarScope)scope;

@end

@interface CalendarView : UIView <FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance>
@property (strong, nonatomic) id<CalenderViewDelegate> delegate;
-(void)setLocale;
-(void)bindingData:(DMAuctionScheduleInfo *)scheduleInfo;
@end

@interface DIYCalendarCell : FSCalendarCell
@property (weak, nonatomic) UIImageView *circleImageView;
@property (weak, nonatomic) CAShapeLayer *selectionLayer;
@property (assign, nonatomic) SelectionType selectionType;
@end

NS_ASSUME_NONNULL_END
