//
//  VideoViewModelTests.swift
//  Project-TemplateTests
//
//  Created by Miguel Paysan on 7/5/21.
//

@testable import Project_Template
import XCTest
import Combine

extension ResultState {
    public static func == (lhs: ResultState, rhs: ResultState) -> Bool {
        switch (lhs, rhs) {
        case let (.loading, .loading):
            return true
        case  let (.success(a), .success(b)):
            return a.count == b.count
        case let (.failed(_), .failed(_)):
            return true
        default:
            return false
        }
    }
}

class VideosViewModelTests: XCTestCase {
    func testSuccess_getVideos() {
        let mockService = MockServiceImpl()
        
        let viewModel = VideosViewModelImpl(service: mockService)
        
        XCTAssertEqual(viewModel.videos.count, 0)
        XCTAssertTrue(viewModel.state == ResultState.loading )
        
        viewModel.getVideos()
        
        XCTAssertEqual(viewModel.videos.count, 2)
        XCTAssertTrue(viewModel.state == ResultState.success(content: PostResponse.mockVideosArray()) )
    }
    
    func testGetVideos_DecodeError() {
        let mockService = DecodeErrorMockServiceImpl()
        
        let viewModel = VideosViewModelImpl(service: mockService)
        
        XCTAssertEqual(viewModel.videos.count, 0)
        XCTAssertTrue(viewModel.state == ResultState.loading )
        
        viewModel.getVideos()
        
        switch viewModel.state {
        case .loading:
            XCTFail("Should be APIError.decodingError")
        case .failed(let error):
            XCTAssertEqual("\(error)",  "decodingError")
        case .success(let _) :
            XCTFail("Should be APIError.decodingError")
        }
    }
    
    func testGetVideos_ResponseErrorCode400() {
        let mockService = ErrorCodeMockServiceImpl()
        let viewModel = VideosViewModelImpl(service: mockService)
        
        XCTAssertEqual(viewModel.videos.count, 0)
        XCTAssertTrue(viewModel.state == ResultState.loading )
        
        viewModel.getVideos()
        
        switch viewModel.state {
        case .loading:
            XCTFail("Should be APIError.errorCode")
        case .failed(let error):
            switch error {
            case APIError.decodingError:
                XCTFail("Expected Response Error, got decodingError")
            case APIError.errorCode(let code):
                XCTAssertEqual(code, 400)
            case APIError.unknown:
                XCTFail("Expected Response Error(400), got unknown error")
            default:
                XCTFail("Expected Response Error(400), got default error")
            }
        case .success(let _) :
            XCTFail("Should be APIError.errorCode")
        }
    }
    
    func testGetVideos_UnknownError() {
        let mockService = UnknownErrorMockServiceImpl()
        let viewModel = VideosViewModelImpl(service: mockService)
        
        XCTAssertEqual(viewModel.videos.count, 0)
        XCTAssertTrue(viewModel.state == ResultState.loading )
        
        viewModel.getVideos()
        
        switch viewModel.state {
        case .loading:
            XCTFail("Should be APIError.Unknown")
        case .failed(let error):
            switch error {
            case APIError.decodingError:
                XCTFail("Expected Unknown Error, got decodingError")
            case APIError.errorCode(let code):
                XCTFail("Expected Unknown Error, got ErrorCode(\(code))")
            case APIError.unknown:
                XCTAssertTrue(true)
            default:
                XCTFail("Expected Unknown Error, got default error")
            }
        case .success(let _) :
            XCTFail("Should be APIError.Unknown")
        }
    }
}
