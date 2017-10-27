//
//  Singleton.m
//  toone
//
//  Created by 景晓峰 on 2017/10/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "Singleton.h"

#define FileManager [NSFileManager defaultManager]
#define SandboxPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) lastObject]
#define DBPath [SandboxPath stringByAppendingPathComponent:@"orders.sqlite"]

@implementation Singleton

static  Singleton *_instance;

//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    @synchronized (self)
//    {
//        if (_instance == nil)
//        {
//            _instance = [super allocWithZone:zone];
//        }
//        return _instance;
//    }
//}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil)
        {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+ (instancetype)shareSingleton
{
    return [[self alloc] init];
}


- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

//检查数据库文件是否存在
- (BOOL)isExistTheDatabaseFile
{
    if ([FileManager fileExistsAtPath:DBPath])
    {
        NSLog(@"文件已存在");
        return YES;
    }
    else
    {
        NSLog(@"error:文件不存在");
        return NO;
    }
}

- (BOOL)copyDatabaseFileToSandboxPath
{
    [FileManager copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"orders" ofType:@".sqlite"] toPath:DBPath error:nil];
    if ([self isExistTheDatabaseFile])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)getDatabaseFile
{
    if ([self isExistTheDatabaseFile] == NO)
    {
        [self copyDatabaseFileToSandboxPath];
    }
}

