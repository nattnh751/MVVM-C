//
//  NewsViewModel.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol NewsViewModelViewModelType { //stuff that is used by the view controller should be declared here, anything else should be fileprivate in the actual class definition
  //data
  var newsCells: Observable<[ArticleCellType]> { get }
  // Events
  func start(_ delegate : ArticleCellViewModelViewControllerDelegate)

  func didSelectArticle(_ viewController : UIViewController, article : Article)
  
  func didFavoriteArticle(_ viewController : UIViewController, articleViewModel : ArticleCellViewModel)
  
  func didRemoveFavoriteArticle(_ viewController : UIViewController, articleViewModel : ArticleCellViewModel)

}

protocol NewsViewModelCoordinatorDelegate { //call back to the coordinator, any time the view controller wants to nabvigate it should go through its delegate and then here
  func didSelectArticle(_ viewController : UIViewController, article : Article, viewModel : NewsViewModel)
}

class NewsViewModel {
  var coordinatorDelegate : NewsViewModelCoordinatorDelegate?
  private let cells = BehaviorRelay<[ArticleCellType]>(value: [])
  let disposeBag = DisposeBag()
  let apiServer: ApiServer
  
  init(_ apiServer: ApiServer) {
    self.apiServer = apiServer
  }
  
  func start(_ delegate : ArticleCellViewModelViewControllerDelegate) {
    apiServer.getArticles().subscribe(
        onNext: { [weak self] articles in
            guard articles.count > 0 else {
                self?.cells.accept([.empty])
                return
            }

            self?.cells.accept(articles.compactMap { .normal(cellViewModel: ArticleCellViewModel(article: $0 , delegate)) }) //need to add a view model
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

extension NewsViewModel : NewsViewModelViewModelType {
  var newsCells: Observable<[ArticleCellType]> {
    get {
      return cells.asObservable()
    }
  }
  
  func didSelectArticle(_ viewController : UIViewController, article : Article) {
    coordinatorDelegate?.didSelectArticle(viewController, article: article, viewModel: self)
  }
  
  func didFavoriteArticle(_ viewController : UIViewController, articleViewModel : ArticleCellViewModel) {
    updateFavorite(articleViewModel, true)
  }
  
  func didRemoveFavoriteArticle(_ viewController : UIViewController, articleViewModel : ArticleCellViewModel) {
    updateFavorite(articleViewModel, false)
  }
  
  fileprivate func updateFavorite(_ vm : ArticleCellViewModel, _ isFavorite : Bool) {
    var oldItemsWithoutNewItem = self.cells.value.filter { item -> Bool in
      if let articleViewModel = ArticleCellType.getArticleViewModelOrNil(type: item) {
        return articleViewModel.article.id != vm.article.id
      }
      return false
    }
    vm.article.favorite = isFavorite
    oldItemsWithoutNewItem.append(.normal(cellViewModel: vm)) //this should never happen
    self.cells.accept(oldItemsWithoutNewItem)
  }
}
