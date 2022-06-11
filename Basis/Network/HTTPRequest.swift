//
//  HTTPRequest.swift
//  ShopMore
//
//  Created by Joyson P S on 19/05/22.
//

import Foundation

struct HttpRequest{
    let service = NetworkSession()
    let createRequest = HttpCreateRequest()
    public typealias queryParams = [String:Any]
    public var headers: [String:Any] = [:]
    

    public static var shared = HttpRequest()
    
    private init(){
        
    }

    /**
     GET Api call
     - Warning: Returns either sucess or failure
     - Parameter url: URL
     - Parameter resultType: Generic Model Decodable object
     - Parameter queryParams: [String:String]
     - Parameter successBlock:(object: T ) -> Void
     - Parameter failureBlock:(_ error: String) -> Void
     */

    func getApiData<T:Decodable>(endpoint: URLEndpoint, resultType: T.Type, queryParams:queryParams = [:],withSuccess successBlock:@escaping (_ object:T?)->Void,andFailure failureBlock: @escaping (_ error: String)->Void){
        guard let url = URL(string: APIEnvironment.development.baseURL + endpoint.rawValue) else {
            return
        }
        let req = createRequest.createRequest(httpMethod: .get, url: url, queryParams: queryParams, headers: headers)
        service.call(with: req) { (response,repsonseData,error ) in
            let (staus,err,res) = self.reponseParser(response: response, responseData: repsonseData, error: error, resultType: T.self)
            if (staus){
                successBlock(res)
            }else{
                failureBlock(err ?? "")
            }
            
        }
    }
    /**
     Post Api call
     - Warning: Returns either sucess or failure
     - Parameter url: URL
     - Parameter data: [String: Any]
     - Parameter resultType: Generic Model Decodable object
     - Parameter queryParams: [String:String]
     - Parameter successBlock:(object: T ) -> Void
     - Parameter failureBlock:(_ error: String) -> Void
     */

    func postApiData<T:Decodable>(endpoint: URLEndpoint, data:[String:Any]?,resultType: T.Type, queryParams:queryParams = [:],withSuccess successBlock:@escaping (_ object:T?)->Void,andFailure failureBlock: @escaping (_ error: String)->Void){
        guard let url = URL(string: APIEnvironment.development.baseURL + endpoint.rawValue) else {
            return
        }
        var req = createRequest.createRequest(httpMethod: .post, url: url, queryParams: queryParams, headers: headers)
        req.addBody(param: data)
        service.call(with: req) { (response,repsonseData,error ) in
            let (staus,err,res) = self.reponseParser(response: response, responseData: repsonseData, error: error, resultType: T.self)
            if (staus){
                successBlock(res)
            }else{
                failureBlock(err ?? "")
            }
            
        }
    }
    /**
     Post Api call
     - Warning: Returns either sucess or failure
     - Parameter url: URL
     - Parameter data: Data?
     - Parameter resultType: Generic Model Decodable object
     - Parameter queryParams: [String:String]
     - Parameter successBlock:(object: T ) -> Void
     - Parameter failureBlock:(_ error: String) -> Void
     */

    func postApiData<T:Decodable>(endpoint: URLEndpoint, data:Data?,resultType: T.Type, queryParams:queryParams = [:],withSuccess successBlock:@escaping (_ object:T?)->Void,andFailure failureBlock: @escaping (_ error: String)->Void){
        guard let url = URL(string: APIEnvironment.development.baseURL + endpoint.rawValue) else {
            return
        }
        var req = createRequest.createRequest(httpMethod: .post, url: url, queryParams: queryParams, headers: headers)
        req.httpBody = data
//        req.addBody(param: data)
        service.call(with: req) { (response,repsonseData,error ) in
            let (staus,err,res) = self.reponseParser(response: response, responseData: repsonseData, error: error, resultType: T.self)
            if (staus){
                successBlock(res)
            }else{
                failureBlock(err ?? "")
            }
            
        }
    }
}


extension HttpRequest{
    /**
     - Parameter response: URLResponse?
     - Parameter responseData: Data?
     - Parameter error: Error?
     - Parameter resultType: Decodable
     - Returns: Bool, true or false status of the request.
     - Returns: Bool, true or false status of the request.
     - Returns: T, Decodable object
     */
    private func reponseParser<T:Decodable>(response: URLResponse?,responseData: Data?,error: Error?,resultType:T.Type )-> (Bool,String?,T?){
        let httpResponse = response as? HTTPURLResponse
        if 200...300 ~= httpResponse?.statusCode ?? 404, let data = responseData{
            let data = responseData?.getJsonObject() as? Dictionary<String,Any>
            if let dataPresent = data?["results"] ,let jsondata = try? JSONSerialization.data(withJSONObject: dataPresent as Any, options: .prettyPrinted){
                let res = try? JSONDecoder().decode(T.self, from: jsondata)
                return (true,nil,res)
            }else{
                return (false,error?.localizedDescription,nil)
            }
        }else{
            guard let data = responseData else {
                return (false,error?.localizedDescription,nil)
            }
            let res = try? JSONDecoder().decode(ErrorResponse.self, from: data)
            return (false,res?.errors?.first?.message,nil)
        }
        return (true,error?.localizedDescription,nil)

    }
}
