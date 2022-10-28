//
//  HpPresentView.swift
//  SwiftDemo
//
//  Created by hp on 2022/10/28.
//

import UIKit

class HpPresentView: UIView {

    //MARK: - 声明属性
    //内容
    private lazy var containerView: UIImageView = {
        let imgView = UIImageView.makeImageView(image: nil, contentMode: .scaleToFill, isUserInteractionEnabled: true)
        imgView.backgroundColor = .white
        imgView.cornerRadius(10)
        let ges = UITapGestureRecognizer()
        imgView.addGestureRecognizer(ges)
        ges.addTarget(self, action: #selector(containerViewClickAction))
        return imgView
    }()

    //关闭
    private lazy var closeBtn: UIButton = {
        let btn = UIButton.makeButton(title: nil, titleFont: nil, image: "home_questionAnswerAlert_close")
        btn.setTitle(" X ", for: .normal)
        btn.setTitle(" X ", for: .selected)
        btn.setImage(UIImage(named: "home_questionAnswerAlert_close"), for: .highlighted)
        btn.addTarget(self, action: #selector(closeBtnClickAction(_:)), for: .touchUpInside)
        return btn
    }()

    //标题
    private lazy var titleLb: UILabel = {
        let label = UILabel.makeLabel(text: "", font: UIFont.pingfangSemibold(size: 22), textColor: UIColor.fc_040404, alignment: .center, numberLine: 1)
        return label
    }()

    //分割线
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.fc_999999
        return view
    }()

    //分割线文案
    private lazy var lineTextLb: UILabel = {
        let label = UILabel.makeLabel(text: " Verify with Email  ", font: UIFont.pingfangSemibold(size: 22), textColor: UIColor.gray, alignment: .center, numberLine: 1)
        label.backgroundColor = .white
        return label
    }()

    private lazy var inputTF: UITextField = {
        let tf = UITextField()
        tf.cornerRadius(4)
        tf.border(UIColor.fc_999999, width: 1)
        tf.textAlignment = .right
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        tf.rightViewMode = .always
        tf.addTarget(self, action: #selector(textfieldChange(_:)), for: .editingChanged)
        return tf
    }()
    
    private lazy var tfLab: UILabel = {
        let lab = UILabel.makeLabel(text: " OTP ", font: UIFont.pingfangRegular(size: 18), textColor: UIColor.fc_4D4D4D, alignment: .center, numberLine: 1)
        lab.backgroundColor = .white
        return lab
    }()
    
    //确认按钮
    private lazy var confirmBtn: UIButton = {
        let btn = UIButton.makeButton(title: nil, titleFont: UIFont.pingfangSemibold(size: 15), titleColor: UIColor.white, image: nil, bgColor: UIColor.clear)
        btn.setTitle("Confirm", for: .normal)
        btn.setTitle("Confirm", for: .selected)
        btn.setTitle("Confirm", for: .disabled)
        btn.setTitleColor(UIColor.white, for: .disabled)
        btn.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        btn.cornerRadius(4)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(confirmBtnClickAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var tapGes: UITapGestureRecognizer = {
        let ges = UITapGestureRecognizer()
        self.isUserInteractionEnabled = true
        ges.addTarget(self, action: #selector(backgroundClickAction))
        return ges
    }()
    
    //确定按钮点击事件block
    public var confirmBtnClickBlock: (() -> ())?
    // 传入的数据
    private var itemModel: HpHomeItemModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.addGestureRecognizer(tapGes)
        self.addSubview(containerView)
        containerView.addSubview(closeBtn)
        containerView.addSubview(titleLb)
        containerView.addSubview(lineView)
        containerView.addSubview(lineTextLb)
        containerView.addSubview(inputTF)
        containerView.addSubview(tfLab)
        containerView.addSubview(confirmBtn)
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(370 + KBottomSafeArea)
            make.height.equalTo(370 + KBottomSafeArea)
        }
        
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        titleLb.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(30)
        }
        
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(150)
            make.height.equalTo(1)
        }
        
        lineTextLb.snp.makeConstraints { make in
            make.centerY.equalTo(lineView.snp.centerY)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        inputTF.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(lineTextLb.snp.bottom).offset(40)
            make.height.equalTo(50)
        }
        
        tfLab.snp.makeConstraints { make in
            make.left.equalTo(inputTF.snp.left).offset(15)
            make.centerY.equalTo(inputTF.snp.top)
            make.height.equalTo(30)
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-KBottomSafeArea-20)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
}

extension HpPresentView {
    //MARK: - 键盘通知
    @objc func keyboardWillShow(_ sender:Notification) {
        //获取键盘的frame
        guard let keyboardFrame = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue else {
            return
        }
        //获取动画执行的时间
        var duration = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        if duration == nil { duration = 0.25 }

        UIView.animate(withDuration: 0.25, delay: 0, options: .allowAnimatedContent, animations: {
            self.containerView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-keyboardFrame.height + KBottomSafeArea + 100)
            }
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func keyboardWillHide(_ sender:Notification) {
        UIView.animate(withDuration: 0.25, animations: {
            self.containerView.snp.updateConstraints { make in
                make.bottom.equalToSuperview()
            }
            self.layoutIfNeeded()
        })
    }
}

extension HpPresentView {
    
    @objc func textfieldChange(_ sender: UITextField) {
        if sender.text != itemModel.name {
            confirmBtn.isEnabled = true
            confirmBtn.backgroundColor = UIColor.red
        } else {
            confirmBtn.isEnabled = false
            confirmBtn.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        }
    }
}

extension HpPresentView {
    //MARK: - 显示消失
    static func show(title:String, model: HpHomeItemModel, confirmBlock:@escaping (() -> ())) {
        let view = HpPresentView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        view.alpha = 0
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.titleLb.text = "Confirm \(title)"
        view.inputTF.text = model.name
        view.itemModel = model
        view.confirmBtnClickBlock = confirmBlock
        UIApplication.shared.currentKeyWindow?.addSubview(view)
        
        view.containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(370 + KBottomSafeArea)
        }
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25) {
            view.containerView.snp.updateConstraints { make in
                make.bottom.equalToSuperview()
            }
            view.alpha = 1
            view.layoutIfNeeded()
        }
    }
    
    static func hide() {
        var preView:HpPresentView?
        let views:[UIView] = UIApplication.shared.currentKeyWindow?.subviews ?? []
        for view in views {
            if view is HpPresentView {
                preView = (view as! HpPresentView)
                break
            }
        }
        
        if let preSentView = preView {
            UIView.animate(withDuration: 0.25) {
                preSentView.containerView.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().offset(370 + KBottomSafeArea)
                }
                preSentView.alpha = 0
                preSentView.layoutIfNeeded()
            } completion: { finish in
                preSentView.removeFromSuperview()
            }
        }
    }
}

extension HpPresentView {
    //MARK: - 事件
    //“关闭”按钮事件
    @objc private func closeBtnClickAction(_ sender: UIButton) {
        HpPresentView.hide()
    }

    //“确认”按钮事件
    @objc private func confirmBtnClickAction(_ sender: UIButton) {
        itemModel.name = inputTF.text
        HpPresentView.hide()
        if let block = confirmBtnClickBlock {
            block()
        }
    }
    
    //背景点击事件
    @objc private func backgroundClickAction() {
        HpPresentView.hide()
    }
    
    @objc private func containerViewClickAction() {
        if self.inputTF.isFirstResponder {
            self.inputTF.resignFirstResponder()
        }
    }
}
