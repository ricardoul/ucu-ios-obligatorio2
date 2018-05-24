//
//  Location.swift
//  Spray It Dev
//
//  Created by Ricardo Umpierrez on 5/17/18.
//  Copyright © 2018 Tarmac. All rights reserved.
//

import Foundation
import ObjectMapper


public class Location : Mappable {
    public var lat : Double?
    public var lon : Double?
    
    init(latX: Double, latY: Double) {
        self.lat = latX;
        self.lon = latY;
    }
    
    
    required public init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        lat    <- map["lat"]
        lon    <- map["lon"]
    }
    
}

