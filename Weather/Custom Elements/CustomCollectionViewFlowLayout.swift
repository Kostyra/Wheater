import UIKit
//ПРОБОВАЛ не работает, буду рад если поможете
class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .horizontal
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        scrollDirection = .horizontal
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        
        if elementKind == UICollectionView.elementKindSectionHeader {
            attributes?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}




