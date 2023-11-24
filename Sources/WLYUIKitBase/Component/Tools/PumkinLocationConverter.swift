//
//  PumkinLocationConverter.swift
//  item1
//
//  Created by zhonghangxun on 2018/11/27.
//  Copyright © 2018 zhonghangxun. All rights reserved.
//

import Foundation
import CoreLocation

let RANGE_LON_MAX = 137.8347

let RANGE_LON_MIN = 72.004

let RANGE_LAT_MAX = 55.8271

let RANGE_LAT_MIN = 0.8293

let jzA = 6378245.0

let jzEE = 0.00669342162296594323


public class PumkinLocationConverter {
    
    /// 世界标准地理坐标(WGS-84) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
    /// ####只在中国大陆的范围的坐标有效，以外直接返回世界标准坐标
    /// - Parameter location: 世界标准地理坐标(WGS-84)
    /// - Returns: 中国国测局地理坐标（GCJ-02）<火星坐标>
    static public func wgs84ToGcj02(location: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        
        return PumkinLocationConverter.gcj02Encrypt(ggLat: location.latitude, ggLon: location.longitude)
    }
    
    /// 中国国测局地理坐标（GCJ-02） 转换成 世界标准地理坐标（WGS-84）
    /// ####此接口有1－2米左右的误差，需要精确定位情景慎用
    /// - Parameter location: 中国国测局地理坐标（GCJ-02）
    /// - Returns: 世界标准地理坐标（WGS-84）
    static public func gcj02ToWgs84(location: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return PumkinLocationConverter.gcj02Decrypt(gjLat: location.latitude, gjLon: location.longitude)
    }
    
    
    /// 世界标准地理坐标(WGS-84) 转换成 百度地理坐标（BD-09)
    ///
    /// - Parameter location: 世界标准地理坐标(WGS-84)
    /// - Returns: 百度地理坐标（BD-09)
    static public func wgs84ToBd09(location: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        
        let gcj02Pt = PumkinLocationConverter.gcj02Encrypt(ggLat: location.latitude, ggLon: location.longitude)

        return  PumkinLocationConverter.bd09Encrypt(ggLat: gcj02Pt.latitude, ggLon: gcj02Pt.longitude)
    }
    
    
    /// 中国国测局地理坐标（GCJ-02）<火星坐标> 转换成 百度地理坐标（BD-09)
    ///
    /// - Parameter location: 中国国测局地理坐标（GCJ-02）<火星坐标>
    /// - Returns: 百度地理坐标（BD-09)
    static public func gcj02ToBd09(location: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return PumkinLocationConverter.bd09Encrypt(ggLat: location.latitude, ggLon: location.longitude)
    }
    
   
    /// 百度地理坐标（BD-09) 转换成 中国国测局地理坐标（GCJ-02）<火星坐标>
    ///
    /// - Parameter location: 百度地理坐标（BD-09)
    /// - Returns: 中国国测局地理坐标（GCJ-02）<火星坐标>
    static public func bd09ToGcj02(location: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return PumkinLocationConverter.bd09Decrypt(bdLat: location.latitude, bdLon: location.longitude)
    }
    
    /// 百度地理坐标（BD-09) 转换成 世界标准地理坐标（WGS-84）
    /// ####此接口有1－2米左右的误差，需要精确定位情景慎用
    /// - Parameter location: 百度地理坐标（BD-09)
    /// - Returns: 世界标准地理坐标（WGS-84）
    static public func bd09ToWgs84(location: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        
        let gcj02 = PumkinLocationConverter.bd09ToGcj02(location: location)
        return PumkinLocationConverter.gcj02Decrypt(gjLat: gcj02.latitude, gjLon: gcj02.longitude)
    }
    
    
    private static func transformLat(x:Double,y:Double) -> Double {
        var ret = PumkinLocationConverter.LAT_OFFSET_0(x: x, y: y)
        ret += PumkinLocationConverter.LAT_OFFSET_1(x: x, y: y)
        ret += PumkinLocationConverter.LAT_OFFSET_2(x: x, y: y)
        ret += PumkinLocationConverter.LAT_OFFSET_3(x: x, y: y)
        return ret
    }
    
    private static func transformLon(x:Double,y:Double) -> Double {
        var ret = PumkinLocationConverter.LON_OFFSET_0(x: x, y: y)
        ret += PumkinLocationConverter.LON_OFFSET_1(x: x, y: y)
        ret += PumkinLocationConverter.LON_OFFSET_2(x: x, y: y)
        ret += PumkinLocationConverter.LON_OFFSET_3(x: x, y: y)
        return ret
    }

