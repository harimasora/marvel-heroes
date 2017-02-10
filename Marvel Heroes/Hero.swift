//
//  Hero.swift
//  Marvel Heroes
//
//  Created by Danilo Maia Rodrigues on 10/02/17.
//  Copyright © 2017 Danilo Maia Rodrigues. All rights reserved.
//
import ObjectMapper

//Utiliza o AlamofireObjectMapper para minimizar o esforço
//para gerar um dicionário a partir de um JSON
class Hero : Mappable {
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: Thumbnail?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        thumbnail <- map["thumbnail"]
    }
}

class Thumbnail : Mappable {
    var ext: String?
    var path: String?
    
    //Gera uma url (String) a partir do caminho e da extensão
    func url() -> String {
        guard let ext = ext, let path = path else {
            return ""
        }
        return "\(path).\(ext)"
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        ext <- map["extension"]
        path <- map["path"]
    }
}
