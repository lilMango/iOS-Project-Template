//
//  VideoDetailViewModel.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import Foundation
import Combine
import AVFoundation

protocol VideoDetailViewModel {
    func setDownloadState(downloadState: Asset.DownloadState)
    func setDownloadProgress(downloadProgress: Int)
}

class VideoDetailViewModelImpl: ObservableObject, VideoDetailViewModel{
    
    @Published private(set) var downloadState: Asset.DownloadState = .notDownloaded
    @Published private(set) var downloadProgress = 0
    @Published private(set) var asset: Asset?
    
    var video: Video
    
    init(video: Video) {
        self.video = video
        
        if let asset = HLSAssetPersistenceManager.sharedManager.localAssetForVideo(withName: video.name) {
            downloadState = HLSAssetPersistenceManager.sharedManager.downloadState(for: asset)
        } else {
            let urlAsset = AVURLAsset(url: URL(fileURLWithPath:video.videoLink))
            
            self.asset = Asset(video: video, urlAsset: urlAsset)
        }
        
        // set observers to get progress and state changes via Notification Handler
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(handleAssetDownloadStateChanged(_:)),
                                       name: .AssetDownloadStateChanged, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleAssetDownloadProgress(_:)),
                                       name: .AssetDownloadProgress, object: nil)
    }
    
    
    func setDownloadState(downloadState: Asset.DownloadState) {
        self.downloadState = downloadState
    }
    
    func setDownloadProgress(downloadProgress: Int) {
        self.downloadProgress = downloadProgress
    }
    
    
    // MARK: Notification handling

    /// The Notification center has updated Download state  on the particular Asset.key.name
    @objc
    func handleAssetDownloadStateChanged(_ notification: Notification) {
        guard let assetVideoName = notification.userInfo![Asset.Keys.name] as? String,
            let downloadStateRawValue = notification.userInfo![Asset.Keys.downloadState] as? String,
            let downloadState = Asset.DownloadState(rawValue: downloadStateRawValue),
            let asset = asset, asset.video.name == assetVideoName else { return }
        
        setDownloadState(downloadState: downloadState)
    }

    /// The Notification center has updated download Progress  on the particular Asset.key.name
    @objc
    func handleAssetDownloadProgress(_ notification: NSNotification) {
        guard let assetVideoName = notification.userInfo![Asset.Keys.name] as? String,
            let asset = asset, asset.video.name == assetVideoName else { return }
        guard let progress = notification.userInfo![Asset.Keys.percentDownloaded] as? Double else { return }

        let roundedProgress = Int(Double(progress) * 100.0)
//        let divisor = pow(10.0, Double(2)) //'2' decimal places
//        let roundedProgress =  (Double(progress) * divisor).rounded() / divisor
        
        setDownloadProgress(downloadProgress: roundedProgress)
    }
}
