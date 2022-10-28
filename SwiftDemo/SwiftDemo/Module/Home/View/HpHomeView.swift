//
//  HpHomeView.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/27.
//  首页相关view

import UIKit
import SnapKit

// MARK: ========================    首页：区头SectionHeaderView   ===============================
class HpHomeSectionHeaderView: UITableViewHeaderFooterView {
    //标题
    private lazy var titleLb: UILabel = {
        let label = UILabel.makeLabel(text: "", font: UIFont.pingfangSemibold(size: 16), textColor: UIColor.fc_040404, alignment: .left, numberLine: 1)
        return label
    }()
    
    //容器
    private lazy var selectContainerView: UIView = {
        let view = UIView()
        return view
    }()
        
    //icon
    private lazy var iconImg: UIImageView = {
        let img = UIImageView()
        return img
    }()
        
    //选中标题
    private lazy var selectTitleLb: UILabel = {
        let label = UILabel.makeLabel(text: "", font: UIFont.pingfangRegular(size: 14), textColor: UIColor.fc_040404, alignment: .left, numberLine: 1)
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    //选中地址
    private lazy var selectAddressLb: UILabel = {
        let label = UILabel.makeLabel(text: "", font: UIFont.pingfangRegular(size: 14), textColor: UIColor.gray, alignment: .right, numberLine: 1)
        return label
    }()
        
    //箭头
    private lazy var arrowImg: UIImageView = {
        let img = UIImageView.makeImageView(image: UIImage(named: ""))
        img.backgroundColor = UIColor.red
        return img
    }()
    
    //点击事件block
    public var didSelectViewBlock: (() -> ())?
    
    //MARK: - 初始化
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK: - 搭建UI
    private func setupUI() {
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(titleLb)
        contentView.addSubview(selectContainerView)
        selectContainerView.addSubview(iconImg)
        selectContainerView.addSubview(selectTitleLb)
        selectContainerView.addSubview(selectAddressLb)
        selectContainerView.addSubview(arrowImg)
        
        titleLb.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
        }
        
        selectContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewClickAction(_:))))
        selectContainerView.cornerRadius(2)
        selectContainerView.border(UIColor.lightGray, width: 1)
        selectContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(titleLb.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        
        iconImg.cornerRadius(15)
        iconImg.backgroundColor = UIColor.red
        iconImg.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        selectTitleLb.snp.makeConstraints { make in
            make.left.equalTo(iconImg.snp.right).offset(15)
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(selectAddressLb.snp.left).offset(-15)
        }
        
        selectAddressLb.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(arrowImg.snp.left).offset(-15)
        }
        
        arrowImg.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
        
    //MARK: - 刷新数据
    public func config(model: HpHomeListModel) {
        titleLb.text = model.title
        
        let showIcon = (model.icon?.count ?? 0) > 0
        iconImg.isHidden = !showIcon
        iconImg.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(showIcon ? 20 : 5)
            make.width.height.equalTo(showIcon ? 30 : 0)
        }
        
        let selectItem = model.selectItem ?? HpHomeItemModel()
        selectTitleLb.text = (selectItem.name?.count ?? 0) > 0 ? " \(selectItem.name ?? "") " : ""
        selectTitleLb.backgroundColor = model.styleType == 2 ? UIColor.fc_F3F3F3 : UIColor.clear
        
        selectAddressLb.text = model.styleType == 2 ? selectItem.address : ""
        
        arrowImg.backgroundColor = model.isUnfold ? UIColor.green : UIColor.red
    }
}

extension HpHomeSectionHeaderView {
    //MARK: - 事件
    //当前view事件
    @objc private func viewClickAction(_ gesture: UITapGestureRecognizer) {
        self.didSelectViewBlock?()
    }
}

// MARK: ========================    首页：列表cell    ===============================
class HpHomeCell: UITableViewCell {
    //MARK: - 声明属性
    //左lab
    private lazy var leftLab: UILabel = {
        let label = UILabel.makeLabel(text: "", font: UIFont.pingfangRegular(size: 13), textColor: UIColor.fc_040404, alignment: .left, numberLine: 1)
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    //icon
    private lazy var rightIconImg: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor.red
        return img
    }()
    
    //右lab
    private lazy var rightLab: UILabel = {
        let label = UILabel.makeLabel(text: "", font: UIFont.pingfangRegular(size: 13), textColor: UIColor.gray, alignment: .left, numberLine: 1)
        return label
    }()
    
    //MARK: - 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 搭建UI
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(leftLab)
        contentView.addSubview(rightIconImg)
        contentView.addSubview(rightLab)
    
        leftLab.cornerRadius(2)
        leftLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.lessThanOrEqualToSuperview().offset(-210)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
            make.height.equalTo(20)
        }
        
        rightLab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(150)
        }
        
        rightIconImg.snp.makeConstraints { make in
            make.right.equalTo(rightLab.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
    //MARK: - 刷新数据
    open func config(model: HpHomeItemModel) {
        let showIcon = (model.icon?.count ?? 0) > 0
        
        leftLab.text = (model.name?.count ?? 0) > 0 ? " \(model.name ?? "") " : ""
        rightIconImg.isHidden = !showIcon
        rightLab.text = model.address
        
        leftLab.font = showIcon ? UIFont.pingfangSemibold(size: 15) : UIFont.pingfangRegular(size: 13)
        leftLab.backgroundColor = showIcon ? UIColor.clear : UIColor.fc_F3F3F3
        
        rightLab.font = showIcon ? UIFont.pingfangRegular(size: 15) : UIFont.pingfangRegular(size: 13)
        rightLab.textColor = showIcon ? UIColor.fc_040404 : UIColor.gray
    }
}
