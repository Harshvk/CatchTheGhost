//
//  GridCell.swift
//  CatchTheGhost
//
//  Created by Harsh Vardhan Kushwaha on 23/08/23.
//

import UIKit

class GridCell: UICollectionViewCell {

    @IBOutlet weak var gridImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gridImage.image = nil
        gridImage.layer.borderColor = UIColor.black.cgColor
        gridImage.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gridImage.image = nil
    }
    
    func setupImage(character: Character, isReload: Bool = false) {
        let delay = (isReload ? 0 : character.delay)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.gridImage.image = character.image
        }
    }
}

enum Character {
    case police
    case ghost
    case none
    
    var image: UIImage? {
        switch self {
        case .police:
            return UIImage(named: "policeman")
        case .ghost:
            return UIImage(named: "ghost")
        case .none:
            return nil
        }
    }
    
    var delay: Double {
        switch self {
        case .ghost:
            return 1
        default:
            return 0
        }
    }
}
