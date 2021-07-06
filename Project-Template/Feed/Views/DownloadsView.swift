//
//  DownloadsView.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import SwiftUI
import AVFoundation

@available(iOS 14.0, *)
struct DownloadsView: View {
/*
     @StateObject var viewModel: VideoDetailsViewModelImpl
    
    @State private var downloadAmount = 5.0
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
 */
    

    
    init() {
        /*
        let video = Video.with(name: "Advanced Stream", description: "This is a heist. fasdfasd fasdf sf", videoLink: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")
        _viewModel = StateObject(wrappedValue: VideoDetailsViewModelImpl(video: video))
 */
    }
    
    var body: some View {
        VStack {
            Text("Goodbye, world")
        }
        .onAppear() {
            let urlPath = "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8"
            let video = Video.with(videoLink: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")
            let urlAsset = AVURLAsset(url: URL(fileURLWithPath:urlPath))
            let asset = Asset(video: video, urlAsset: urlAsset)
//            HLSAssetPersistenceManager.sharedManager.restorePersistenceManager()
            HLSAssetPersistenceManager.sharedManager.downloadVideo(for: asset)
 
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