- (BOOL)insertData:(Car_ScanModel *)model
{
    [self getDatabaseFile];
    FMDatabase *fmdb = [FMDatabase databaseWithPath:DBPath];
    NSString *str = fmdb.databasePath;
    
    NSArray *tempArr = [self queryDataWithKeyStr:@"JZLBH" valueStr:model.JZLBH];
    if (tempArr.count > 0)
    {
        //该单子已存在,删除
        [self deleteData:model];
    }
    if ([fmdb open])
    {
        if ([fmdb executeUpdate:@"INSERT INTO orderTable (orderStatus,outsideStatus,JZLBH,BHZMC,GCMC,SGBW,FCDBH,XLWZ,BHZBH,loation,QDDJ,TLD,SJFL,BCFL,CH,FCR,FCSJ,BZ,SCRQ,PHBBH,LJCC,SJ,QSSJ,QSR,QS_img,JS_img,QSFL,JSYY,JSYYLX,JSBZ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.orderStatus,model.outsideStatus,model.JZLBH,model.BHZMC,model.GCMC,model.SGBW,model.FCDBH,model.XLWZ,model.BHZBH,model.loation,model.QDDJ,model.TLD,model.SJFL,model.BCFL,model.CH,model.FCR,model.FCSJ,model.BZ,model.SCRQ,model.PHBBH,model.LJCC,model.SJ,model.QSSJ,model.QSR,model.QS_img,model.JS_img,model.QSFL,model.JSYY,model.JSYYLX,model.JSBZ])
        {
            NSLog(@"新增数据成功");
            [fmdb close];
            return YES;
        }
        else
        {
            NSLog(@"error:新增数据失败");
            [fmdb close];
            return NO;
        }
        
    }
    else
    {
        NSLog(@"error:打开数据库失败");
        return NO;
    }
}

- (BOOL)deleteData:(Car_ScanModel *)model
{
    [self getDatabaseFile];
    FMDatabase *fmdb = [FMDatabase databaseWithPath:DBPath];
    if ([fmdb open])
    {
        if ([fmdb executeUpdate:@"delete from orderTable where JZLBH = ?",model.JZLBH])
        {
            NSLog(@"删除数据成功");
            [fmdb close];
            return YES;
        }
        else
        {
            NSLog(@"error:删除数据失败");
            [fmdb close];
            return NO;
        }
        
    }
    else
    {
        NSLog(@"error:打开数据库失败");
        return NO;
    }
}

- (NSArray *)queryData
{
    [self getDatabaseFile];
    NSMutableArray *dataArr = [NSMutableArray array];
    FMDatabase *fmdb = [FMDatabase databaseWithPath:DBPath];

    if ([fmdb open])
    {
        FMResultSet *resultSet = [fmdb executeQuery:@"select * from orderTable"];
        while ([resultSet next])
        {
            Car_ScanModel *model = [[Car_ScanModel alloc] init];
            model.orderStatus = [resultSet stringForColumn:@"orderStatus"];
            model.outsideStatus = [resultSet stringForColumn:@"outsideStatus"];
            model.JZLBH = [resultSet stringForColumn:@"JZLBH"];
            model.BHZMC = [resultSet stringForColumn:@"BHZMC"];
            model.GCMC = [resultSet stringForColumn:@"GCMC"];
            model.SGBW = [resultSet stringForColumn:@"SGBW"];
            model.FCDBH = [resultSet stringForColumn:@"FCDBH"];
            model.XLWZ = [resultSet stringForColumn:@"XLWZ"];
            model.BHZBH = [resultSet stringForColumn:@"BHZBH"];
            model.loation = [resultSet stringForColumn:@"loation"];
            model.QDDJ = [resultSet stringForColumn:@"QDDJ"];
            model.TLD = [resultSet stringForColumn:@"TLD"];
            model.SJFL = [resultSet stringForColumn:@"SJFL"];
            model.BCFL = [resultSet stringForColumn:@"BCFL"];
            model.CH = [resultSet stringForColumn:@"CH"];
            model.FCR = [resultSet stringForColumn:@"FCR"];
            model.FCSJ = [resultSet stringForColumn:@"FCSJ"];
            model.BZ = [resultSet stringForColumn:@"BZ"];
            model.SCRQ = [resultSet stringForColumn:@"SCRQ"];
            model.PHBBH = [resultSet stringForColumn:@"PHBBH"];
            model.LJCC = [resultSet stringForColumn:@"LJCC"];
            model.SJ = [resultSet stringForColumn:@"SJ"];
            model.QSSJ = [resultSet stringForColumn:@"QSSJ"];
            model.QSR = [resultSet stringForColumn:@"QSR"];
            model.QS_img = [resultSet stringForColumn:@"QS_img"];
            model.JS_img = [resultSet stringForColumn:@"JS_img"];
            model.QSFL = [resultSet stringForColumn:@"QSFL"];
            model.JSYY = [resultSet stringForColumn:@"JSYY"];
            model.JSYYLX = [resultSet stringForColumn:@"JSYYLX"];
            model.JSBZ = [resultSet stringForColumn:@"JSBZ"];
            
            [dataArr addObject:model];
        }
        [fmdb close];
        return dataArr;
    }
    else
    {
        NSLog(@"error:打开数据库失败");
        return nil;
    }
}

- (NSArray *)queryDataWithKeyStr:(NSString *)keyStr valueStr:(NSString *)valueStr
{
    [self getDatabaseFile];
    NSMutableArray *dataArr = [NSMutableArray array];
    FMDatabase *fmdb = [FMDatabase databaseWithPath:DBPath];
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from orderTable where %@ like %@",keyStr,valueStr];
    
    if ([fmdb open])
    {
        FMResultSet *resultSet = [fmdb executeQuery:sqlStr];
        
        while ([resultSet next])
        {
            Car_ScanModel *model = [[Car_ScanModel alloc] init];
            model.orderStatus = [resultSet stringForColumn:@"orderStatus"];
            model.outsideStatus = [resultSet stringForColumn:@"outsideStatus"];
            model.JZLBH = [resultSet stringForColumn:@"JZLBH"];
            model.BHZMC = [resultSet stringForColumn:@"BHZMC"];
            model.GCMC = [resultSet stringForColumn:@"GCMC"];
            model.SGBW = [resultSet stringForColumn:@"SGBW"];
            model.FCDBH = [resultSet stringForColumn:@"FCDBH"];
            model.XLWZ = [resultSet stringForColumn:@"XLWZ"];
            model.BHZBH = [resultSet stringForColumn:@"BHZBH"];
            model.loation = [resultSet stringForColumn:@"loation"];
            model.QDDJ = [resultSet stringForColumn:@"QDDJ"];
            model.TLD = [resultSet stringForColumn:@"TLD"];
            model.SJFL = [resultSet stringForColumn:@"SJFL"];
            model.BCFL = [resultSet stringForColumn:@"BCFL"];
            model.CH = [resultSet stringForColumn:@"CH"];
            model.FCR = [resultSet stringForColumn:@"FCR"];
            model.FCSJ = [resultSet stringForColumn:@"FCSJ"];
            model.BZ = [resultSet stringForColumn:@"BZ"];
            model.SCRQ = [resultSet stringForColumn:@"SCRQ"];
            model.PHBBH = [resultSet stringForColumn:@"PHBBH"];
            model.LJCC = [resultSet stringForColumn:@"LJCC"];
            model.SJ = [resultSet stringForColumn:@"SJ"];
            model.QSSJ = [resultSet stringForColumn:@"QSSJ"];
            model.QSR = [resultSet stringForColumn:@"QSR"];
            model.QS_img = [resultSet stringForColumn:@"QS_img"];
            model.JS_img = [resultSet stringForColumn:@"JS_img"];
            model.QSFL = [resultSet stringForColumn:@"QSFL"];
            model.JSYY = [resultSet stringForColumn:@"JSYY"];
            model.JSYYLX = [resultSet stringForColumn:@"JSYYLX"];
            model.JSBZ = [resultSet stringForColumn:@"JSBZ"];
            
            [dataArr addObject:model];
        }
        [fmdb close];
        return dataArr;
    }
    else
    {
        NSLog(@"error:打开数据库失败");
        return nil;
    }
}



@end
