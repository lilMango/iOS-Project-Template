//
//  VideoDetailToolbarView.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import SwiftUI

struct VideoDetailToolbarView: View {
    @ObservedObject var viewModel: VideoDetailViewModelImpl
    
    init(viewModel: VideoDetailViewModelImpl) {
        self.viewModel = viewModel
    }
    
    var body: some View {
//        if let asset = viewModel.asset {
                        
            switch viewModel.downloadState {
            case .notDownloaded:
                Button("Download") {
                    HLSAssetPersistenceManager.sharedManager.downloadVideo(for: viewModel.asset!)
                }
            case .downloading:
                Button("Downloading:\(viewModel.downloadProgress)") {
                    HLSAssetPersistenceManager.sharedManager.cancelDownload(for: viewModel.asset!)
                }
            case .downloaded:
                Button("Delete") {
                    HLSAssetPersistenceManager.sharedManager.deleteAsset(viewModel.asset!)
                }
            }
                                    
//
//        } else {
//            Text("No viewModel.asset found")
//        }
        
        
        
        
//        Text("GEGEGE")
        //        .navigationBarItems(
        //            trailing:
        //            (vidloader.isStored == false ?
        //                HStack {
        //                    (vidloader.isDownloading ?
        //                        Button( "Cancel download \(vidloader.progressMeter) %") {
        //                            print("cancelling download")
        //                            self.vidloader.cancel()
        //                        }
        //                        :
        //                        Button("Download video") {
        //                            print("Downloading video...")
        //                            self.vidloader.download()
        //                        }
        //                    )
        //                    Image(systemName: "square.and.arrow.down")
        //                }
        //                :
        //                HStack {
        //                    Button("") {
        //                        print("already downloaded!")
        //                    }
        //                    Image(systemName: "")
        //                }
        //            )
        //        )
    }
}
