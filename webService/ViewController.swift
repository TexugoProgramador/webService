//
//  ViewController.swift
//  webService
//
//  Created by humberto Lima on 21/07/2018.
//  Copyright © 2018 humberto Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelValor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlAcess = URL(string: "https://blockchain.info/ticker") {
            let request = URLSession.shared.dataTask(with: urlAcess) { (dados, requisicao, erro) in
                if erro == nil {
                    if let dadosRetornado = dados {
                        do {
                            if let objetoJason = try JSONSerialization.jsonObject(with: dadosRetornado, options: []) as? [String: Any] {
                                if let objetoValor = objetoJason["BRL"] as? [String: Any] {
                                   
                                    if let precoReal = objetoValor["buy"] as? Double {
                                        // dentro de clouse é interessante usar um
                                        DispatchQueue.main.async(execute: {
                                            self.labelValor.text = "\(precoReal)"
                                        })
                                    }
                                }
                            }
                        }catch{
                            print("Erro ao formatar dados retornados")
                        }
                    }
                }else{
                    print("Erro ao consultar dados")
                }
            }
            request.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

