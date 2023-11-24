//
//  ProofCore.swift
//  加密哭
//
//  Created by 王相博 on 2018/12/18.
//  Copyright © 2018 王相博. All rights reserved.
//

import Foundation

/**
 * 失效时间（毫秒单位）
 */
let FAILURE_TIME = 30 * 60 * 1000


class ProofCore {
    
    static let WEIGHT = ["7", "4", "1", "5", "2", "9", "8", "3", "0", "6"]
    
    static func getEncodeChar(c:String) -> String {
        switch c {
        case "0":
            return WEIGHT[0]
        case "1":
            return WEIGHT[1]
        case "2":
            return WEIGHT[2]
        case "3":
            return WEIGHT[3]
        case "4":
            return WEIGHT[4]
        case "5":
            return WEIGHT[5]
        case "6":
            return WEIGHT[6]
        case "7":
            return WEIGHT[7]
        case "8":
            return WEIGHT[8]
        case "9":
            return WEIGHT[9]
        default:
            return c
        }
    }
    
    static func getDecodeChar(c:String) -> String {
        switch c {
        case "0":
            return "8"
        case "1":
            return "2"
        case "2":
            return "4"
        case "3":
            return "7"
        case "4":
            return "1"
        case "5":
            return "3"
        case "6":
            return "9"
        case "7":
            return "0"
        case "8":
            return "6"
        case "9":
            return "5"
        default:
            return c
        }
    }
    
    /**
     * 对时间进行转换，秒级别时间戳
     *
     * @param time
     * @return
     */
    static func encodeTime(time:String,deviceId:String,random:NSInteger) -> String {
        let encodeDeviceId = abs(encode(dat: deviceId))
        let transfer:Int32 = Int32(encodeDeviceId / Int32(random) % Int32(TimeUtils.getWeekNum()) + 1)
        var temp = time
        for _ in 0..<transfer {
            for (index,item) in temp.enumerated() {
                temp.swapAtDe(index: index, c: Character(getEncodeChar(c: String(item))))
            }
        }
        return String(Int(temp)!)
    }
    
    static func encode(dat:String) -> Int32 {
        var TxCRC16:Int32 = 0
        var num = 0
        for item in dat.unicodeScalars {
            num = Int(abs(Int32(item.value)))
            TxCRC16 = (TxCRC16 << 8) ^ CRCTable[((Int(TxCRC16) >> 8) ^ num) & 0xFF]
        }
        if TxCRC16 == 0 {
            TxCRC16 = 0xFFFF
        }
        return TxCRC16
    }
    /**
     * 解码时间
     *
     * @param token    加密后的token时间
     * @param deviceId 设备号
     * @param random   随机数
     * @return 解密后的时间
     */
    static func decodeTime(token:String,deviceId:String,random:NSInteger) -> NSInteger {
        let encodeDeviceId = encode(dat: deviceId)
        let transfer = encodeDeviceId / Int32(random) % Int32(TimeUtils.getWeekNum()) + 1
        var temp = token
        for _ in 0..<transfer {
            for (index,item) in token.enumerated() {
                temp.swapAtDe(index: index, c: Character(getDecodeChar(c: String(item))))
            }
        }
        return NSInteger(temp)!
    }
    
