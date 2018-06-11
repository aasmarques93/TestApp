//
//  EnvironmentManager.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Moya

// MARK: - Environment Base Enum -
enum EnvironmentBase: String {
    case theMovieDB
    case imagesTheMovieDB
    case mock
    
    var path: String {
        return FileManager.load(file: .environmentLink, key: rawValue)
    }
}

struct RequestBase {
    var requestUrl: RequestUrl?
    var environmentBase: EnvironmentBase
    var customPath: String?
    var moyaMethod: Moya.Method
    var urlParameters: [String: Any]?
    var parameters: [String: Any]?
    var data: Data
    var requestHeaders: [String: String]?
    
    init(requestUrl: RequestUrl? = nil,
         environmentBase: EnvironmentBase,
         customPath: String? = nil,
         method: Moya.Method,
         urlParameters: [String: Any]? = nil,
         parameters: [String: Any]? = nil,
         sampleData: Data = Data(),
         headers: [String: String]? = nil) {
        
        self.requestUrl = requestUrl
        self.environmentBase = environmentBase
        self.customPath = customPath
        self.moyaMethod = method
        self.urlParameters = urlParameters
        self.parameters = parameters
        self.data = sampleData
        self.requestHeaders = headers
    }
}

extension RequestBase: TargetType {
    var baseURL: URL {
        return URL(string: environmentBase.path) ?? URL(string: "")!
    }
    var path: String {
        guard let customPath = customPath else {
            return requestUrl?.url(environmentBase: environmentBase, parameters: urlParameters) ?? ""
        }
        return customPath
    }
    var method: Moya.Method {
        return moyaMethod
    }
    var sampleData: Data {
        return data
    }
    var task: Task {
        guard method == .post, let parameters = parameters else {
            return .requestPlain
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    var headers: [String: String]? {
        return requestHeaders
    }
}

// MARK: - Request Link Enum -
enum RequestUrl: String {
    case apiKey
    case nowPlaying
    case upcoming
    case topRated
    case popular
    case movie
    case recommendations
    case reviews
    case searchMovie
    case searchTV
    case tvPopular
    case tvOnTheAir
    case tvTopRated
    case tvAiringToday
    case tvDetail
    case tvRecommendations
    case tvImages
    case genres
    case genresTV
}

extension RequestUrl {
    func url(environmentBase: EnvironmentBase, parameters: [String: Any]? = nil) -> String {
        var link = ""
        guard let parameters = parameters else {
            link += path
            return environmentBase == .theMovieDB ? link + apiKey : link
        }
        
        link += createUrl(from: path, environmentBase: environmentBase, parameters: parameters)
        return link
    }
    
    var path: String {
        return FileManager.load(file: .requestLinks, key: rawValue)
    }
    
    func createUrl(from string: String, environmentBase: EnvironmentBase, parameters: [String: Any]) -> String {
        var url = string
        
        parameters.forEach { (parameter) in
            if url.contains("{\(parameter.key)}") {
                let array = url.components(separatedBy: "{\(parameter.key)}")
                if array.count == 2 { url = "\(array[0])\(parameter.value)\(array[1])" }
            }
        }
        
        return environmentBase == .theMovieDB ? url + apiKey : url
    }
    
    var apiKey: String {
        return "api_key=\(RequestUrl.apiKey.path)"
    }
}
