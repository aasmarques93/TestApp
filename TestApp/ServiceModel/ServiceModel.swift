//
//  ServiceModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Moya

typealias HandlerCallback = () -> Swift.Void
typealias HandlerObject = (Any?) -> Swift.Void
typealias Handler<Element> = (Element) -> Swift.Void

// MARK: - Service Model -

protocol ServiceModel {
}

extension ServiceModel {
    // MARK: - Service Delegate Methods -
    
    func request(method: Moya.Method = .get,
                 requestUrl: RequestUrl,
                 environmentBase: EnvironmentBase = EnvironmentManager.shared.current,
                 parameters: [String: Any]? = nil,
                 urlParameters: [String: Any]? = nil,
                 handlerObject: @escaping HandlerObject) {
        
        guard environmentBase != .mock else {
            handleMockJson(requestUrl: requestUrl, handlerObject: handlerObject)
            return
        }
        
        let requestBase = RequestBase(requestUrl: requestUrl,
                                      environmentBase: environmentBase,
                                      method: method,
                                      urlParameters: urlParameters,
                                      parameters: parameters)
        
        let provider = MoyaProvider<RequestBase>(plugins: [NetworkLoggerPlugin(verbose: true)])
        provider.request(requestBase) { (result) in
            do {
                let response = try result.dematerialize()
                let json = try response.mapJSON()
                let object = self.handleJsonResponse(json: json)
                handlerObject(object)
            } catch {
                let printableError = error as CustomStringConvertible
                handlerObject(printableError.description)
            }
        }
    }
    
    func handleJsonResponse(json: Any) -> Any {
        guard let array = json as? [Any] else {
            return JSON(json)
        }
        return array.map { JSON($0) }
    }
    
    private func handleMockJson(requestUrl: RequestUrl, handlerObject: @escaping HandlerObject) {
        JSONWrapper.json(from: requestUrl) { (json) in
            handlerObject(json)
        }
    }
    
    func imageUrl(with path: String?, environmentBase: EnvironmentBase = .imagesTheMovieDB) -> String {
        var url = environmentBase.path
        if let path = path { url += path }
        return url
    }
}
