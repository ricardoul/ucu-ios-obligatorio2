//
//  Atm.swift
//  Spray It Dev
//
//  Created by Ricardo Umpierrez on 5/17/18.
//  Copyright © 2018 Tarmac. All rights reserved.
//

import Foundation
import ObjectMapper


public class Atm : Mappable {
    public var id : Int?
    public var location : Location?
    public var address : String?
    public var network : String?
    public var status : String?
    public var hasMoney: Bool?
    public var acceptsDeposits: Bool?
    public var openHours: String?
    public var imageUrl: String?
    
    
    init(id:Int, address: String, network: String, status: String, hasMoney:Bool , acceptsDeposits:Bool, openHours:String, imageUrl:String) {
        
        self.id = id;
        self.network = network;
        self.address = address;
        self.status = status;
        self.hasMoney = hasMoney;
        self.acceptsDeposits = acceptsDeposits;
        self.openHours = openHours;
        self.imageUrl = imageUrl
    }
    
    required public init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        id    <- map["id"]
        address         <- map["address"]
        location         <- map["location"]
        network      <- map["network"]
        status       <- map["status"]
        hasMoney  <- map["has_money"]
        acceptsDeposits  <- map["accepts_deposits"]
        openHours <- map["open_hours"]
        imageUrl <- map["image_url"]
    }
}
