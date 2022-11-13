//
//  CharacterDetailViewController.swift
//  MarvelChallenge
//
//  Created by 67881458 on 12/11/22.
//

import UIKit
import Combine
import Kingfisher

class CharacterDetailViewController: UIViewController {
    
    private var viewModel: CharacterDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameLabel: StrokeTextLabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var descriptionBackView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var comicsTabItem: UITabBarItem!
    @IBOutlet weak var seriesTabItem: UITabBarItem!
    @IBOutlet weak var storiesTabItem: UITabBarItem!
    @IBOutlet weak var eventsTabItem: UITabBarItem!
    
    init?(coder: NSCoder, viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.layer.borderColor = UIColor.black.cgColor
        self.imageView.layer.borderWidth = 3
        self.descriptionBackView.layer.borderColor = UIColor.black.cgColor
        self.descriptionBackView.layer.borderWidth = 1
        
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        
        self.viewModel.$imageURL
            .receive(on: RunLoop.main)
            .sink { url in
                
                self.imageView.kf.setImage(with: url) {[weak self] result in
                    
                    switch result {
                    case .success(let image):
                        self?.backgroundImage.image = image.image
                    case .failure(let error):
                        print(error)
                    }

                }
                
        }.store(in: &cancellables)
        
        self.viewModel.$characterName.assign(to: \.text, on: self.nameLabel).store(in: &cancellables)
        self.viewModel.$characterDescription.assign(to: \.text, on: self.descriptionLabel).store(in: &cancellables)
        
        self.viewModel.$comics.map({"\($0 ?? 0)"}).assign(to: \.badgeValue, on: self.comicsTabItem).store(in: &cancellables)
        self.viewModel.$series.map({"\($0 ?? 0)"}).assign(to: \.badgeValue, on: self.seriesTabItem).store(in: &cancellables)
        self.viewModel.$stories.map({"\($0 ?? 0)"}).assign(to: \.badgeValue, on: self.storiesTabItem).store(in: &cancellables)
        self.viewModel.$events.map({"\($0 ?? 0)"}).assign(to: \.badgeValue, on: self.eventsTabItem).store(in: &cancellables)
        
        self.viewModel.$copyright.assign(to: \.text, on: self.copyrightLabel).store(in: &cancellables)
        
    }
    

}

extension CharacterDetailViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let alert = UIAlertController(title: "Not implemented", message: "Not implemented yet", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        self.present(alert, animated: true)
        
    }
    
}
