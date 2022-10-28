//
//  HpHomeManagerVC.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//  首页管理

import UIKit

class HpHomeManagerVC: HpBaseVC {
    //MARK: - 声明属性
    //右按钮
    private lazy var navRightBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: kScreenWidth - 50, y: 7, width: 30, height: 30)
        btn.backgroundColor = UIColor.red
        return btn
    }()
    
    //segment
    private lazy var titleSegment: HpSegmentTitleView = {
        let item = HpSegmentTitleView.init(frame: CGRect(x: 0, y: KNavigationHeight, width: kScreenWidth, height: 40))
        item.delegate = self
        item.backgroundColor = .clear
        return item
    }()
    
    //容器
    private lazy var pageContentView: HpPageContentView = {
        let item = HpPageContentView.init(frame: CGRect(x: 0, y: KNavigationHeight + 40, width: kScreenWidth, height: kScreenHeight - 40 - KNavigationHeight))
        item.backgroundColor = .fc_FAFAFA
        item.delegate = self
        return item
    }()
    
    //segment标题数据
    private lazy var items: [String] = {
        return ["OVERVIEW", "WITHDRAW", "ADDRESS BOOK"]
    }()
    
    //子控制器
    private lazy var childVCs: [UIViewController] = {
        var children: [UIViewController] = []
        let vc1 = HpHomeListVC()
        children.append(vc1)
        let vc2 = HpHomeListVC()
        children.append(vc2)
        let vc3 = HpHomeListVC()
        children.append(vc3)
        return children
    }()
    
    var curType: Int = 0
}

extension HpHomeManagerVC {
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 设置导航栏半透明
        self.navigationController?.navigationBar.isTranslucent = true
        //导航栏标题
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .clear
            appearance.backgroundEffect = nil
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.standardAppearance = appearance
        } else {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.barStyle = .black
        }
    }
     
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 设置导航栏半透明
        self.navigationController?.navigationBar.isTranslucent = false
        //导航栏标题
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white
            appearance.backgroundEffect = nil
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: RGB(74, 74, 74)]
            self.navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.standardAppearance = appearance
        } else {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor:RGB(74, 74, 74)];
            self.navigationController?.navigationBar.barStyle = .default
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
}

extension HpHomeManagerVC {
    //MARK: - 搭建UI
    private func setupNav() {
        let navBgView = UIView(frame: CGRect(x: 0, y: kStatusBarHeight, width: kScreenWidth, height: KNavigationHeight))
        view.addSubview(navBgView)
    
        navBgView.addSubview(navRightBtn)
    }
    
    private func setUI(){
        self.view.backgroundColor = .white
        self.view.addSubview(titleSegment)
        self.view.addSubview(pageContentView)
        
        let config = HpSegmentTitleView.Configuration()
        config.positionStyle = .bottom
        config.indicatorStyle = .dynamic
        config.indicatorFixedHeight = 2.0
        config.titleNormalColor = .fc_999999
        config.titleSelectedColor = .fc_121E26
        config.indicatorColor = .fc_018CD7
        config.titleSelectedFontScale = 1.0
        config.titleFixedWidth = kScreenWidth/CGFloat(items.count)
        config.isShowSeparator = false
        config.indicatorDuration = 0.0
        config.isShowBottomLine = false
        config.separatorInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        titleSegment.setupSegmentTitleView(config: config, titles: self.items)
        titleSegment.setSelectIndex(at: self.curType)
        pageContentView.setupSegmentPageView(parent: self, children: childVCs)
        pageContentView.scrollToItem(to: self.curType, animated: false)
    }
}

extension HpHomeManagerVC: HpSegmentTitleViewDelegate{
    //MARK: - 代理
    func segmentTitleView(_ page: HpSegmentTitleView, at index: Int) {
        pageContentView.scrollToItem(to: index, animated: true)
    }
}
extension HpHomeManagerVC: HpPageContentViewDelegate{
    func segmentPageView(_ page: HpPageContentView, at index: Int) {
        titleSegment.setSelectIndex(at: index)
    }
}
