//
//  HeroResponse.swift
//  Marvel Heroes
//
//  Created by Danilo Maia Rodrigues on 10/02/17.
//  Copyright © 2017 Danilo Maia Rodrigues. All rights reserved.
//

import ObjectMapper

//Utiliza o AlamofireObjectMapper para minimizar o esforço
//para gerar um dicionário a partir de um JSON
class HeroResponse: Mappable {
    var code: String?
    var status: Int?
    var data: HeroDataResponse?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        status <- map["status"]
        data <- map["data"]
    }
}

class HeroDataResponse: Mappable {
    var count: Int?
    var limit: Int?
    var offset: Int?
    var total: Int?
    var heroes: [Hero]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        limit <- map["limit"]
        offset <- map["offset"]
        total <- map["total"]
        heroes <- map["results"]
    }
}
