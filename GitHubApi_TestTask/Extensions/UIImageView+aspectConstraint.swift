import UIKit

extension UIImageView {
    var aspectConstraint: NSLayoutConstraint? {
        guard let image = image else { return nil }
        let aspect = image.size.width / image.size.height
        return NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: aspect,
            constant: 0.0
        )
    }
}

