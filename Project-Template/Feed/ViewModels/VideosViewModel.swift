//
//  VideosViewModel.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import Foundation
import Combine

protocol VideosViewModel {
    func getVideos()
}

class VideosViewModelImpl: ObservableObject, VideosViewModel {
    
    private let service: VideosService
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    private(set) var videos = [Video]() //get is public, set is private
    
    init(service: VideosService) {
        self.service = service
    }
    
    func getVideos() {
        
        self.state = .loading
        
        service
            .request(from: K.IPS_VIDEOS_URL)
            .sink { completion in
                switch completion {
                case .finished:
                    self.state = .success(content: self.videos) //emit @published event
                    break
                case .failure(let error):
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { response in
                self.videos = response.videos
                self.videos = [Video.with(id:"0", name: "iPS Video",thumbnail: "https://placeimg.com/640/640/nature", description: "iPS video", videoLink:            "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"),
                               Video.with(id:"1", name: "Basic StreamChangeViewModel",thumbnail: "https://placeimg.com/640/640/nature", description: "Lorem ipsum", videoLink: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"),
                               Video.with(id:"2", name: "Advanced Stream iPS",thumbnail: "https://placeimg.com/640/640/nature", description: "Advanced Stream Bideo", videoLink: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8"),
                               Video.with(id:"3", name: "Advanced Stream",thumbnail: "https://placeimg.com/640/640/nature", description: "Looking directly at the Local file URL stored via HLS example.", videoLink: "file:///private/var/mobile/Containers/Data/Application/1275C76C-EB60-4007-98AF-AB90D00AB55B/Library/com.apple.UserManagedAssets.XgAq9a/Advanced%2520Stream_8AE7EB4F4CD5FEC6.movpkg/")
                
                
                ]
//
            }
            .store(in: &cancellables)
             
    }
}
