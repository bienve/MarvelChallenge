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
        thumbImageView.kf.cancelDownloadTask()
        backgroundImageView.image = nil
        thumbImageView.image = nil
    }

    func setup(with character: Character, offset: CGFloat) {
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.darkGray.cgColor
        
        thumbImageView.clipsToBounds = false
        
        self.nameLabel.text = character.name
        
        if let thumbUrl = character.getThumbnailUrl(preferredVariant: CharacterCollectionViewCell.preferredImageVariant) {

            thumbImageView.kf.setImage(
                with: thumbUrl,
                options: [
                    .transition(ImageTransition.fade(0.5))]) {[weak self] result in
                    
                        if case .failure( _) = result {
                            self?.setupError()
                        }

                }
            
            backgroundImageView.kf.setImage(
                with: thumbUrl,
                options: [
                    .transition(ImageTransition.fade(0.5))])
            
        } else {
            setupError()
        }
        
        updateCurrentScrollOffset(offset: offset)
        
    }
    
    func setupError() {
        self.thumbImageView.image = UIImage(named: "imageError")
    }
    
    public func updateCurrentScrollOffset(offset: CGFloat) {
        self.currentScrollOffset = ((offset - frame.origin.y) / bounds.height) * 10
        self.thumbImageView.transform = CGAffineTransformMakeTranslation(0, currentScrollOffset)
    }
}

