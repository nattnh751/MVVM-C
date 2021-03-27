//
//  ArticleCellViewModel.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
enum ArticleCellType {
    case normal(cellViewModel: ArticleCellViewModel)
    case error(message: String)
    case empty
}
protocol ArticleCellViewModelDelegate {
  func favoriteButtonSelected()
  func UnFavoriteButtonSelected()
}

protocol ArticleCellViewModelViewControllerDelegate {
  func favoriteSelected(_ article : Article)
  func UnFavoriteSelected(_ article : Article)
}

class ArticleCellViewModel { //  need to change this to look like the NewsViewModel and make it have a delegate that will live between the viewcontroller showing it and each of it's cells
  var article : Article
  var viewControllerDelegate : ArticleCellViewModelViewControllerDelegate?
  init(article: Article) {
    self.article = article
  }
}

extension ArticleCellViewModel : ArticleCellViewModelDelegate {
  func favoriteButtonSelected() {
    if let delegate = viewControllerDelegate {
      delegate.favoriteSelected(self.article)
    }
  }
  func UnFavoriteButtonSelected() {
    if let delegate = viewControllerDelegate {
      delegate.UnFavoriteSelected(self.article)
    }
  }
}
