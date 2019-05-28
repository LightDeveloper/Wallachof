//
//  RequestResult.swift
//  Wallachof
//
//  Created by Dev2 on 27/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

enum RequestResult<T: Decodable> {
    case success(object: T)
    case error(APIClientError)
}
