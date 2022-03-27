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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(document: Document(collection: "", thumbnailURL: "", imageURL: "", width: 1, height: 1, displaySitename: "", docURL: "", datetime: ""))
    }
}
