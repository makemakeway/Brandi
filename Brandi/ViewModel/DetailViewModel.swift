//
//  DetailViewModel.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/28.
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published var imageData: Data = Data()
    
    func fetchImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageData = data
            }
        }
        task.resume()
    }
    
    init() {
        
    }
}
