//
//  DashedBorderButton.swift
//  CurrencyConverter
//
//  Created by Dmitriy Opryatnov on 8.08.24.
//

import UIKit

class DashedBorderButton: UIButton {
    
    private var borderLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBorderLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBorderLayer()
    }
    
    private func setupBorderLayer() {
        borderLayer = CAShapeLayer()
        borderLayer?.strokeColor = UIColor(resource: .gold1).cgColor
        borderLayer?.fillColor = nil
        borderLayer?.lineDashPattern = [3, 3]
        borderLayer?.lineWidth = 1
        layer.addSublayer(borderLayer!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer?.path = UIBezierPath(roundedRect: bounds, cornerRadius: 17).cgPath
        borderLayer?.frame = bounds
    }
}
