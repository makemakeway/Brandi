//
//  SearchViewModel.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import Foundation

import RxCocoa
import RxSwift

final class SearchViewModel: ViewModelType {
    
    struct Input {
        let searchText: BehaviorRelay<String> = BehaviorRelay(value: "")
        let pageNumber: BehaviorRelay<Int> = BehaviorRelay(value: 1)
        let endOfPage: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    }
    
    struct Output {
        let searchData: PublishRelay<SearchData> = PublishRelay<SearchData>()
        let errorMessage: PublishRelay<String> = PublishRelay<String>()
        let appendData: PublishRelay<SearchData> = PublishRelay<SearchData>()
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    
    func transform() {
        input.searchText
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .filter { !($0.isEmpty) }
            .distinctUntilChanged()
            .asObservable()
            .flatMap { KakaoAPIService.shared.fetchSearchResponse(query: $0) }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    owner.input.pageNumber.accept(1)
                    owner.output.searchData.accept(value)
                    if value.documents.isEmpty {
                        owner.output.errorMessage.accept(KakaoAPIService.APIError.emptyData.rawValue)
                    }
                case .failure(let error):
                    owner.output.errorMessage.accept(error.rawValue)
                }
            }
            .disposed(by: disposeBag)

        
        input.pageNumber
            .filter { $0 != 1 }
            .distinctUntilChanged()
            .withUnretained(self)
            .flatMap { owner, page in KakaoAPIService.shared.fetchSearchResponse(query: owner.input.searchText.value, page: page) }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    owner.output.appendData.accept(value)
                case .failure(let error):
                    owner.output.errorMessage.accept(error.rawValue)
                }
            }
            .disposed(by: disposeBag)
    }
    
    init() {
        transform()
    }
    
}
