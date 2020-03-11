//
//  githubApiTests.swift
//  githubApiTests
//
//  Created by 福山帆士 on 2020/03/11.
//  Copyright © 2020 福山帆士. All rights reserved.
//

import XCTest
@testable import githubApi

class GithubApiTests: XCTestCase {

    let viewModel: ViewModel = ViewModel()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    // 非同期処理テスト
    func testDownloadUrl() {
        
        let downloadExpectation: XCTestExpectation = expectation(description: "download url")
        self.viewModel.fetchArticle(keyword: "Test", completion: { (GithubStruct) in
            
            // GithubStructがnillでなければ成功
            XCTAssertNotNil(GithubStruct)
            downloadExpectation.fulfill()
        })
        wait(for: [downloadExpectation], timeout: 1.0)
    }

}