    static let CRCTable:[Int32] = [
        0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50A5, 0x60C6, 0xC301,
        0x8108, 0x9129, 0xA14A, 0xB16B, 0xC18C, 0xD1AD, 0xE1CE, 0xF1EF,
        0x1231, 0x0210, 0x3273, 0x2252, 0x52B5, 0x4294, 0x72F7, 0x62D6,
        0x9339, 0x8318, 0xB37B, 0xA35A, 0xD3BD, 0xC39C, 0xF3FF, 0xE3DE,
        0x2462, 0x3443, 0x0420, 0x1401, 0x64E6, 0x74C7, 0x44A4, 0x5485,
        0xA56A, 0xB54B, 0x8528, 0x9509, 0xE5EE, 0xF5CF, 0xC5AC, 0xD58D,
        0x3653, 0x2672, 0x1611, 0x0630, 0x76D7, 0x66F6, 0x5695, 0x46B4,
        0xB75B, 0xA77A, 0x9719, 0x8738, 0xF7DF, 0xE7FE, 0xD79D, 0xC7BC,
        0x48C4, 0x58E5, 0x6886, 0x78A7, 0x0840, 0x1861, 0x2802, 0x3823,
        0xC9CC, 0xD9ED, 0xE98E, 0xF9AF, 0x8948, 0x9969, 0xA90A, 0xB92B,
        0x5AF5, 0x4AD4, 0x7AB7, 0x8A96, 0x1A71, 0x0A50, 0x3A33, 0x2A12,
        0xDBFD, 0xCBDC, 0xFBBF, 0xEB9E, 0x9B79, 0x8B58, 0xBB3B, 0xAB1A,
        0x6CA6, 0x7C87, 0x4CE4, 0x5CC5, 0x2C22, 0x3C03, 0x0C60, 0x1C41,
        0xEDAE, 0xFD8F, 0xCDEC, 0xDDCD, 0xAD2A, 0xBD0B, 0x8D68, 0x9D49,
        0x7E97, 0x6EB6, 0x5ED5, 0x4EF4, 0x3E13, 0x2E32, 0x1E51, 0x0E70,
        0xFF9F, 0xEFBE, 0xDFDD, 0xCFFC, 0xBF1B, 0xAF3A, 0x9F59, 0x8F78,
        0x9188, 0x81A9, 0xB1CA, 0xA1EB, 0xD10C, 0xC12D, 0xF14E, 0xE16F,
        0x1080, 0x00A1, 0x30C2, 0x20E3, 0x5004, 0x4025, 0x7046, 0x6067,
        0x83B9, 0x9398, 0xA3FB, 0xB3DA, 0xC33D, 0xD31C, 0xE37F, 0xF35E,
        0x02B1, 0x1290, 0x22F3, 0x32D2, 0x4235, 0x5214, 0x6277, 0x7256,
        0xB5EA, 0xA5CB, 0x95A8, 0x8589, 0xF56E, 0xE54F, 0xD52C, 0xC50D,
        0x34E2, 0x24C3, 0x14A0, 0x0481, 0x7466, 0x6447, 0x5424, 0x4405,
        0xA7DB, 0xB7FA, 0x8799, 0x97B8, 0xE75F, 0xF77E, 0xC71D, 0xD73C,
        0x26D3, 0x76F2, 0x0691, 0x16B0, 0x6657, 0x7676, 0x4615, 0x5634,
        0xD94C, 0xC96D, 0xF90E, 0xE92F, 0x99C8, 0x89E9, 0xB98A, 0xA9AB,
        0x5844, 0x4865, 0x7806, 0x6827, 0x18C0, 0x08E1, 0x3882, 0x28A3,
        0xCB7D, 0xDB5C, 0xEB3F, 0xFB1E, 0x8BF9, 0x9BD8, 0xABBB, 0xBB9A,
        0x4A75, 0x5A54, 0x6A37, 0x7A16, 0x0AF1, 0x1AD0, 0x2AB3, 0x3A92,
        0xFD2E, 0xED0F, 0xDD6C, 0xCD4D, 0xBDAA, 0xAD8B, 0x9DE8, 0x8DC9,
        0x7C26, 0x6C07, 0x5C64, 0x4C45, 0x3CA2, 0x2C83, 0x1CE0, 0x0CC1,
        0xEF1F, 0xFF3E, 0xCF5D, 0xDF7C, 0xAF9B, 0xBFBA, 0x8FD9, 0x9FF8,
        0x6E17, 0x7E36, 0x4E55, 0x5E74, 0x2E93, 0x3EB2, 0x0ED1, 0x1EF0
    ]
    
    
    /**
     * 进行位数的换算
     *
     * @param dat
     * @return
     */
    static func encodeString(dat:String,random:NSInteger) -> String {
        let code = encode(dat: dat)
        let transfer = TimeUtils.getTimeNum() / random % TimeUtils.getWeekNum() + 1
        var temp = "\(code)"
        for _ in 0..<transfer {
            for (index,item) in temp.enumerated() {
                temp.swapAtDe(index: index, c: Character(getEncodeChar(c: String(item))))
            }
        }
        return temp
    }
}
