//
//  Bundle+unitTest.swift
//  NewsAppTests
//
//  Created by Menna on 24.9.22.
//

import Foundation
extension Bundle{
    public class var unitTest: Bundle{
        return Bundle(for: ApiClintTests.self)
    }
}
