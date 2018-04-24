//
//  RemoteService.swift
//  swiftArch
//
//  Created by czq on 2018/4/17.
//  Copyright © 2018年 czq. All rights reserved.
//

import UIKit

class RemoteService: DataProtocol {
    
    let httpClient = HttpClient(baseUrl:DataManager.shareInstance.baseUrl,headers:["X-Requested-With":"XMLHttpRequest"])
    let mockService:MockService=MockService();
    
    
    func getUser(userId:String,password:String,success:@escaping ((User?)->()),failure:@escaping ((Int?,String?)->()) ){
        httpClient.request(url: "user/{userId}", method: .get, pathParams: ["userId":"manondidi" ], params: ["password":"123"])
            .responseModel(success: { (result:Result<User>) in 
                if(self.checkSuccess(result: result)){
                    success(self.getData(result: result))
                }
                else{
                    failure(result.status,result.msg)
                }
            }, failure: {statusCode,error in
                failure(statusCode,error.localizedDescription)
            })
    }
    
    
    
    
    
   private func getData<T>(result:Result<T>)->T?{
        if self.checkSuccess(result: result) {
            return result.data;
        }
        else{
            return nil
        }
    }
    
  private  func checkSuccess<T>(result:Result<T>) -> Bool {
        return result.status==0
    }

}