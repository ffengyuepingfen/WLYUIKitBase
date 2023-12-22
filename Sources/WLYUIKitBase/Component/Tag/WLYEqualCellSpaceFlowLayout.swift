//
//  WLYEqualCellSpaceFlowLayout.swift
//  SwiftDemo
//
//  Created by 王相博 on 2019/9/22.
//  Copyright © 2019 CHEN. All rights reserved.
//

import UIKit

enum AlignType {
    case left,right,center
}

class WLYEqualCellSpaceFlowLayout: UICollectionViewFlowLayout {

    private var contentType:AlignType = .left

    private var betweenOfCell:CGFloat = 10.0

    private var sumCellWidth:CGFloat = 0.0

    //用来临时存放一行的Cell数组
    var layoutAttributesTemp:[UICollectionViewLayoutAttributes] = []

    init(type:AlignType,betweenOfCell:CGFloat) {
        self.contentType = type
        self.betweenOfCell = betweenOfCell
        super.init()
        self.minimumInteritemSpacing = betweenOfCell
        self.scrollDirection = .vertical
        self.minimumLineSpacing = 10.0
        self.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        let layoutAttributes_t = super.layoutAttributesForElements(in: rect)

        guard let layoutAttributes = layoutAttributes_t else {
            return nil
        }

        for (index,item) in layoutAttributes.enumerated() {
            let currentAttr = item // 当前cell的位置信息
            let previousAttr = index == 0 ? nil : layoutAttributes[index - 1] // 上一个cell 的位置信
            let nextAttr = index + 1 == layoutAttributes.count ? nil : layoutAttributes[index+1]

            //加入临时数组
            layoutAttributesTemp.append(currentAttr)
            sumCellWidth += currentAttr.frame.size.width

            let previousY = previousAttr == nil ? 0 : previousAttr?.frame.maxY
            let currentY = currentAttr.frame.maxY
            let nextY = nextAttr == nil ? 0 : nextAttr?.frame.maxY

            //如果当前cell是单独一行
            if currentY != previousY, currentY != nextY {
                if currentAttr.representedElementKind  == UICollectionView.elementKindSectionHeader  {
                    layoutAttributesTemp.removeAll()
                    sumCellWidth = 0.0
                }else if currentAttr.representedElementKind  == UICollectionView.elementKindSectionFooter {
                    layoutAttributesTemp.removeAll()
                    sumCellWidth = 0.0
                }else{
                    setCellFrameWith(layoutAttributes: layoutAttributesTemp)
                }
            }else if currentY != nextY {
                //如果下一个cell在本行，这开始调整Frame位置
                setCellFrameWith(layoutAttributes: layoutAttributesTemp)
            }
        }
        return layoutAttributes
    }
    //调整属于同一行的cell的位置frame
    private func setCellFrameWith(layoutAttributes:[UICollectionViewLayoutAttributes]) {
        var nowWidth:CGFloat = 0.0

        switch contentType {
        case .left:
            nowWidth = sectionInset.left + 10
            for attributes in layoutAttributes {
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.betweenOfCell
            }
            sumCellWidth = 0.0
            layoutAttributesTemp.removeAll()
        case .center:

            let hh = self.collectionView!.bounds.width - sumCellWidth
            let gg = CGFloat(layoutAttributes.count - 1)*betweenOfCell

            nowWidth = (hh - gg)/2
            for attributes in layoutAttributes {
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.betweenOfCell
            }
            sumCellWidth = 0.0
            layoutAttributesTemp.removeAll()
        case .right:
            nowWidth = self.collectionView!.frame.width - self.sectionInset.right
            for attributes in layoutAttributes {
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth - nowFrame.size.width
                attributes.frame = nowFrame;
                nowWidth = nowWidth - nowFrame.size.width - betweenOfCell
            }
            sumCellWidth = 0.0
            layoutAttributesTemp.removeAll()
        }
    }
}


class UICollectionViewLeftFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attrsArry = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        for i in 0..<attrsArry.count {
            if i != attrsArry.count-1 {
                let curAttr = attrsArry[i] //当前attr
                let nextAttr = attrsArry[i+1]  //下一个attr
                //如果下一个在同一行则调整，不在同一行则跳过
                if curAttr.frame.minY == nextAttr.frame.minY {
                    if nextAttr.frame.minX - curAttr.frame.maxX > minimumInteritemSpacing{
                        var frame = nextAttr.frame
                        let x = curAttr.frame.maxX + minimumInteritemSpacing
                        frame = CGRect(x: x, y: frame.minY, width: frame.width, height: frame.height)
                        nextAttr.frame = frame
                    }
                }
            }
        }
        return attrsArry
    }
}
