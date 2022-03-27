//
//  ViewModelType.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import Foundation

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
}
