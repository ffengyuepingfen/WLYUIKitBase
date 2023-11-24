//
//  AFileManager.h
//  DemoPlus
//
//  Created by 王力 on 15/8/16.
//  Copyright (c) 2015年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFileManager : NSObject
//判断文件是否存在
+(BOOL)isFileExist: (NSString *)fileName;

+ (NSString *) getFilePathWithFileName:(NSString *)fileName FilePath:(NSString *) extrafilePath;

+ (NSMutableDictionary*) readPlistFileWithFileName:(NSString *)fileName FilePath:(NSString *) extrafilePath;
+ (BOOL) writePlistFile:(NSDictionary *)dict FileName:(NSString *)fileName FilePath:(NSString *) extrafilePath;

+ (BOOL) writeStringFile:(NSString *) string FileName:(NSString *)fileName FilePath:(NSString *) extrafilePath;


+ (NSMutableArray*) readPlistFile:(NSString *)fileName FilePath:(NSString *) extrafilePath;
+ (BOOL) writePlistFiles:(NSArray *)array FileName:(NSString *)fileName FilePath:(NSString *) extrafilePath;



+ (BOOL)isFileExists: (NSString *)path;

+ (long long)fileSizeWithPath: (NSString *)path;

+ (void)moveFile:(NSString *)fromPath toPath: (NSString *)toPath;


+ (void)removeFileAtPath: (NSString *)path;

@end
