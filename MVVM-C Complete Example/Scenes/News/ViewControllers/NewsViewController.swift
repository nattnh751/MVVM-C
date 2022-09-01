//
//  NewsViewController.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
import UIKit
import RxSwift

class NewsViewController : UIViewController {
  let disposeBag = DisposeBag()
  @IBOutlet var collectionView: UICollectionView!
  var newsViewModel: NewsViewModelViewModelType? {
      didSet {

      }
  }
  public override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.collectionViewLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    bindViewModel()
    newsViewModel?.start(self)
  }
  
  func bindViewModel() {
    self.collectionView.register(UINib(nibName: "ArticleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "articleCell")
    if let model = newsViewModel {
      model.newsCells.bind(to: self.collectionView.rx.items(cellIdentifier: "articleCell", cellType: ArticleCollectionViewCell.self)) { index, element, cell in
        if let vm = ArticleCellType.getArticleViewModelOrNil(type: element) {
          cell.articleCellViewModel = vm
        } else {
          cell.isUserInteractionEnabled = false
        }
      }.disposed(by: disposeBag)
    }
    
    self.collectionView.rx.modelSelected(ArticleCellType.self).subscribe(onNext: { art in
      switch art {
      case .normal(let articleViewModel):
        if let model = self.newsViewModel {
          model.didSelectArticle(self, article: articleViewModel.article)
        }
      case .error(let message):
        print(message)
      case .empty:
        print("empty")
      }
    }).disposed(by: disposeBag)
    self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
  }

}

extension NewsViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width
    let cellWidth = (width) / 1
    return CGSize(width: cellWidth, height: 150)
  }
}

extension NewsViewController : ArticleCellViewModelViewControllerDelegate {
  
  func UnFavoriteSelected(_ articleViewModel: ArticleCellViewModel) {
    if let model = self.newsViewModel {
      model.didRemoveFavoriteArticle(self, articleViewModel: articleViewModel)
    }
  }
  
  func favoriteSelected(_ articleViewModel : ArticleCellViewModel) {
    if let model = self.newsViewModel {
      model.didFavoriteArticle(self, articleViewModel: articleViewModel)
    }
  }
  
}