    private static func outOfChina(lat:Double,lon:Double) -> Bool {
        if lon < RANGE_LON_MIN || lon > RANGE_LON_MAX {
            return true
        }
        if lat < RANGE_LAT_MIN || lat > RANGE_LAT_MAX {
            return true
        }
        return false
    }

    private static func gcj02Encrypt(ggLat:Double, ggLon:Double) -> CLLocationCoordinate2D {
        
        var resPoint = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        
        var mgLat = 0.0
        var mgLon = 0.0
        
        if PumkinLocationConverter.outOfChina(lat: ggLat, lon: ggLon) {
            resPoint.latitude = ggLat
            resPoint.longitude = ggLon
            return resPoint
        }
        
        var dLat = PumkinLocationConverter.transformLat(x: ggLon - 105.0, y: ggLat - 35.0)
        var dLon = PumkinLocationConverter.transformLon(x: ggLon - 105.0, y: ggLat - 35.0)
        
        let radLat = ggLat/180.0*Double.pi
        var magic = sin(radLat)
        magic = 1 - jzEE * magic * magic
        
        let sqrtMagic = sqrt(magic)
        
        dLat = (dLat * 180.0) / ((jzA * (1 - jzEE)) / (magic * sqrtMagic) * Double.pi)
        dLon = (dLon * 180.0) / (jzA / sqrtMagic * cos(radLat) * Double.pi)
        
        mgLat = ggLat + dLat
        mgLon = ggLon + dLon
        
        resPoint.latitude = mgLat
        resPoint.longitude = mgLon
        return resPoint
    }
    
    private static func gcj02Decrypt(gjLat:Double,gjLon:Double) -> CLLocationCoordinate2D {
        let gPt = PumkinLocationConverter.gcj02Encrypt(ggLat: gjLat, ggLon: gjLon)
        let dLon = gPt.longitude - gjLon
        let dLat = gPt.latitude - gjLat
        let pt = CLLocationCoordinate2D(latitude: gjLat - dLat, longitude: gjLon - dLon)
        return pt
    }
    

    private static func bd09Decrypt(bdLat:Double,bdLon:Double) -> CLLocationCoordinate2D {
        
        let x = bdLon - 0.0065
        let y = bdLat - 0.006
        let z = sqrt(x * x + y * y) - 0.00002 * sin(y * .pi)
        
        let theta = atan2(y, x) - 0.000003 * cos(x * .pi)

        let gcjPt = CLLocationCoordinate2D(latitude: z * sin(theta), longitude: z * cos(theta))

        return gcjPt;
    }

    private static func bd09Encrypt(ggLat:Double,ggLon:Double) -> CLLocationCoordinate2D {
        
        var bdPt = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let x_pi:CLLocationDegrees = .pi * 3000.0 / 180.0
        
        let x = ggLon
        let y = ggLat
        let z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi)
        let theta = atan2(y, x) + 0.000003 * cos(x * x_pi)
        
        bdPt.longitude = z * cos(theta) + 0.0065
        bdPt.latitude = z * sin(theta) + 0.006

        return bdPt
    }


//
//    + (CLLocationCoordinate2D)bd09ToWgs84:(CLLocationCoordinate2D)location
//    {

//    }
    ///  私有方法 经度偏移
    private static func LAT_OFFSET_0(x:Double,y:Double) -> Double {
        return -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x))
    }

    private static func LAT_OFFSET_1(x:Double,y:Double) -> Double {
        return (20.0 * sin(6.0 * x * .pi) + 20.0 * sin(2.0 * x * .pi)) * 2.0 / 3.0
    }

    private static func LAT_OFFSET_2(x:Double,y:Double) -> Double {
        return (20.0 * sin(y * .pi) + 40.0 * sin(y / 3.0 * .pi)) * 2.0 / 3.0
    }
    
    private static func LAT_OFFSET_3(x:Double,y:Double) -> Double {
        return (160.0 * sin(y / 12.0 * .pi) + 320 * sin(y * .pi / 30.0)) * 2.0 / 3.0
    }
    
    ///  私有方法 纬度偏移
    
    private static func LON_OFFSET_0(x:Double,y:Double) -> Double {
        return 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x))
    }
    
    private static func LON_OFFSET_1(x:Double,y:Double) -> Double {
        return (20.0 * sin(6.0 * x * .pi) + 20.0 * sin(2.0 * x * .pi)) * 2.0 / 3.0
    }
    
    private static func LON_OFFSET_2(x:Double,y:Double) -> Double {
        return (20.0 * sin(x * .pi) + 40.0 * sin(x / 3.0 * .pi)) * 2.0 / 3.0
    }
    
    private static func LON_OFFSET_3(x:Double,y:Double) -> Double {
        return (150.0 * sin(x / 12.0 * .pi) + 300.0 * sin(x / 30.0 * .pi)) * 2.0 / 3.0
    }

}






