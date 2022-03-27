//
//  SearchViewController.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

final class SearchViewController: UIViewController {
    
    //MARK: Properties
    private let viewModel: SearchViewModel = SearchViewModel()
    private var disposeBag: DisposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Document>!
    
    //MARK: UI
    let mainView = SearchView()
    
    //MARK: Method
    
    private func bind() {
        //MARK: Input binding
        mainView.searchBar.rx.text.orEmpty
            .bind(to: viewModel.input.searchText)
            .disposed(by: disposeBag)
        
        mainView.collectionView.rx.willDisplayCell
            .bind(with: self) { owner, args in
                let indexPath = args.at
                owner.fetchNextPage(indexPath: indexPath.item)
            }
            .disposed(by: disposeBag)
        
        //MARK: Output binding
        viewModel.output.errorMessage
            .bind(with: self) { owner, message in
                owner.mainView.makeToast(message, duration: 2.0, position: .center)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.searchData
            .bind(with: self) { owner, data in
                var snapShot = NSDiffableDataSourceSnapshot<Section, Document>()
                snapShot.appendSections([.first])
                snapShot.appendItems(data.documents, toSection: .first)
                owner.dataSource.apply(snapShot, animatingDifferences: true) {
                    if !(data.documents.isEmpty) {
                        owner.mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.output.appendData
            .bind(with: self) { owner, data in
                var snapShot = owner.dataSource.snapshot()
                snapShot.appendItems(data.documents)
                owner.dataSource.apply(snapShot)
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchNextPage(indexPath: Int) {
        let currentPage = viewModel.input.pageNumber.value
        
        if (currentPage * Constants.Page.size) - 1 == indexPath {
            viewModel.input.pageNumber.accept(currentPage + 1)
        }
    }
    
    func dataSourceConfig() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Document>(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configure(url: itemIdentifier.thumbnailURL)
            
            return cell
        })
    }
    
    
    //MARK: LifeCycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        dataSourceConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = mainView.searchBar
        bind()
    }
}
