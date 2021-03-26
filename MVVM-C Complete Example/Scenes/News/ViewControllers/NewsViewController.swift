//
//  NewsViewController.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
import UIKit

class NewsViewController : UIViewController {
  var viewModel : NewsViewModel?
  private let disposeBag = DisposeBag()
  public override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
  }
  func bindViewModel() {
      viewModel.newsCells.bind(to: self.tableView.rx.items) { tableView, index, element in
          let indexPath = IndexPath(item: index, section: 0)
          switch element {
          case .normal(let viewModel):
              guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendTableViewCell else {
                  return UITableViewCell()
              }
              cell.viewModel = viewModel
              return cell
          case .error(let message):
              let cell = UITableViewCell()
              cell.isUserInteractionEnabled = false
              cell.textLabel?.text = message
              return cell
          case .empty:
              let cell = UITableViewCell()
              cell.isUserInteractionEnabled = false
              cell.textLabel?.text = "No data available"
              return cell
          }
      }.disposed(by: disposeBag)
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

}
