//
//  SelecetedImageUtil.swift
//  FBSnapshotTestCase
//
//  Created by wangxiangbo on 2020/3/16.
//

//import UIKit
//import TZImagePickerController
//
//public class SelecetedImageUtil: NSObject {
//
//    public var callback:((_ icon: UIImage,_ imageData:Data?)->Void)?
//
//    override public init() {
//        super.init()
//    }
//
//    public func showImagePicker(tinColor:UIColor = UIColor.black) {
//        /// 上传用户头像
//        let imagePickerVc = TZImagePickerController(maxImagesCount: 1, delegate: self)
//        /// 是否原图
//        imagePickerVc?.isSelectOriginalPhoto = false
//        imagePickerVc?.preferredLanguage = "zh-Hans"
//        /// 在内部显示拍照按钮
//        imagePickerVc?.allowTakePicture = true
//        /// 是否可以选择视频/图片/原图
//        imagePickerVc?.allowPickingVideo = false
//        imagePickerVc?.allowPickingImage = true
//        imagePickerVc?.allowPickingOriginalPhoto = true
//        imagePickerVc?.naviBgColor = tinColor
//        imagePickerVc?.showSelectBtn = false
//        let screenH:CGFloat = UIApplication.shared.keyWindow?.bounds.width ?? 0.0
//
//        imagePickerVc?.cropRectPortrait = CGRect(x: 0, y: screenH/2 - screenH/16*9, width: screenH, height: screenH/16*9)
//        let view: UIWindow = UIApplication.shared.keyWindow!
//        view.rootViewController?.present(imagePickerVc!, animated: true, completion: nil)
//    }
//}
//
//extension SelecetedImageUtil: TZImagePickerControllerDelegate {
//    public func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
//        /// photos 是选择图片 传回来的Image数组 想要获取他 就拿一个全局函数j去接受吧
//        /// assets 这个是原始对象 要解析他才能获取到具体路径 会累死的
////        self.userIconImageView.image = photos.first
//        if let image = photos.first, let callback = callback {
//            /// 上传图片 拿到地址 给 个人信息重新赋值
//            let data = image.compressQualityWithMaxLength(100)
//            callback(image,data)
//        }else{
//            GConfig.log("图片选择出错")
//        }
//    }
//}
//
//
//
//
