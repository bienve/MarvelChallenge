//
//  CharacterCollectionViewCell.swift
//  MarvelChallenge
//
//  Created by 67881458 on 12/11/22.
//

import UIKit
import Kingfisher

class CharacterCollectionViewCell: UICollectionViewCell {
    
    private static let preferredImageVariant: String = "standard_fantastic"
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nameLabel: StrokeTextLabel!
    
    private var currentScrollOffset: CGFloat = 0
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.kf.cancelDownloadTask()
        backgroundImageView.image = nil
        thumbImageView.image = nil
    }

    func setup(with character: Character, offset: CGFloat) {
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.darkGray.cgColor
        
        thumbImageView.clipsToBounds = false
        
        self.nameLabel.text = character.name
        
        if let thumbUrl = character.getThumbnailUrl(preferredVariant: CharacterCollectionViewCell.preferredImageVariant) {

            backgroundImageView.kf.setImage(
                with: thumbUrl) {[weak self] result in
                    
                    switch result {
                    case .success(let image):
                        self?.thumbImageView.image = image.image
                    case .failure(let error):
                        self?.setupError()
                        print(error)
                    }
                    
                }
            
            updateCurrentScrollOffset(offset: offset)
            
        } else {
            setupError()
        }
        
    }
    
    func setupError() {
        
    }
    
    public func updateCurrentScrollOffset(offset: CGFloat) {
        self.currentScrollOffset = ((offset - frame.origin.y) / bounds.height) * 10
        self.thumbImageView.transform = CGAffineTransformMakeTranslation(0, currentScrollOffset)
    }
}

