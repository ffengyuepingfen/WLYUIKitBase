//
//  JJJTagView.swift
//  FlosSophorae
//
//  Created by JianjiaCoder on 2021/1/21.
//

import UIKit

public enum CicTagSelectOption {
    case single, mutable
}

public enum CicTagwType {
    /// 紧凑
    case compact
    /// 一行三个   默认
    case DivideEqu(Int)
}

public class CicTagView: UIView {
    
    private var collectionView: UICollectionView!
    /// 所有的
    private var dataArray: [String] = []
    /// 选中的
    private var selectSet: Set<Int> = []
    
    private var callBack:((_ indexs: Set<Int>)->Void)?
    
    private var type: CicTagwType
    
    private var selectOption: CicTagSelectOption
    
    private var borderColor:UIColor = UIColor.systemBlue
    
    private var sectionName:String = ""
    
    public func reloadData(tags:[String]) {
        dataArray = tags
        selectSet.removeAll()
        collectionView.reloadData()
    }
    
    public func getViewheight() -> CGFloat {
        let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        return  sectionName == "" ? height : (height + 44)
    }
    
    public init(frame: CGRect,
                sectionName: String = "",
                tags:[String],
                option: CicTagSelectOption = .single,
                borderColor:UIColor = UIColor.separator,
                type:CicTagwType = .compact,
                defaultSelectFirst: Bool = true,
                callback: ((_ indexs: Set<Int>)->Void)? = nil) {
        if defaultSelectFirst {
            selectSet.insert(0)
        }
        self.dataArray = tags
        self.callBack = callback
        self.type = type
        self.borderColor = borderColor
        self.sectionName = sectionName
        self.selectOption = option
        super.init(frame: frame)
        addContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        var sectionNameHeight:CGFloat = 0
        if sectionName != "" {
            sectionNameHeight = 44
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: sectionNameHeight))
            label.text = sectionName
            self.addSubview(label)
        }
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: sectionNameHeight, width: self.bounds.width, height: self.bounds.height - sectionNameHeight), collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.addSubview(self.collectionView)
        self.collectionView.register(TagViewCell.self, forCellWithReuseIdentifier: TagViewCell.identifier)
    }
}

extension CicTagView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TagViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagViewCell.identifier, for: indexPath) as! TagViewCell
        cell.color = borderColor
        cell.content = dataArray[indexPath.row]
        if selectSet.contains(indexPath.row) {
            cell.contentView.backgroundColor = UIColor.systemBlue
            cell.label.textColor = UIColor.white
        }else{
            cell.contentView.backgroundColor = UIColor.secondarySystemBackground
            cell.label.textColor = UIColor.label
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch type {
        case let .DivideEqu(num):
            let height:CGFloat = 34
            return CGSize(width: (collectionView.bounds.width - 40)/CGFloat(num), height: height)
        case .compact:
            return getMultiLineWithFont(font: NSInteger(14.0), text: dataArray[indexPath.row])
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
        let index = indexPath.row
        
        switch selectOption {
        case .single:
            selectSet.removeAll()
            selectSet.insert(index)
        case .mutable:
            if selectSet.contains(index) {
                // 取消
                selectSet.remove(index)
            }else{
                selectSet.insert(index)
            }
        }
        
        if !selectSet.isEmpty {
            collectionView.reloadData()
            if let callBack = callBack {
                callBack(selectSet)
            }
        }
    }
    
    private func getMultiLineWithFont(font:NSInteger,text:String) -> CGSize {
        let size = getNormalStrSize(str: text, attriStr: nil, font: CGFloat(font), w: self.bounds.width - 20, h: CGFloat(MAXFLOAT))
        let newsize = CGSize(width: size.width + 30.0, height: size.height + 10)
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


class TagViewCell: UICollectionViewCell, IdentifierProtocol {

    var content:String = ""{
        didSet{
            self.label.text = content
            self.label.frame = self.bounds
            if let col = color {
                self.contentView.layer.borderColor = col.cgColor
            }
        }
    }

    var label: UILabel!
    /// 必须在content之前给值
    var color:UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel(frame: CGRect(x: 10, y: 10, width: self.bounds.width - 20, height: self.bounds.height - 20))
        self.label.font = UIFont.systemFont(ofSize: 14.0)
        self.label.textAlignment = .center
        self.label.numberOfLines = 0
        self.contentView.addSubview(self.label)
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.cornerRadius = self.bounds.height/2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
