//
//  DecodeBusSeq.swift
//  加密哭
//
//  Created by 王相博 on 2018/12/18.
//  Copyright © 2018 王相博. All rights reserved.
//

import Foundation

public class DecodeBusSeq {
    
    /// Description seq 不能为空
    ///
    /// - Parameter seq: seq description
    /// - Returns: return value description
    static public func decode(seq:String) -> Int {
        
        if seq == "" || seq == "0" {
            return 0
        }
        
        var newseq = seq
        let dateNum = TimeUtils.getTimeNum()
        let transfer = dateNum % TimeUtils.getWeekNum() + 1
        for _ in 0..<transfer {
//            print(i)
            for (index,item) in newseq.enumerated() {
                newseq.swapAtDe(index: index, c: Character(getChar(c: String(item))))
            }
        }
        
        let random = NSInteger(String(newseq.last!))
        var result = NSInteger(String(newseq.substring(to: seq.count - 1)))!
        result -= dateNum
        newseq = "\(result)"
        let startIndex = newseq.index(newseq.startIndex, offsetBy: random!)
        let endIndex = newseq.index(newseq.startIndex, offsetBy: random! + 3)
        
        return NSInteger(newseq[startIndex..<endIndex])!
        
    }
    
    static func getChar(c:String) -> String {
        switch c {
        case "0":
            return "4"
        case "1":
            return "9"
        case "2":
            return "6"
        case "3":
            return "8"
        case "4":
            return "0"
        case "5":
            return "1"
        case "6":
            return "3"
        case "7":
            return "5"
        case "8":
            return "2"
        case "9":
            return "7"
        default:
            return c
        }
    }
}
