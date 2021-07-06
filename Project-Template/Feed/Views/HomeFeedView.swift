//
//  HomeFeedView.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import SwiftUI

struct HomeFeedView: View {
    
    @StateObject var viewModel = VideosViewModelImpl(service: VideosServiceImpl())
    @State var viewHasLoaded = false //prevents infinite loop of:
                                    //getVideos() -> StateObject Redraw -> getVideos() -> StateObject redraw
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                LoadingListView()
            case .failed(let error):
                NetworkErrorView(error: error, handler: viewModel.getVideos)
            case .success(let videos) :
                NavigationView {
                    List(videos) { vid in

                        if #available(iOS 14.0, *) {
                            VideoListItemView(video: vid)
                        } else {
                            // Fallback on earlier versions
                        }

                    }
                    .navigationBarTitle("Videos")
                }
            }

        }.onAppear {

            if !viewHasLoaded {
                viewModel.getVideos()
                viewHasLoaded = true
            }
        }
    }
}

struct HomeFeedView_Previews: PreviewProvider {
    static var previews: some View {
//        HomeFeedView(viewModel: VideosViewModelImpl(service: VideosServiceImpl()))
        HomeFeedView().environmentObject(VideosViewModelImpl(service: VideosServiceImpl()))
    }
}
