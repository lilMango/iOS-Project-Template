//
//  VideoDetailView.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import Foundation
import SwiftUI
import AVKit
import Combine

@available(iOS 14.0, *)
struct VideoDetailView: View {
    
    @ObservedObject var viewModel: VideoDetailViewModelImpl
    
    @State private var downloadAmount = 0.0
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    init(vidDetailViewModel: VideoDetailViewModelImpl) {
        
//        viewModel = VideoDetailViewModelImpl(video: video)
//        _viewModel = StateObject(wrappedValue: VideoDetailViewModelImpl(video: video))
        viewModel = vidDetailViewModel
    }

    var body: some View {
        VStack {
            VStack {
                ProgressView("Downloading", value: downloadAmount, total: 100)
            }
            .onReceive(timer) { _ in
                if downloadAmount<100 {
                    downloadAmount+=1
                    
                } else {
                    downloadAmount = 0.0
                }
            }
            player(url: viewModel.video.videoLink)
                //.onDisappear(perform: player.) //TODO exiting screen still plays video
            //Text(vidurl)
            Text(viewModel.video.name)
                .fontWeight(.bold)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
                
            Text(viewModel.video.description)
            
        }
        .toolbar {
            VideoDetailToolbarView(viewModel: viewModel)
        }

            .padding(.leading,8)
            .padding(.trailing,8)
    }
}

struct player : UIViewControllerRepresentable {
    
    var url: String = ""
    
    init(url: String) {
        self.url = url
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<player>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        
        let player1 = AVPlayer(url: URL(string: url)!)
        controller.player = player1
        //player1.play()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<player>) {
        
    }
}

struct VideoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        if #available(iOS 14.0, *) {
            VideoDetailView( vidDetailViewModel: VideoDetailViewModelImpl( video:Video.with(name: "Title", description: "This is a heist. fasdfasd fasdf sf", videoLink: "URL")))
        } else {
            // Fallback on earlier versions
        }
    }
}
