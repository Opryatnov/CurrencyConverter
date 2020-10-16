//
//  SkyFloatingView.swift
//  Fx_Invest
//
//  Created by Dimon on 3/31/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit
import SwiftTheme
import SnapKit

enum SkyFloatingViewType: Equatable {
    case normal
    case password
    case dropdown
}

enum SkyFloatingViewState: Equatable {
    case active
    case inactive
    case valid
    case disable
    case disableGray
    case showError(_ text: String)
    case showInfo(_ text: String)
}

class SkyFloatingView: UIView {
    
    @IBOutlet weak var textField: SkyFloatingLabelTextField!
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var textFieldLeftConstraint: NSLayoutConstraint!
    
    var validationType: ValidationFieldType = .none
//    var stringMask: JMStringMask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    var state = SkyFloatingViewState.inactive {
        didSet {
            configureUI()
        }
    }
    
    var type = SkyFloatingViewType.normal {
        didSet {
            updateType()
        }
    }
    
    var isValid: Bool {
        get {
            return Validator.isValid(textField.text ?? "", type: validationType)
        }
    }
    
    var isEmpty: Bool {
        get {
            return textField.hasText
        }
    }
    
    private func configureView() {
        if self.subviews.count > 0 {
            return
        }
        let view = Bundle.main.loadNibNamed(String(describing: SkyFloatingView.self), owner: self, options: nil)?.first as! UIView
        view.backgroundColor = .clear
        self.addSubview(view)
        view.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(self)
        }
        configureUI()
        addEditingChangedObserver()
    }
    
    private func updateType() {
        switch type {
        case .normal:
            actionButton.isHidden = true
            textFieldLeftConstraint.constant = 16
        case .password:
            textField.isSecureTextEntry = true
            actionButton.isHidden = false
            actionButton.setImage(#imageLiteral(resourceName: "ic_visibility_off"), for: .normal)
            actionButton.tintColor = .black
            actionButton.isUserInteractionEnabled = true
            textFieldLeftConstraint.constant = 36
        case .dropdown:
            actionButton.isHidden = false
            actionButton.setImage(#imageLiteral(resourceName: "ic_arrow_drop_down"), for: .normal)
            actionButton.isUserInteractionEnabled = false
            textFieldLeftConstraint.constant = 16
        }
    }
    
    private func configureUI() {
        self.isUserInteractionEnabled = state != .disable && state != .disableGray
        textFieldContainerView.layer.borderWidth = 1.0
        textFieldContainerView.layer.theme_borderColor = ThemeCGColorPicker.pickerWithColors(colorForState())
        textFieldContainerView.layer.cornerRadius = 4.0
        showStatusLabel()
        if state == .disableGray {
            textFieldContainerView.theme_backgroundColor = ThemeColorPicker.pickerWithColors(ColorElement.textfieldDisableGray)
            textField.mainTextColor = textField.selectedTitleColor
        }
    }
    
    fileprivate func addEditingChangedObserver() {
        textField.addTarget(self, action: #selector(SkyFloatingView.editingChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(SkyFloatingView.editingDidBegin), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(SkyFloatingView.editingDidEnd), for: .editingDidEnd)
    }
    
    @objc func editingDidBegin() {
        state = .active
    }
    
    @objc func editingDidEnd() {
        state = .inactive
    }
    
    @IBAction func actionButtonClicked() {
        if type == .password {
            if textField.isSecureTextEntry {
                textField.isSecureTextEntry = false
                actionButton.setImage(#imageLiteral(resourceName: "ic_visibility"), for: .normal)
            } else {
                textField.isSecureTextEntry = true
                actionButton.setImage(#imageLiteral(resourceName: "ic_visibility_off"), for: .normal)
            }
        }
    }
    
    @objc open func editingChanged() {
        
    }
    
    private func colorForState() -> [String] {
        switch state {
        case .active, .showInfo(_):
            return ColorElement.themeGoldTextfieldActive
        case .disable:
            return ColorElement.textfieldDisable
        case .disableGray:
            return ColorElement.textfieldDisable
        case .valid:
            return ColorElement.textfieldSuccess
        case .inactive:
            return ColorElement.textfieldInactive
        case .showError(_):
            return ColorElement.textfieldError
        }
    }
    
    private func showStatusLabel() {
        switch state {
        case .showInfo(let text):
            statusLabel.text = text
            statusLabel.isHidden = false
            statusLabel.theme_textColor = ThemeColorPicker.pickerWithColors(colorForState())
            textField.selectedTitleColor = ColorElement.textfieldInactive
            break
        case .showError(let text):
            statusLabel.text = text
            statusLabel.isHidden = false
            statusLabel.theme_textColor = ThemeColorPicker.pickerWithColors(colorForState())
            textField.selectedTitleColor = ColorElement.textfieldErrorLight
            break
        default:
            statusLabel.isHidden = true
            statusLabel.theme_textColor = ThemeColorPicker.pickerWithColors(colorForState())
            textField.selectedTitleColor = ColorElement.textfieldInactive
            break
        }
    }
}
