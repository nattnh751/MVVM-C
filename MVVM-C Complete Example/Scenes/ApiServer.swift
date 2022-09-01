//
//  ApiServer.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
import RxSwift

// MARK: - AppServerClient
class ApiServer {
    func getArticles() -> Observable<[Article]> {
      return Observable.create { observer -> Disposable in
            do {
              if let path = Bundle.main.path(forResource: "articles", ofType: "json") {
                let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let articles = try decoder.decode(Articles.self, from: jsonData)
                observer.onNext(articles.articles)
              }
            } catch {
              observer.onError(error)
            }
        return Disposables.create()
      }
    }
}
