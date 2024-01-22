//
//  NoticeView.h
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/17/24.
//

#import <UIKit/UIKit.h>
#import "NoticeTVCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NoticeViewDelegate
@required
-(void)moveToNoticeWebView:(WebViewController *)webVC;
@end

@interface NoticeView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) id<NoticeViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
