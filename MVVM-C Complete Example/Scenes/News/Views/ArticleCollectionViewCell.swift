//
//  ArticleCollectionViewCell.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var articleTitle: UILabel!
  @IBOutlet weak var hero: UIImageView!
  @IBOutlet weak var detail: UITextView!
  @IBOutlet weak var date: UILabel!
  @IBOutlet weak var source: UILabel!
  
  var viewModel: ArticleCellViewModel? {
      didSet {
          bindViewModel()
      }
  }

  private func bindViewModel() {
      if let viewModel = viewModel {
        articleTitle?.text = "\(viewModel.article.title)"
        detail?.text = viewModel.article.description
      }
  }
  
  func didSelectFavorite() {
    viewModel?.favoriteButtonSelected()
  }
  
  func didUnSelectFavorite() {
    viewModel?.UnFavoriteButtonSelected()
  }
}
