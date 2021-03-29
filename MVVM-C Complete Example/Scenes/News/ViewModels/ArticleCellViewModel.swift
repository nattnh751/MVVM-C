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
  func favoriteSelected(_ articleCellViewModel : ArticleCellViewModel)
  func UnFavoriteSelected(_ articleCellViewModel : ArticleCellViewModel)
}

class ArticleCellViewModel { //  need to change this to look like the NewsViewModel and make it have a delegate that will live between the viewcontroller showing it and each of it's cells
  var article : Article
  var viewControllerDelegate : ArticleCellViewModelViewControllerDelegate
  init(article: Article, _ delegate: ArticleCellViewModelViewControllerDelegate) {
    self.article = article
    self.viewControllerDelegate = delegate
  }
}

extension ArticleCellViewModel : ArticleCellViewModelDelegate {
  func favoriteButtonSelected() {
    viewControllerDelegate.favoriteSelected(self)
  }
  func UnFavoriteButtonSelected() {
    viewControllerDelegate.UnFavoriteSelected(self)
  }
}
