//
//  YJFMDBManager.m
//
//  Created by Joye on 2017/9/4.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YJFMDBManager.h"

#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "YJUserModel.h"

// 这里的yjdatabase 请更换成自己的数据库名称
#define HDB_PATH [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"yjdatabase.sqlite"]

#define HDB_PATH_COPY [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"copy.yjdatabase.sqlite"]

#define HDB_PATH_INIT_TMP [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"tmp.init.yjdatabase.sqlite"]


static YJFMDBManager *_dbManager;
static FMDatabaseQueue *_dbQueue;


@implementation YJFMDBManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dbManager = [[YJFMDBManager alloc] init];
        
    });
    return _dbManager;
}

+ (FMDatabaseQueue *)dbQueue
{
    if (!_dbQueue) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:HDB_PATH_INIT_TMP];
    }
    return _dbQueue;
}

- (void)setupDBWithUserData:(NSArray *)dataArray
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:HDB_PATH_INIT_TMP error:nil];
    if (![fileManager fileExistsAtPath:HDB_PATH_INIT_TMP]) {
        // create db
        FMDatabaseQueue *queue = [YJFMDBManager dbQueue];
        [queue inDatabase:^(FMDatabase *db) {
            NSString *create_str = @"CREATE TABLE 'YOUR_DB_NAME' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'name' VARCHAR(100), 'address' VARCHAR(100))";
            BOOL response = [db executeUpdate:create_str];
            if (response) {
                NSLog(@"create_db success...");
            }else {
                NSLog(@"create_db failure...");
            }
        }];
    }else {
        FMDatabaseQueue *queue = [YJFMDBManager dbQueue];
        [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            // save datas
            for (YJUserModel *model in dataArray) {
                NSString *insert_str = @"insert into YOUR_DB_NAME (name, address) values(?, ?) ";
                
                BOOL response = [db executeUpdate:insert_str,model.name,model.address];
                if (response) {
                    NSLog(@"insert success...");
                }else {
                    NSLog(@"insert failure...");
                    *rollback = YES;
                    return ;
                }
            }
        }];
    }
    
    BOOL response = [fileManager moveItemAtPath:HDB_PATH toPath:HDB_PATH_COPY error:nil];
    NSLog(@"response is %d",response);
    
    if ([fileManager moveItemAtPath:HDB_PATH_INIT_TMP toPath:HDB_PATH error:nil] == NO)
    {
        [fileManager moveItemAtPath:HDB_PATH_COPY toPath:HDB_PATH error:nil];
    }
    else
    {
        [fileManager removeItemAtPath:HDB_PATH_COPY error:nil];
    }
}

- (void)getDataWithTimeStamp:(NSDate *)timeStamp callback:(void (^)(NSArray *data, NSDate *timeStamp))block
{
    FMDatabaseQueue * main_queue = [YJFMDBManager dbQueue];
    [main_queue inDatabase:^(FMDatabase *db)
     {
         NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
         
         NSString * getInfoSQL = @"select * from YOUR_DB_NAME";
         FMResultSet * rsPartInInfo = [db executeQuery:getInfoSQL];
         while ([rsPartInInfo next])
         {
             NSString * name = [rsPartInInfo stringForColumn:@"name"];
             NSString * address = [rsPartInInfo stringForColumn:@"address"];
             
             YJUserModel *model = [[YJUserModel alloc] init];
             model.name = name;
             model.address = address;
             [array addObject:model];
         }
         NSLog(@"array count is %ld",array.count);
         // 回调
         block(array, timeStamp);
     }];
}

- (void)deleteDataWithCallback:(void (^)(BOOL res))block
{
    FMDatabaseQueue * main_queue = [YJFMDBManager dbQueue];
    [main_queue inDatabase:^(FMDatabase *db) {
        NSString * deleteSQL = @"delete from YOUR_DB_NAME";
        BOOL deleteRes = [db executeUpdate:deleteSQL];
        
        if (deleteRes) {
            NSLog(@"deleteRes is success");
        }else{
            NSLog(@"deleteRes is fail");
        }
        // 回调
        block(deleteRes);
    }];
}


@end
