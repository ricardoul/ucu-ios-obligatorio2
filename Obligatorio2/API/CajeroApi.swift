//
//  UserAPI.swift
//  ios-challenge-eric-pintos
//
//  Created by Eric Pintos on 11/1/17.
//  Copyright © 2017 Eric Pintos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

class CajeroAPI {
    
    let URL = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/f583be1121dbc5e9b0381b3017718a70c31054f7/sample_array_json"
    
    func loadItems() -> [Atm]{
    
        Alamofire.request(URL).responseArray { (response: DataResponse<[Atm]>) in
            return response.result.value;
        }
    }

}


