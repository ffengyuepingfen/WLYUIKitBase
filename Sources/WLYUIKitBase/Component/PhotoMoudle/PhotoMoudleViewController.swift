////
////  PhotoMoudleViewController.swift
////  angXinOutsourcing
////
////  Created by zhonghangxun on 2018/11/12.
////  Copyright © 2018 WXBPre. All rights reserved.
////
//
import UIKit
import TZImagePicker
import WLYUIKitBase

//let SDKBundle = Bundle(for: PhotoMoudleViewController.self)

public class PhotoMoudleViewController: UIViewController {
    /// 是否可以增加活着删除图片
    public var angXEdit = false
    /// 最大上传几张 默认一张
    public var maxUploadCount = 1
    /// 图片资源的载体视图
    public var photoCollectionView: UICollectionView!
    /// 存取图片的数组
    public var photoArray: [String] = [String]() {
        didSet {
            self.photoCollectionView.reloadData()
        }
    }
    /// 需要上传的 data数据
    public var photoDataArray: [Data] = []
    /// 单张图片选择成功后的data回调
    public var upLoadImageCall:((_ imagedata:Data)->Void)?
    /// 单张删除图片的回调
    public var deleteImageCall:((_ index:Int)->Void)?


    /// 需要显示的 Image数据
    var photoImageArray: [UIImage] = [UIImage]() {
        didSet {
            self.photoCollectionView.reloadData()
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    /// 配置当前页面
    public func configPhotoView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.minimumLineSpacing = 4
        self.photoCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: GConfig.ScreenW, height: 200), collectionViewLayout: flowLayout)
        self.photoCollectionView.backgroundColor = UIColor.white
        self.photoCollectionView.tag = 200
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.isScrollEnabled = false
        self.photoCollectionView.register(AngXImageViewCollectionViewCell.self, forCellWithReuseIdentifier: AngXImageViewCollectionViewCell.w_identifier)
        if angXEdit == true {
            photoImageArray = [UIImage(named: "addImage") ?? UIImage()]
        }
    }

}

extension PhotoMoudleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return angXEdit == true ? (photoImageArray.count <= 3 ? photoImageArray.count : maxUploadCount) : self.photoArray.count

    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AngXImageViewCollectionViewCell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: AngXImageViewCollectionViewCell.w_identifier, for: indexPath) as! AngXImageViewCollectionViewCell
        
        if angXEdit == true {
            /// 代表上传
            cell.deleteButton.isHidden = false
            let image = photoImageArray[indexPath.row]
            cell.imageView.image = image
            if indexPath.row == (self.photoImageArray.count - 1) {
                cell.deleteButton.isHidden = true
            }

            cell.deleteBlock = { [weak self] in
                self?.photoImageArray.remove(at: indexPath.row)
                self?.photoCollectionView.reloadData()
                if let deleteImageCall = self?.deleteImageCall {
                    deleteImageCall(indexPath.row)
                }
            }

        } else {
            /// 代表展示
            cell.deleteButton.isHidden = true
            let mm = self.photoArray[indexPath.row]
            cell.imageView.downloadImage(from: URL(string: mm.initPercent()), placeholder: UIImage(named: "placeImage"))
        }
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 4)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if angXEdit == true {
            /// 代表上传
            if indexPath.row == self.photoImageArray.count - 1 {
                /// 最后一个上传按钮
                /// 上传图片
                let imagePickerVc = TZImagePickerController(maxImagesCount: 1, delegate: self)
                /// 是否原图
                imagePickerVc?.isSelectOriginalPhoto = false
                /// 在内部显示拍照按钮
                imagePickerVc?.allowTakePicture = true
                /// 是否可以选择视频/图片/原图
                imagePickerVc?.allowPickingVideo = false
                imagePickerVc?.allowPickingImage = true
                imagePickerVc?.allowPickingOriginalPhoto = true
                imagePickerVc?.naviBgColor = UIColor.pumkinBlue()
                imagePickerVc?.showSelectBtn = false
                imagePickerVc?.cropRectPortrait = CGRect(x: 0, y: GConfig.ScreenH/2 - GConfig.ScreenH/16*9, width: GConfig.ScreenW, height: GConfig.ScreenH/16*9)
                UIApplication.shared.keyWindow?.rootViewController?.present(imagePickerVc!, animated: true, completion: nil)
//                self.present(imagePickerVc!, animated: true, completion: nil)
            } else {
                /// 进入预览照片
                let previewVC = ImagePreviewVC(images: photoArray, index: indexPath.row)
                self.navigationController?.pushViewController(previewVC, animated: true)
            }
        } else {
            /// 进入预览照片
            let previewVC = ImagePreviewVC(images: photoArray, index: indexPath.row)
            self.navigationController?.pushViewController(previewVC, animated: true)
        }
    }
}

extension PhotoMoudleViewController: TZImagePickerControllerDelegate {
    public func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        /// photos 是选择图片 传回来的Image数组 想要获取他 就拿一个全局函数j去接受吧
        /// assets 这个是原始对象 要解析他才能获取到具体路径 会累死的

        var data = photos.first?.compressQualityWithMaxLength(100)
        
        if let image = photos.first, let data = data {
            photoImageArray.insert(image, at: 0)
            photoDataArray.insert(data, at: 0)
            if let upimagecall = upLoadImageCall {
                upimagecall(data)
            }
        }
    }
}
