//
//  File.swift
//  
//
//  Created by Laowang on 2024/1/19.
//

import Foundation


//@implementation AFileManager
//// Check the file directory
//+(BOOL)isFileExist: (NSString *)fileName
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSString *filepath = [path stringByAppendingPathComponent: fileName];
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    BOOL result = [fileManager fileExistsAtPath: filepath];
//    return result;
//}
//
//+ (NSString *) getFilePathWithFileName:(NSString *)fileName FilePath:(NSString *) extrafilePath
//{
//    [AFileManager createDirectortyAtPath:extrafilePath];
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *subPath = nil;
//    subPath = [NSString stringWithFormat:@"%@/%@.plist",extrafilePath,fileName];
//    return [docPath stringByAppendingPathComponent:subPath];
//}
//
//+ (void) createDirectortyAtPath:(NSString *) extrafilePath
//{
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@", extrafilePath]];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if (![AFileManager isFileExist:path]) {
//        NSError *error = nil;
//        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
//        
//    }
//}
//
//+ (NSMutableDictionary*) readPlistFileWithFileName:(NSString *)fileName FilePath:(NSString *) extrafilePath{
//    
//    NSString *filePath = [AFileManager getFilePathWithFileName:fileName FilePath:extrafilePath];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
//    return dict;
//}
//
//+ (BOOL) writePlistFile:(NSDictionary *)dict FileName:(NSString *)fileName FilePath:(NSString *) extrafilePath
//{
//    NSString *filePath = [AFileManager getFilePathWithFileName:fileName FilePath:extrafilePath];
//    return [dict writeToFile:filePath atomically:NO ];
//}
//
//+ (BOOL) writeStringFile:(NSString *) string FileName:(NSString *)fileName FilePath:(NSString *) extrafilePath
//{
//    NSString *filePath = [AFileManager getFilePathWithFileName:fileName FilePath:extrafilePath];
//    return [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:Nil];
//}
//
//
//
//+ (NSMutableArray*) readPlistFile:(NSString *)fileName FilePath:(NSString *) extrafilePath{
//    
//    NSString *filePath = [AFileManager getFilePathWithFileName:fileName FilePath:extrafilePath];
//    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:filePath];
//    return array;
//    
//}
//+ (BOOL) writePlistFiles:(NSArray *)array FileName:(NSString *)fileName FilePath:(NSString *) extrafilePath{
//    
//    [AFileManager createDirectortyAtPath:extrafilePath];
//    NSString *filePath = [AFileManager getFilePathWithFileName:fileName FilePath:extrafilePath];
//    return [array writeToFile:filePath atomically:YES];
//}
//
//
//+ (BOOL)isFileExists: (NSString *)path {
//    
//    return [[NSFileManager defaultManager] fileExistsAtPath:path];
//    
//}
//
//
//+ (long long)fileSizeWithPath: (NSString *)path {
//    
//    if (![self isFileExists:path]) {
//        return 0;
//    }
//    
//    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
//    
//    long long size = [fileInfo[NSFileSize] longLongValue];
//    
//    return size;
//    
//    
//}
//
//+ (void)moveFile:(NSString *)fromPath toPath: (NSString *)toPath {
//    
//    if (![self isFileExists:fromPath]) {
//        return;
//    }
//    
//    [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
//    
//    
//}
//
//+ (void)removeFileAtPath: (NSString *)path {
//    
//    if (![self isFileExists:path]) {
//        return;
//    }
//    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
//    
//}
