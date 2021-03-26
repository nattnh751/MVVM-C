//
//  ArticleCollectionViewCell.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var articleTitle: UILabel!
  @IBOutlet weak var detail: UILabel!

  var viewModel: ArticleCellViewModel? {
      didSet {
          bindViewModel()
      }
  }

  private func bindViewModel() {
      if let viewModel = viewModel {
        articleTitle?.text = "\(viewModel.title)"
        detail?.text = viewModel.description
      }
  }

}
