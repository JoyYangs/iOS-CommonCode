//
//  YJFMDBManager.h
//  07-datePicker
//
//  Created by Joye on 2017/9/4.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJFMDBManager : NSObject

+ (instancetype)sharedManager;
// save
- (void)setupDBWithUserData:(NSArray *)dataArray;
// get
- (void)getDataWithTimeStamp:(NSDate *)timeStamp callback:(void (^)(NSArray *data, NSDate *timeStamp))block;
// delete
- (void)deleteDataWithCallback:(void (^)(BOOL res))block;

@end
