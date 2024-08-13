import UIKit

@IBDesignable
class StaticGradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = self.layer as? CAGradientLayer {
            gradientLayer.colors = [
                UIColor.red.cgColor,
                UIColor.green.cgColor,
                UIColor.blue.cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
    }
}
