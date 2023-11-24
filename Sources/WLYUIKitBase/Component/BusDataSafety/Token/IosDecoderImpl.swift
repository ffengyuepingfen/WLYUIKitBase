//
//  IosDecoderImpl.swift
//  加密哭
//
//  Created by 王相博 on 2018/12/19.
//  Copyright © 2018 王相博. All rights reserved.
//

import Foundation

class IosDecoderImpl {
    
    func checkSuccess(deviceId:String,checkCode:String,versionCode:String) -> Bool {
//        //准备拆解随机数
//        int random = Integer.parseInt(checkCode.substring(checkCode.length() - 1, checkCode.length()));
//        //拆解加密方式，备用
//        int timeLength = Integer.parseInt(checkCode.substring(checkCode.length() - 3, checkCode.length() - 1));
//        String timeEncode = checkCode.substring(0, checkCode.length() - 3);
//        //转换成10进制
//        timeEncode = String.valueOf(Long.parseLong(timeEncode, 16));
//        //反算时间
//        long time = ProofCore.decodeTime(timeEncode, deviceId, random);
//        return isFailureTime(time * 1000);
        return false
    }
//    public boolean checkSuccess(String deviceId, String checkCode, String versionCode) {
//    try {
//    //准备拆解随机数
//    int random = Integer.parseInt(checkCode.substring(checkCode.length() - 1, checkCode.length()));
//    //拆解加密方式，备用
//    int timeLength = Integer.parseInt(checkCode.substring(checkCode.length() - 3, checkCode.length() - 1));
//    String timeEncode = checkCode.substring(0, checkCode.length() - 3);
//    //转换成10进制
//    timeEncode = String.valueOf(Long.parseLong(timeEncode, 16));
//    //反算时间
//    long time = ProofCore.decodeTime(timeEncode, deviceId, random);
//    return isFailureTime(time * 1000);
//    } catch (Exception e) {
//    return false;
//    }
//    }
}
