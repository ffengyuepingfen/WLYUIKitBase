//
//  CGXPickerViewManager.m
//  CGXPickerView
//
//  Created by 曹贵鑫 on 2018/1/8.
//  Copyright © 2018年 曹贵鑫. All rights reserved.
//

#import "CGXPickerViewManager.h"

@interface CGXPickerViewManager ()

@end
@implementation CGXPickerViewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _kPickerViewH = 200;
        _kTopViewH = 50;
        _pickerTitleSize  =15;
        _pickerTitleColor = [UIColor blackColor];
        _lineViewColor =CGXPickerRGBColor(225, 225, 225, 1);
        
        _titleLabelColor = CGXPickerThemeColor;
        _titleSize = 16;
        _titleLabelBGColor = [UIColor whiteColor];
        
        _rightBtnTitle = @"确定";
        _rightBtnBGColor =  CGXPickerThemeColor;
        _rightBtnTitleSize = 16;
        _rightBtnTitleColor = [UIColor whiteColor];
        
        _rightBtnborderColor = CGXPickerThemeColor;
        _rightBtnCornerRadius = 6;
        _rightBtnBorderWidth = 1;
        
        _leftBtnTitle = @"取消";
        _leftBtnBGColor =  CGXPickerThemeColor;
        _leftBtnTitleSize = 16;
        _leftBtnTitleColor = [UIColor whiteColor];
        
        _leftBtnborderColor = CGXPickerThemeColor;
        _leftBtnCornerRadius = 6;
        _leftBtnBorderWidth = 1;
    }
    return self;
}

//将十六进制的颜色转化为UIColor
+ (UIColor*)colorWithHexString:(NSString*)color{
    NSString * cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    //string的长度应该为6或者8
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    //strip "0X" or "#" if it appears
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    //r g b
    NSRange range ;
    range.location = 0 ;
    range.length = 2;
    // r
    NSString * rString = [cString substringWithRange:range];
    // g
    range.location = 2 ;
    NSString * gString = [cString substringWithRange:range];
    // b
    range.location = 4 ;
    NSString * bString = [cString substringWithRange:range];
    
    //scan values
    unsigned int r,g,b ;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:1.0f];
    
}

@end
