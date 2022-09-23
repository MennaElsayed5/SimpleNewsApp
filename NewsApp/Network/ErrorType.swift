//
//  ErrorType.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import Foundation

enum ErrorType:Error {
    case InternalError
    case ServerError
    case parsingError
    case urlBadFormmated
}
