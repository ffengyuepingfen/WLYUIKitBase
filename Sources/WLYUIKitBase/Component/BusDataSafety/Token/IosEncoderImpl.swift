//
//  IosEncoderImpl.swift
//  加密哭
//
//  Created by 王相博 on 2018/12/19.
//  Copyright © 2018 王相博. All rights reserved.
//

import Foundation

public class IosEncoderImpl {
    /**
     * 生成一个校验码
     *
     * @param deviceId 设备号
     * @return 返回校验码
     */
    static public func encode(deviceId:String) -> String {
        let random = RandomUtils.getRandomTwoToNine()
        let time = ProofCore.encodeTime(time: TimeUtils.getTimeDefault(), deviceId: deviceId, random: random)
        //拼接时间，第一位是随机数，第二位是时间转换后的长度，后边是时间
        let sb = time + "01" + "\(random)"
        return sb
    }
}
