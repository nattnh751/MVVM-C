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
  @IBOutlet weak var favoriteButton: UIButton!

  var articleCellViewModel: ArticleCellViewModel? {
      didSet {
          bindViewModel()
      }
  }

  private func bindViewModel() {
      if let viewModel = articleCellViewModel {
        articleTitle?.text = "\(viewModel.article.title)"
        detail?.text = viewModel.article.description
        date?.text = viewModel.article.getDateFromCreatedAt()
        source?.text = viewModel.article.source
        hero?.load(url: viewModel.article.heroImage)
        if(viewModel.article.favorite) { 
          favoriteButton?.isHidden = true
        } else {
          favoriteButton?.isHidden = false

        }
      }
  }
  
  @IBAction func selectFavorite(_ sender: Any) {
    articleCellViewModel?.favoriteButtonSelected()
  }
  func didSelectFavorite() {
    articleCellViewModel?.favoriteButtonSelected()
  }
  
  func didUnSelectFavorite() {
    articleCellViewModel?.UnFavoriteButtonSelected()
  }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
