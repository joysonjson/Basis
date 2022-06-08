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

    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, queryParams:queryParams = [:],withSuccess successBlock:@escaping (_ object:T?)->Void,andFailure failureBlock: @escaping (_ error: String)->Void){
        let req = createRequest.createRequest(httpMethod: .get, url: requestUrl, queryParams: queryParams, headers: headers)
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

    func postApiData<T:Decodable>(requestUrl: URL, data:[String:Any]?,resultType: T.Type, queryParams:queryParams = [:],withSuccess successBlock:@escaping (_ object:T?)->Void,andFailure failureBlock: @escaping (_ error: String)->Void){
        var req = createRequest.createRequest(httpMethod: .get, url: requestUrl, queryParams: queryParams, headers: headers)
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
            let res = try? JSONDecoder().decode(T.self, from: data)
            if let obj = res{
                return (true,error?.localizedDescription,obj)
            }
            return (true,error?.localizedDescription,nil)

        }else{
            guard let data = responseData else {
                return (false,error?.localizedDescription,nil)

            }
            let res = try? JSONDecoder().decode(ErrorResponse.self, from: data)
            return (false,res?.errors?.first?.message,nil)
        }
    }
}
