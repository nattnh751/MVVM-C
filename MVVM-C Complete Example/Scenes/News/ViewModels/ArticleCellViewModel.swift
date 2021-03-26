//
//  ArticleCellViewModel.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation

struct ArticleCellViewModel {
  var article : Article
}

extension ArticleCellViewModel {
  init(art: Article) {
    self.article = art
  }
}
