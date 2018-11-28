//
//  ED_DBManager.m
//  MyCode
//
//  Created by 崎崎石 on 2018/2/26.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import "ED_DBManager.h"
#import "FMDB.h"
@interface ED_DBManager ()
@property (nonatomic , strong) FMDatabase *database;

@property(nonatomic,readonly) dispatch_queue_t queue;

@end

@implementation ED_DBManager

@synthesize queue = _queue;

+ (instancetype)shareInstance {
    static ED_DBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ED_DBManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
         NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"code.sqlite"];
        _database = [FMDatabase databaseWithPath:path];
        if (_database.open) {
            NSLog(@"success");
            [self createUserTable];
        }else{
            NSLog(@"fail");
        }
        _queue = dispatch_queue_create("userMap", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)createUserTable {
    NSString *sql = @"CREATE TABLE IF NOT EXISTS userMap(key text NOT NULL , value blob)";
    BOOL reslut = [_database executeUpdate:sql];
    if (reslut) {
        NSLog(@"table success");
    }else{
        NSLog(@"table fail");
    }
    
}

- (void)saveObject:(id)object withKey:(NSString *)key {
    dispatch_barrier_sync(self.queue, ^{
        [_database open];
        [_database executeUpdate:@"DELETE FROM userMap WHERE key=?",key];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
        BOOL reslut = [_database executeUpdate:@"INSERT INTO userMap(key,value) VALUES(?,?)",key,data];
        if (reslut) {
            NSLog(@"save success");
        }else{
            NSLog(@"save fail");
        }
        [_database close];
    });
}

- (void)removeObjectForKey:(NSString *)key {
    
    dispatch_barrier_async(self.queue, ^{
       
        [_database open];
        BOOL result = [_database executeUpdate:@"DELETE FROM userMap WHERE key=?",key];
        if (result) {
            NSLog(@"remove success");
        }else{
            NSLog(@"remove faile");
        }
        [_database close];
        
    });
}

- (id)getObjectForKey:(NSString *)key {
    
    __block id object = nil;
    dispatch_sync(self.queue, ^{
        
        [_database open];
        NSData *data = nil;
        FMResultSet *set = [_database executeQuery:@"SELECT * FROM userMap WHERE key=?",key];
        while ([set next]) {
            data = [set dataForColumn:@"value"];
        }
        [_database close];
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    });
    
    return object;
    
}



@end
