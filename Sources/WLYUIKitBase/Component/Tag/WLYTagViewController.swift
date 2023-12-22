//
//  WLYTagViewController.swift
//  InternetBusKit
//
//  Created by ZHXMAC on 2019/9/23.
//  Copyright © 2019 ZHXMAC. All rights reserved.
//

import UIKit

public enum WLYTagViewType {
    /// 紧凑
    case compact
    /// 一行三个   默认
    case fixedThree
    ///
    case fullRow
}

public class WLYTagViewController: UIViewController {

    var collectionView:UICollectionView!
    
    var dataArray:[String] = []
    
    var imageArray:[UIImage] = []
    
    private var callBack:((_ index:Int)->Void)?
    
    private var tagtype:WLYTagViewType
    
    private var wTinColor:UIColor = UIColor.white
    
    private var sectionName:String = ""
    
    public init(sectionName:String = "",tags:[String],wTinColor:UIColor = UIColor.black,tagType:WLYTagViewType = .fixedThree,callback:((_ index:Int)->Void)? = nil) {
        self.dataArray = tags
        self.callBack = callback
        self.tagtype = tagType
        self.wTinColor = wTinColor
        self.sectionName = sectionName
        super.init(nibName: nil, bundle: nil)
        addContentView()
    }
    
    public init(tags:[String] = [],images:[UIImage] = [],tagType:WLYTagViewType = .fixedThree,callback:((_ index:Int)->Void)? = nil) {
        self.dataArray = tags
        self.imageArray = images
        self.callBack = callback
        self.tagtype = tagType
        super.init(nibName: nil, bundle: nil)
        addContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func addContentView() {
        var sectionNameHeight:CGFloat = 0
        if sectionName != "" {
            sectionNameHeight = 44
            let label = UILabel(frame: CGRect(x: 12, y: 0, width: 200, height: sectionNameHeight))
            label.text = sectionName
            view.addSubview(label)
        }
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        self.collectionView = UICollectionView(frame: CGRect(x: 10, y: sectionNameHeight, width: self.view.bounds.width - 20, height: self.view.bounds.height - sectionNameHeight), collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        self.collectionView.register(WLYTagCollectionViewCell.self, forCellWithReuseIdentifier: WLYTagCollectionViewCell.identifier)
        self.collectionView.register(WLYItemTagCollectionViewCell.self, forCellWithReuseIdentifier: WLYItemTagCollectionViewCell.identifier)
    }
    
    public func getViewheight() -> CGFloat {
        let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        return  sectionName == "" ? height : (height + 44)
    }
    
    deinit {
        print("....")
    }
    
}

extension WLYTagViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.imageArray.isEmpty {
            let cell:WLYTagCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: WLYTagCollectionViewCell.identifier, for: indexPath) as! WLYTagCollectionViewCell
            cell.color = wTinColor
            cell.content = dataArray[indexPath.row]
            return cell;
        }else{
            let cell:WLYItemTagCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: WLYItemTagCollectionViewCell.identifier, for: indexPath) as! WLYItemTagCollectionViewCell
            cell.label.text = dataArray[indexPath.row]
            cell.imageView.image = self.imageArray[indexPath.row]
            return cell;
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if tagtype == .fixedThree {
            let height:CGFloat = imageArray.isEmpty ? 40 : 100
            return CGSize(width: (collectionView.bounds.width - 40)/3, height: height)
        }else{
            return  getMultiLineWithFont(font: NSInteger(14.0), text: dataArray[indexPath.row])
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let callBack = callBack {
            callBack(indexPath.row)
        }
    }
    
    private func getMultiLineWithFont(font:NSInteger,text:String) -> CGSize {
        let size = getNormalStrSize(str: text, attriStr: nil, font: CGFloat(font), w: UIScreen.main.bounds.width - 20, h: CGFloat(MAXFLOAT))
        let newsize = CGSize(width: size.width + 20.0, height: size.height + 20)
        return newsize
    }
    
    private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
        if str != nil {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: font)], context: nil).size
            return strSize
        }
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        return CGSize.zero
    }
}
