//
//  DMAuctionScheduleInfo.m
//  ObjcPracticeProject
//
//  Created by ishiftEbko on 1/22/24.
//

#import "DMAuctionScheduleInfo.h"

NSString *const kDMAuctionScheduleInfoStatus = @"status";
NSString *const kDMAuctionScheduleInfoMessage = @"message";
NSString *const kDMAuctionScheduleInfoRecordCount = @"recordCount";
NSString *const kDMAuctionScheduleInfoResult = @"result";

@interface DMAuctionScheduleInfo ()
@end

@implementation DMAuctionScheduleInfo
- (nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary {
    self = [super init];
    if (![dictionary[kDMAuctionScheduleInfoStatus] isKindOfClass:[NSNull class]]) {
        self.status = dictionary[kDMAuctionScheduleInfoStatus];
    }
    if (![dictionary[kDMAuctionScheduleInfoMessage] isKindOfClass:[NSNull class]]) {
        self.message = dictionary[kDMAuctionScheduleInfoMessage];
    }
    if (![dictionary[kDMAuctionScheduleInfoRecordCount] isKindOfClass:[NSNull class]]) {
        self.recordCount = dictionary[kDMAuctionScheduleInfoRecordCount];
    }
    if (dictionary[kDMAuctionScheduleInfoResult] != nil && [dictionary[kDMAuctionScheduleInfoResult] isKindOfClass:[NSArray class]]) {
        NSArray *resultDictionaries = dictionary[kDMAuctionScheduleInfoResult];
        NSMutableArray *resultItems = [NSMutableArray array];
        for (NSDictionary *resultDictionary in resultDictionaries) {
            DMAuctionScheduleInfoResult *resultItem = [[DMAuctionScheduleInfoResult alloc] initWithDictionary:resultDictionary];
            [resultItems addObject:resultItem];
        }
        self.result = resultItems;
    }
    return self;
}

- (nonnull NSDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.status != nil) {
        dictionary[kDMAuctionScheduleInfoStatus] = self.status;
    }
    if (self.message != nil) {
        dictionary[kDMAuctionScheduleInfoMessage] = self.message;
    }
    if (self.recordCount != nil) {
        dictionary[kDMAuctionScheduleInfoRecordCount] = self.recordCount;
    }
    if (self.result != nil) {
        NSMutableArray *dictionaryElements = [NSMutableArray array];
        for (DMAuctionScheduleInfoResult *resultElement in self.result) {
            [dictionaryElements addObject:[resultElement toDictionary]];
        }
        dictionary[kDMAuctionScheduleInfoResult] = dictionaryElements;
    }
    return dictionary;
}

@end
