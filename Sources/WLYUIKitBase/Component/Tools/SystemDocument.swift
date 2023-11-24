//
//  SystemDocument.swift
//  SwiftDemo
//
//  Created by 中行讯 on 2018/7/6.
//  Copyright © 2018年 Beijing CIC Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 得到当前APP Documents目录的地址
///
/// - Returns: 当前APP的Documents地址
func documentsDirectory() -> URL {
    ///.UserDomainMask表示在当前用户的Home目录中查找
    ///.DocumentDirectory表示我们要获取Document目录的URL
    let urls = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)
    ///.尽管URLsForDirectory会返回一个NSURL数组，但是，由于iOS App都运行在自己的沙箱里，因此，Document目录肯定存在并且也只有一个，我们直接返回url[0]就可以了。
    return urls[0]
}

/// 当我们要在Document目录里创建文件的时候，我们可以用下面的代码生成一个文件的NSURL
///
/// - Parameter fileName: 文字名称
/// - Returns: 文件地址
func fileUrl(fileName: String) -> URL {
    let documentUrl = documentsDirectory().appendingPathComponent(fileName)
    print("\(documentUrl)")
    return documentUrl
}

/// Description:存储对象到plist文件
///
/// - Parameters:
///   - episodeListItems: episodeListItems description:需要存储的对象
///   - key: 对象对应的key值
func saveEpisodeListItems(episodeListItems: [EpisodeListItem],key: String) {
    // 1. Create a concrete archiver
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWith: data)
    
    // 2. Serialize object into archiver
    archiver.encode(episodeListItems, forKey: key)
    archiver.finishEncoding()
    
    // 3. Create the file
    data.write(to: fileUrl(fileName: "EpisodeList.plist"), atomically: true)
}

func getEpisodeListItemData() -> [EpisodeListItem] {
    var items = [EpisodeListItem]()
    for i in 0..<10 {
        let e = EpisodeListItem()
        e.title = "Episode \(i)"
        e.finished = Bool(i % 2 == 0) ? true : false
        items.append(e)
    }
    return items
}

class EpisodeListItem : NSObject, NSCoding {
    var title = ""
    var finished = false
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(finished, forKey: "Finished")
    }
    //    我们要添加两个init方法
    // 虽然它们没什么实际用途，为了让编译器通过编译通过，我们必须这样定义它们
    required init?(coder aDecoder: NSCoder) {
        
        title = aDecoder.decodeObject(forKey: "Title") as! String
        finished = aDecoder.decodeBool(forKey: "Finished")
        super.init()
    }
    
    override init() {
        super.init()
    }

}

class FileTools {
    
    // 获取文件夹下的所有文件
    static func loadFolders() -> [String] {
        do{
            let path = Bundle.main.bundlePath
            var folds = try FileManager.default.contentsOfDirectory(atPath: path)
            folds = folds.map { $0.components(separatedBy: ".").first }.compactMap({$0}).removeDuplicates().sorted()
            print(folds)
            return folds
        }catch{
            return ["啥也没有"]
        }
    }
}

public extension Array where Element: Hashable {

    /// 去除数组中重复的元素，如果有重复的，将优先保留前面的一个。
    /// - Returns: 去重后的新数组
    func removeDuplicates() -> [Element] {
        var newAray: [Element] = []
        var set = Set<Element>()
        for item in self {
            if !set.contains(item) {
                newAray.append(item)
                set.insert(item)
            }
        }
        return newAray
    }
}
