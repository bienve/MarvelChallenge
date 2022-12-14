//
//  CharacterCollectionViewController.swift
//  MarvelChallenge
//
//  Created by 67881458 on 12/11/22.
//

import UIKit
import Combine

private let reuseIdentifier = "CharacterCollectionCell"

class CharacterCollectionViewController: UICollectionViewController {

    private let viewModel: CharacterCollectionViewModel
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    init?(coder: NSCoder, viewModel: CharacterCollectionViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.collectionView.collectionViewLayout = setupComicCollectionViewLayout()
        
        self.bindViewModel()
    }
    
    private func bindViewModel() {
        self.viewModel.$characterCount
            .receive(on: RunLoop.main)
            .sink {[weak self] _ in

                self?.collectionView.reloadData()
                
        }.store(in: &cancellables)
        
        self.viewModel.errorSubject
            .receive(on: RunLoop.main)
            .sink {[weak self] errorMessage in
                
                self?.showErrorDialog(message: errorMessage)
                
            }.store(in: &cancellables)
        
        self.viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink {[weak self] isLoading in
            
                if isLoading && self?.viewModel.characterCount == 0 {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
                
        }.store(in: &cancellables)
    }
    
    
    //MARK: -
    
    func showErrorDialog(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }

    // MARK: - COMPASABLE COLLECTION VIEW LAYOUT
    
    func setupComicCollectionViewLayout() -> UICollectionViewLayout {
        
        let inset: CGFloat = 8
        
        //Top horizontal item
        let bigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalWidth(9/16))
        
        let bigItem = NSCollectionLayoutItem(layoutSize: bigItemSize)
        bigItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset,
                                                        bottom: 0, trailing: inset)

        //Two small square items
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                   heightDimension: .fractionalHeight(1.0))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: inset / 2,
                                                          bottom: 0, trailing: inset / 2)

        let smallItemsGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                         heightDimension: .fractionalWidth(0.5))
        
        let smallItemsGroup = NSCollectionLayoutGroup.horizontal(layoutSize: smallItemsGroupSize,
                                                                 repeatingSubitem: smallItem, count: 2)
        smallItemsGroup.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset/2,
                                                                bottom: 0, trailing: inset/2)
       
        //Full group
        let fullGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(9/16 + 0.5))
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: fullGroupSize,
                                                           subitems: [bigItem, smallItemsGroup])
        
        //Section
        let section = NSCollectionLayoutSection(group: nestedGroup)
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.characterCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CharacterCollectionViewCell
    
        if let character = viewModel.getCharacter(index: indexPath.row) {
            cell.setup(with: character, offset: collectionView.contentOffset.y)
        } else {
            cell.setupError()
        }
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showCharacterDetail",
                          sender: self.viewModel.getCharacter(index: indexPath.row))
    }
    
    //MARK: SCROLL VIEW
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let visibleCells = collectionView.visibleCells as? [CharacterCollectionViewCell] else {
            return
        }
        
        visibleCells.forEach { cell in
            cell.updateCurrentScrollOffset(offset: collectionView.contentOffset.y)
        }
         
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoadingIndicatorCollectionReusableView", for: indexPath)
                    
                
            return footerView
        default:
            assert(false, "Unexpected collectionview element")
        }
    }
    
    //MARK: - NAVIGATION
    
    @IBSegueAction func makeCharacterDetailSegueAction(_ coder: NSCoder, sender: Any?) -> UIViewController? {
        
        guard let character = sender as? Character else {
            return nil
        }
        
        let characterDetailViewController = DependencyManager.shared()
            .provideCharacterDetailViewController(coder: coder,
                                                  character: character,
                                                  copyright: self.viewModel.copyrigyt ?? "")
        return characterDetailViewController
    }
    
    
}
