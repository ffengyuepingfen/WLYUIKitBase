//
//  File.swift
//
//
//  Created by Laowang on 2023/11/29.
//

import Foundation
import OSLog

@available(iOS 14.0, *)
let logger = Logger(subsystem: "CICtecInternetApp", category: "debug")

public enum GCLogOption {
    case info, error, notice
}

public struct GCLog {
    
    public static func info(_ msg: Any...,
                            isWriteLog: Bool = false,
                            file: NSString = #file,
                            line: Int = #line,
                            column: Int = #column,
                            fn: String = #function) {
        log(msg, option: .info, isWriteLog: isWriteLog, file: file, line: line, column: column,fn: fn)
    }
    public static func error(_ msg: Any...,isWriteLog: Bool = false,
                             file: NSString = #file,
                             line: Int = #line,
                             column: Int = #column,
                             fn: String = #function) {
        log(msg, option: .error, isWriteLog: isWriteLog, file: file, line: line, column: column,fn: fn)
    }
    public static func notice(_ msg: Any...,isWriteLog: Bool = false,
                              file: NSString = #file,
                              line: Int = #line,
                              column: Int = #column,
                              fn: String = #function) {
        log(msg, option: .notice, isWriteLog: isWriteLog, file: file, line: line, column: column,fn: fn)
    }
    
    // MARK: - 自定义打印
    /// 自定义打印
    /// - Parameter msg: 打印的内容
    /// - Parameter file: 文件路径
    /// - Parameter line: 打印内容所在的 行
    /// - Parameter column: 打印内容所在的 列
    /// - Parameter fn: 打印内容的函数名
    public static func log(_ msg: Any...,
                           option: GCLogOption,
                           isWriteLog: Bool = false,
                           file: NSString = #file,
                           line: Int = #line,
                           column: Int = #column,
                           fn: String = #function) {
        
#if DEBUG
        var msgStr = ""
        for element in msg {
            msgStr += "\(element)\n"
        }
        let currentDate = Date.currentDate
        let prefix = """
             ---begin---------------☘️☘️☘️☘️☘️☘️☘️----------------
             当前时间：\(currentDate)
             当前文件完整的路径是：\(file)
             当前文件是：\(file.lastPathComponent)
             第 \(line) 行 第 \(column) 列 函数名：\(fn)
             打印内容如下：
             \(msgStr)
             ---end-----------------🍃🍃🍃🍃🍃🍃🍃----------------
            """
        
        if #available(iOS 14.0, *) {
            switch option {
            case .error:
                logger.error("\(prefix)")
            case .info:
                logger.info("\(prefix)")
            case .notice:
                logger.notice("\(prefix)")
            }
        } else {
            print(prefix)
        }
        guard isWriteLog else {
            return
        }
        // 将内容同步写到文件中去（Caches文件夹下）
        let cachePath = FileManager.CachesDirectory()
        let logURL = cachePath + "/log.txt"
        appendText(fileURL: URL(string: logURL)!, string: "\(prefix)", currentDate: "\(currentDate)")
        
        
        
#endif
        
    }
    
    // 在文件末尾追加新内容
    private static func appendText(fileURL: URL, string: String, currentDate: String) {
        do {
            // 如果文件不存在则新建一个
            FileManager.createFile(filePath: fileURL.path)
            let fileHandle = try FileHandle(forWritingTo: fileURL)
            let stringToWrite = "\n" + "\(currentDate)：" + string
            // 找到末尾位置并添加
            fileHandle.seekToEndOfFile()
            fileHandle.write(stringToWrite.data(using: String.Encoding.utf8)!)
            
        } catch let error as NSError {
            print("failed to append: \(error)")
        }
    }
}
