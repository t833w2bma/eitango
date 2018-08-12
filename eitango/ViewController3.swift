//  ViewController3.swift
//  eitango

import UIKit

class ViewController3: UIViewController {

    @IBOutlet weak var tap: UIButton!
    @IBOutlet weak var textField: UITextField!
    struct JsonSample : Codable{
        var id : Int
        var name : String
    }

    
    var jsondata:String = ""
    
    
    
    @IBAction func tap(_ sender: Any) {
        
    }
    
    @IBAction func tap2(_ sender: Any) {
         let userDefaults = UserDefaults.standard
        // textというキーを指定して保存していた値を取り出す
        if let value = userDefaults.string(forKey: "text") {
            // 取り出した値をテキストフィールドに設定
            print(value)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //print(json!.name )
        let listUrl = "https://ultimai.org/mdlsrc/fiddle/eitango.json"
        
        guard let url = URL(string: listUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            let json = try? JSONDecoder().decode(JsonSample.self, from: data)
            self.jsondata=json!.name
            
            // UserDefaultsの参照
            let userDefaults = UserDefaults.standard
            // textというキーで値を保存する
            userDefaults.set(self.jsondata, forKey: "text")
            // UserDefaultsへの値の保存を明示的に行う
            userDefaults.synchronize()
            
            }.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
