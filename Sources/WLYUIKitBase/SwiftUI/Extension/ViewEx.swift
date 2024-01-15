//
//  File.swift
//  
//
//  Created by Laowang on 2024/1/11.
//

import SwiftUI

extension View {
    
    /// regions：指定要忽略的安全区域的区域类型。
    /// 默认值为 .all，表示忽略所有的安全区域。其他可用的选项包括 .keyboard（键盘安全区域）和 .container（父容器安全区域）。
    /// edges：指定要忽略的边缘安全区域。
    /// 默认值为 .all，表示忽略所有边缘的安全区域。其他可用的选项包括 .top、.bottom、.leading（左侧）、.trailing（右侧）。
    /// - Returns: -
    @inlinable public func iiignoresSafeArea(edges: Edge.Set = .all) -> some View {
        if #available(iOS 14.0, *) {
            return ignoresSafeArea(.all, edges: edges)
        } else {
            return edgesIgnoringSafeArea(edges)
        }
    }
}
