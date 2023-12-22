//
//  WelcomePageViewController.swift
//  FlosSophorae
//
//  Created by JianjiaCoder on 2021/2/24.
//

import UIKit
import WLYUIKitBase

public class WelcomePageViewController: UIViewController {

    static let CIC_FIRST_START = "WelcomePageViewController_CFBundleVersion"
    
    // Whether to hide pageControl, default is NO which means show pageControl
    public var hidePageControl: Bool = false
    // Whether to hide skip Button, default is YES which means hide skip Button
    public var hideSkipButton = true
    //
    public var currentPageIndicatorTintColor: UIColor = UIColor.pumkinBlue() {
        didSet {
            pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        }
    }
    //
    public var pageIndicatorTintColor: UIColor = .lightGray {
        didSet {
            pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        }
    }
    
    var rootVC: UIViewController!
    var imageNames: [String]!
    var pageControl: UIPageControl!
    var skipButton: UIButton!
    /// 是否展示标记空间
    var isShowpageControl = true
    
    private var regiestCallback: ((_ vc: UIViewController)-> Void)? = nil
    
    public init(imageNames: [String], rootViewController: UIViewController, isShow: Bool = true, inject: ((_ vc: UIViewController)-> Void)? = nil) {
        self.imageNames = imageNames
        self.rootVC = rootViewController
        self.isShowpageControl = isShow
        self.regiestCallback = inject
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    func setup() {
        
        if !imageNames.isEmpty {
            let scrollView = UIScrollView()
            scrollView.delegate = self
            scrollView.bounces = false
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.frame = self.view.bounds
            scrollView.contentSize = CGSize(width: GConfig.ScreenW*CGFloat(imageNames.count), height: CGFloat(0.0))
            self.view.addSubview(scrollView)
            for (index, item) in imageNames.enumerated() {
                let imageView = UIImageView(image: UIImage(named: item))
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.frame = CGRect(x: GConfig.ScreenW*CGFloat(index), y: 0, width: GConfig.ScreenW, height: GConfig.ScreenH)
                scrollView.addSubview(imageView)
                if index == imageNames.count - 1 {
                    imageView.isUserInteractionEnabled = true
//                    let tap = UITapGestureRecognizer(target: self, action: #selector(tapAciton))
//                    imageView.addGestureRecognizer(tap)
                    
                    let regiestButton = UIButton(frame: CGRect(x: (GConfig.ScreenW - 180)/2, y: GConfig.ScreenH - GConfig.BottomSafeH - 88, width: 180, height: 44))
                    regiestButton.setTitle("立即注册", for: .normal)
                    regiestButton.setTitleColor(UIColor.white, for: .normal)
                    regiestButton.setBackgroundImage(UIImage(named: "regiestButtonBack"), for: .normal)
                    regiestButton.addTarget(self, action: #selector(regiestAciton), for: .touchUpInside)
                    imageView.addSubview(regiestButton)
                }
            }
            
            skipButton = UIButton()
            skipButton.frame = CGRect(x: GConfig.ScreenW - 10 - 60, y: 60, width: 60, height: 30)
            skipButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            skipButton.layer.cornerRadius = 15.0
            skipButton.setTitle("跳过", for: .normal)
            skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            skipButton.setTitleColor(UIColor.lightGray, for: .normal)
            skipButton.addTarget(self, action: #selector(tapAciton), for: .touchUpInside)
            self.view.addSubview(skipButton)
            
            if isShowpageControl {
                pageControl = UIPageControl()
                pageControl.numberOfPages = imageNames.count
                pageControl.hidesForSinglePage = true
                pageControl.isUserInteractionEnabled = false
                pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
                pageControl.pageIndicatorTintColor = pageIndicatorTintColor
                pageControl.frame = CGRect(x: 0, y: GConfig.ScreenH*0.92, width: GConfig.ScreenW, height: 40)
                self.view.addSubview(pageControl)
            }
        }
    }
    
    @objc func loginSuccess() {
        tapAciton()
    }
    
    @objc func regiestAciton() {
        if let regiestAction = regiestCallback {
            regiestAction(self)
        }
    }
    
    @objc func tapAciton() {
        
        if let window = UIApplication.shared.keyWindow {
            self.rootVC.modalTransitionStyle = .crossDissolve
            
            let animation = {
                let oldState = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                UIApplication.shared.keyWindow?.rootViewController = self.rootVC
                UIView.setAnimationsEnabled(oldState)
            }
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: animation) { (_) in }
        }
    }
    
    /// Only the first start app need show new features
    /// - Returns: return YES to show, NO not to show
    public static func shouldShowNewFeature() -> Bool {
       
        guard let lastVersion = UserDefaults.standard.string(forKey: CIC_FIRST_START) else {
            let currentVersion: String = UIDevice.versionCode()
            UserDefaults.standard.setValue(currentVersion, forKey: CIC_FIRST_START)
            return true
        }
        
        return false
    }
    
    deinit {
        GConfig.log("引导页————delloc😄😄😄😄😄😄😄😄😄😄")
    }
}


extension WelcomePageViewController :UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.size.width
        if isShowpageControl {
            pageControl.currentPage = Int(page)
        }
    }
}

