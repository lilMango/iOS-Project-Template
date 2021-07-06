//
//  VideoListItemView.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import Foundation
import SwiftUI
import URLImage

@available(iOS 14.0, *)
struct VideoListItemView: View {

    @StateObject var viewModel: VideoDetailViewModelImpl
    
    init(video: Video) {
        
//        viewModel = VideoDetailsViewModelImpl(video: video)
        _viewModel = StateObject(wrappedValue: VideoDetailViewModelImpl(video: video))
//        viewModel = vidDetailViewModel
    }
    
    var body: some View {
        NavigationLink(destination: VideoDetailView(vidDetailViewModel: viewModel ) ) {
            HStack {
                URLImage(URL(string: viewModel.video.thumbnail)!) {_ in
                } failure: { error, _ in
                            Image(systemName: "photo.fill")
                                .foregroundColor(.white)
                                .background(Color.gray)
                            
                } content: { image, info in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                }
            
                Text("\(viewModel.video.name)")
            }
        }
    }
}
