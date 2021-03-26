//
//  ArticleCellViewModel.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation

struct ArticleCellViewModel {
  var title : String
  var description : String
}

extension ArticleCellViewModel {
    init(article: Article) {
      self.title = article.title
      self.description = article.description
    }
}
