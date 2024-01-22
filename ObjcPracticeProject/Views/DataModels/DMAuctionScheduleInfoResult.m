//
//  DMAuctionScheduleInfoResult.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/22/24.
//

#import "DMAuctionScheduleInfoResult.h"

NSString *const kDMAuctionScheduleInfoResultDisplayDate = @"displayDate";

@interface DMAuctionScheduleInfoResult()
@end

@implementation DMAuctionScheduleInfoResult
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (![dictionary[kDMAuctionScheduleInfoResultDisplayDate] isKindOfClass:[NSNull class]]) {
        self.displayDate = dictionary[kDMAuctionScheduleInfoResultDisplayDate];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (self.displayDate != nil) {
        dictionary[kDMAuctionScheduleInfoResultDisplayDate] = self.displayDate;
    }
    return dictionary;
}
@end
