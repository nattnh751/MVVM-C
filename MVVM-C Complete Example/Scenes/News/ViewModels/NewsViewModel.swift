//
//  NewsViewModel.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
import RxSwift

protocol NewsViewModelCoordinatorDelegate {
  //implement
}
enum ArticleCellType {
    case normal(cellViewModel: ArticleCellViewModel)
    case error(message: String)
    case empty
}
class NewsViewModel {
  var coordinatorDelegate : NewsViewModelCoordinatorDelegate?
  var newsCells: Observable<[ArticleCellType]> {
      return cells.asObservable()
  }
}
