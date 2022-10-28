//
//  HpPageContentView.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//多视图容器

import UIKit

@objc public protocol HpPageContentViewDelegate: NSObjectProtocol {
    @objc optional func segmentPageView(_ page: HpPageContentView, progress: CGFloat)
    @objc optional func segmentPageView(_ page: HpPageContentView, at index: Int)
}
//MARK:LAZY&cycle
public class HpPageContentView: UIView {
    public weak var delegate: HpPageContentViewDelegate?
    public var children: [UIViewController] = []
    private let cellID: String = "cellID"
    private(set) weak var parentVC: UIViewController?
    private(set) var selectIndex: Int = 0
    private(set) var willSelectIndex: Int = 0
    private var isScrollToBegin: Bool = false
    private var beginOffsetX: CGFloat = 0
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        return collectionView
    }()

    open var isScrollEnabled: Bool = true {
        didSet {
            self.collectionView.isScrollEnabled = self.isScrollEnabled
        }
    }
    
    convenience init(frame: CGRect = .zero, parent: UIViewController, children: [UIViewController]) {
        self.init(frame: frame)
        setupSegmentPageView(parent: parent, children: children)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout.itemSize = self.bounds.size
        collectionView.frame = self.bounds
    }
}
// MARK: - UICollectionViewDataSource
extension HpPageContentView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.children.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let child = children[indexPath.item]
        parentVC?.addChild(child)
        child.view.frame = cell.contentView.frame
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.contentView.addSubview(child.view)
        child.didMove(toParent: parentVC)
    }
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.subviews.forEach { (subView) in
            subView.removeFromSuperview()
        }
    }
}
// MARK: - UIScrollViewDelegate
extension HpPageContentView: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isScrollToBegin = false
        self.beginOffsetX = scrollView.contentOffset.x
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !self.isScrollToBegin else { return }
        var progress: CGFloat = 0.0
        let offsetX = scrollView.contentOffset.x, width = scrollView.frame.width
        let difference = offsetX.truncatingRemainder(dividingBy: width) / width
        if beginOffsetX < offsetX {
            selectIndex = Int(offsetX / width)
            willSelectIndex = selectIndex + 1
            if willSelectIndex >= children.count {
                willSelectIndex = selectIndex
            }
            progress = difference
        }
        else if beginOffsetX > offsetX {
            willSelectIndex = Int(offsetX / width)
            selectIndex = self.willSelectIndex + 1
            if selectIndex >= children.count {
                selectIndex = willSelectIndex
            }
            progress = 1 - difference
        }
        guard selectIndex != willSelectIndex else { return }
        if delegate?.responds(to: #selector(delegate?.segmentPageView(_:progress:))) ?? false {
            self.delegate?.segmentPageView?(self, progress: progress)
        }
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isScrollToBegin = false
        selectIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        if delegate?.responds(to: #selector(delegate?.segmentPageView(_:at:))) ?? false {
            self.delegate?.segmentPageView?(self, at: selectIndex)
        }
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        isScrollToBegin = false
        selectIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        if delegate?.responds(to: #selector(delegate?.segmentPageView(_:at:))) ?? false {
            self.delegate?.segmentPageView?(self, at: selectIndex)
        }
    }
}

//MARK:method
public extension HpPageContentView {
    func setupSegmentPageView(parent: UIViewController, children: [UIViewController]) {
        parentVC = parent
        self.children = children
        if self.isScrollEnabled {
            self.isScrollEnabled = children.count > 1
        }
        self.addSubview(self.collectionView)
    }
    func scrollToItem(to index: Int, animated: Bool) {
        guard self.children.count > 1 else {
            return
        }
        self.isScrollToBegin = true
        self.willSelectIndex = index
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView.performBatchUpdates({
        }) {[weak self] (finish) in
            self?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        }
        if !animated {
            self.selectIndex = index
            self.isScrollToBegin = false
            if delegate?.responds(to: #selector(delegate?.segmentPageView(_:at:))) ?? false {
                self.delegate?.segmentPageView?(self, at: index)
            }
        }
    }
    func child<T: UIViewController>(at index: Int, type: T.Type = T.self) -> T? {
        let child = self.children[index] as? T
        return child
    }
    func reloadData() {
        self.collectionView.reloadData()
    }
}

