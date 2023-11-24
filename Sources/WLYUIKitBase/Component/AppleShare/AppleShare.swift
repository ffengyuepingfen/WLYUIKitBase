//
//  AppleShare.swift
//  Alamofire
//
//  Created by wangxiangbo on 2020/7/3.
//

import UIKit

public class AppleShare {
    
    public static func share(data:(title:String,url: String,image: UIImage,imageURL:String,context: String),callback:((_ message:String)->Void)?) {
        //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
        let activityItems = [data.title,
                             data.imageURL == "" ? data.image : data.imageURL,
                             URL(string: data.url)!] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        //不出现在活动项目
        activityVC.excludedActivityTypes = [.print,.saveToCameraRoll,.assignToContact]
        k_keyWindow?.rootViewController?.present(activityVC, animated: true, completion: nil)
        // 分享之后的回调
        activityVC.completionWithItemsHandler = { (activityType,completed,returnedItems,activityError) in
            if let callback = callback {
                if completed {
                    if activityType == UIActivity.ActivityType.copyToPasteboard {
                        callback("复制成功")
                    }else{
                        callback("分享成功")
                    }
                }else{
                    callback("操作失败")
                }
            }
        }
    }
}
