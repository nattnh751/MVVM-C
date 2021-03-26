//
//  NewsViewController.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
import UIKit
import RxSwift

class NewsViewController : UIViewController, UICollectionViewDelegateFlowLayout {
  var viewModel : NewsViewModel?
  let disposeBag = DisposeBag()
  @IBOutlet var collectionView: UICollectionView!

  public override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
  }
  func bindViewModel() {
    if let model = viewModel {
      model.newsCells.bind(to: self.collectionView.rx.items) { collectionView, index, element in
        let indexPath = IndexPath(item: index, section: 0)
        switch element {
        case .normal(let viewModel):
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleCollectionViewCell else {
              return UICollectionViewCell()
          }
          cell.viewModel = viewModel
          return cell
        case .error(let message):
          let cell = UICollectionViewCell()
          cell.isUserInteractionEnabled = false
          return cell
        case .empty:
          let cell = UICollectionViewCell()
          cell.isUserInteractionEnabled = false
          return cell
        }
      }.disposed(by: disposeBag)
      self.collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
   
//
//      viewModel
//          .onShowError
//          .map { [weak self] in self?.presentSingleButtonDialog(alert: $0)}
//          .subscribe()
//          .disposed(by: disposeBag)
//
//      viewModel
//          .onShowLoadingHud
//          .map { [weak self] in self?.setLoadingHud(visible: $0) }
//          .subscribe()
//          .disposed(by: disposeBag)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let width = collectionView.bounds.width
      let cellWidth = (width - 30) / 1 // compute your cell width
      return CGSize(width: cellWidth, height: 150)
  }
}
