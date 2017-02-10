//
//  HeroesProvider.swift
//  Marvel Heroes
//
//  Created by Danilo Maia Rodrigues on 10/02/17.
//  Copyright © 2017 Danilo Maia Rodrigues. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

struct HeroesProvider {
    
    //Dados para acesso à API da Marvel
    let publicKey: String = "03bb5d25596e06a6f5dac5b2c6d1e71c"
    let privateKey: String = "b195e47a3d1bd5e169a22e201e08c420ccb29114"
    let baseUrl: String = "http://gateway.marvel.com/v1/public/"
    
    //A String utilizada como base para o hash (MD5) deve estar neste formato
    func stringToHash(timestamp: String) -> String {
     return timestamp + privateKey + publicKey
    }

    //O timestamp da requisição precisa estar formatado neste modelo
    func timeStampString() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter.string(from: Date())
    }
    
    //Gera um hash a partir de uma String
    func generateHash(timestamp: String) -> String {
        guard let hash = (stringToHash(timestamp: timestamp)).MD5 else {
            return ""
        }
        
        return hash
    }
    
    //Faz uma requisição à API solicitando personagens a parir de um dado offset de personagens
    //Essa função retorna 20 personagens por padrão através de um callback
    func listHeroesWith(offset: Int, completed: @escaping (([Hero]?) -> ())) {
        
        //Prepara os parâmetros para a requisição
        let timestamp = timeStampString()
        let resourcesOffset: String = String(offset)
        let parameters = ["ts": timestamp, "apikey": publicKey, "hash": generateHash(timestamp: timestamp) , "offset" : resourcesOffset]
        
        //Utiliza o pod do Alamofire para disparar a requisição
        Alamofire.request(baseUrl + "/characters", parameters: parameters).responseObject { (response: DataResponse<HeroResponse>) in
            
            //Esta requisição retorna um JSON, que então é mapeado em um objeto HeroResponse
            let heroResponse = response.result.value
            
            //Desempacota o Optional para garantir que o valor não é nulo
            guard let heroes = heroResponse?.data?.heroes else {
                print("Could not retrieve heroes");
                return
            }
            
            //Retorna o agora array de Hero no callback
            completed(heroes)
            
        }
    }
}
