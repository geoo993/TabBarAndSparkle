//
//  Business.swift
//  Sparkles
//
//  Created by GEORGE QUENTIN on 24/11/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation


class Business {
    // Users never call this init, it's for the builder to use
    init(name: String, webSite: String?, address: String?) {
        
    }
    // Here is the method the users call:
    static func withName(name: String) -> BusinessBuilder {
        return BusinessBuilder(name: name)
    }
    // This class collects parameters before calling init
    class BusinessBuilder {
        var name : String
        var webSite : String?
        var address: String?
        func andAddress(address: String) -> BusinessBuilder {
            self.address = address
            return self
        }
        func andWebSite(webSite: String) -> BusinessBuilder {
            self.webSite = webSite
            return self
        }
        func build() -> Business {
            return Business(name: name, webSite: webSite, address: address)
        }
        init(name: String) {
            self.name = name
        }
    }
}
