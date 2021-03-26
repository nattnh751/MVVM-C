//
//  NewsViewModel.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
import RxSwift
import RxCocoa
	
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
  private let cells = BehaviorRelay<[ArticleCellType]>(value: [])
  let disposeBag = DisposeBag()
  private let loadInProgress = BehaviorRelay(value: false)
  let apiServer: ApiServer
  var newsCells: Observable<[ArticleCellType]> {
      return cells.asObservable()
  }
  
  init(_ apiServer: ApiServer) {
    self.apiServer = apiServer
    populateMockData()
  }
  
  func populateMockData() {
    apiServer.getArticles().subscribe(
        onNext: { [weak self] articles in
            guard articles.count > 0 else {
                self?.cells.accept([.empty])
                return
            }

            self?.cells.accept(articles.compactMap { .normal(cellViewModel: ArticleCellViewModel(article: $0 )) })
        },
        onError: { [weak self] error in
            self?.cells.accept([
                .error(
                    message: "Loading failed, check network connection"
                )
            ])
        }
    )
    .disposed(by: disposeBag)
  }
}
