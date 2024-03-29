////
////  ImagePreviewVC.swift
////  angXinOutsourcing
////
////  Created by 王相博 on 2018/10/28.
////  Copyright © 2018 WXBPre. All rights reserved.
////
//
import UIKit
import FDFullscreenPopGesture
import WLYUIKitBase

public class ImagePreviewVC: UIViewController {

    //存储图片数组
    var images: [String]

    //默认显示的图片索引
    var index: Int

    //用来放置各个图片单元
    var collectionView: UICollectionView!

    //collectionView的布局
    var collectionViewLayout: UICollectionViewFlowLayout!

    //页控制器（小圆点）
    var pageControl: UIPageControl!

    //初始化
    public init(images: [String], index: Int = 0) {
        self.images = images
        self.index = index

        super.init(nibName: nil, bundle: nil)
    }

    public init(des:(name: String, lat: String, lng: String),images: [String], index: Int = 0) {
        self.images = images
        self.index = index

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //初始化
    override public func viewDidLoad() {
        super.viewDidLoad()
        //背景设为黑色
        self.view.backgroundColor = UIColor.black

        //collectionView尺寸样式设置
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        //横向滚动
        collectionViewLayout.scrollDirection = .horizontal

        //collectionView初始化
        collectionView = UICollectionView(frame: self.view.bounds,
                                          collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.black
        collectionView.register(ImagePreviewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        //不自动调整内边距，确保全屏
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(collectionView)

        //将视图滚动到默认图片上
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)

        //设置页控制器
        pageControl = UIPageControl()
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                     y: UIScreen.main.bounds.height - 20)
        pageControl.numberOfPages = images.count
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = index
        view.addSubview(self.pageControl)
    }

    //视图显示时
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        self.fd_prefersNavigationBarHidden = true
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    //视图消失时
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //显示导航栏
        self.fd_prefersNavigationBarHidden = false
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    //隐藏状态栏
    override public var prefersStatusBarHidden: Bool {
        return false
    }

    //将要对子视图布局时调用（横竖屏切换时）
    override public func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        //重新设置collectionView的尺寸
        collectionView.frame.size = self.view.bounds.size
        collectionView.collectionViewLayout.invalidateLayout()

        //将视图滚动到当前图片上
        let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)

        //重新设置页控制器的位置
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width/2,
                                     y: UIScreen.main.bounds.height - 20)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

//ImagePreviewVC的CollectionView相关协议方法实现
extension ImagePreviewVC: UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {

    //collectionView单元格创建
    public func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as? ImagePreviewCell
            let imageStr = self.images[indexPath.row]
            let image = UIImage(named: "placeImage")
            cell?.imageView.downloadImage(from: URL(string: imageStr), placeholder: image)
            return cell!
    }

    //collectionView单元格数量
    public func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }

    //collectionView单元格尺寸
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.bounds.size
    }

    //collectionView里某个cell将要显示
    public func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? ImagePreviewCell {
            //由于单元格是复用的，所以要重置内部元素尺寸
            cell.resetSize()
        }
    }

    //collectionView里某个cell显示完毕
    public func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        //当前显示的单元格
        let visibleCell = collectionView.visibleCells[0]
        //设置页控制器当前页
        self.pageControl.currentPage = collectionView.indexPath(for: visibleCell)!.item
    }
}
