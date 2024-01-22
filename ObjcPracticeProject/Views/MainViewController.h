//
//  MainViewController.h
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/8/24.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "NoticeView.h"
#import "CalendarView.h"

//MARK: collectionView Cell

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController<UINavigationBarDelegate, NoticeViewDelegate, CalenderViewDelegate>

@end

NS_ASSUME_NONNULL_END
