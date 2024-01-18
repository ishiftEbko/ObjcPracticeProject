//
//  NoticeTVCell.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/17/24.
//

#import "NoticeTVCell.h"

@interface NoticeTVCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation NoticeTVCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.text = @"제목입니다만?";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    NSString *todayStr = [formatter stringFromDate:[NSDate date]];
    self.dateLabel.text = todayStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)bindData:(DMNoticeListResult *)notice {
    self.titleLabel.text = notice.noticeTitle;
    self.dateLabel.text = notice.noticeDate;
}
@end
