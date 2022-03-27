//
//  DetailView.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/28.
//

import SwiftUI

import Kingfisher

struct DetailView: View {
    @Environment(\.presentationMode) var mode
    @ObservedObject private var viewModel = DetailViewModel()
    @State var image: UIImage? = UIImage(named: "placeholder")
    let document: Document
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.vertical)
            GeometryReader { reader in
                VStack(alignment: .leading) {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            if #available(iOS 14.0, *) {
                                KFImage(URL(string: document.imageURL))
                                    .placeholder({
                                        Image("placeholder")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    })
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                            } else {
                                Image(uiImage: image ?? UIImage(named: "placeholder")!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .onReceive(viewModel.$imageData) { data in
                                        self.image = UIImage(data: data)
                                    }
                                    .onAppear {
                                        viewModel.fetchImage(url: document.imageURL)
                                    }
                            }
                            Text(document.displaySitename)
                            Text(document.datetime)
                                .padding(.bottom)
                        }
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
