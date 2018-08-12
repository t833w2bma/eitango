//  ViewController.swift
//  eitango
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var tapNext: UIButton!
  
    var tango = [["月曜日": "monday"],["火曜日":"tuesday"],["水曜日":"wednesday"],["木曜日":"thursday"],["金曜日":"friday"],["土曜日":"saturday"],["日曜日":"sunday"]]
    var tkey = ""
    var tarr =  [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shaffle() // ここで問題を呼び出す
    }
    
    
    @IBAction func tapNext(_ sender: Any) {
        shaffle() // nextボタンでも問題を呼び出す
    }
    
    func shaffle(){
        let tc =  UInt32( tango.count)
        let i = Int(arc4random_uniform(tc))
        tarr = tango[i]
        tkey = Array(tarr.keys)[0]
        label.text = tkey
        
    }
    

    @IBAction func button(_ sender: Any) {
        
        print(tarr[tkey]!)
        if tarr[tkey]! == tf.text!{
            label.text = tkey + " 正解!"
             tf.text = ""
        }else{
            label.text = tkey + " はずれ!"
            tf.text = ""
        }
        
    }
    
    
    //降参ボタン
    @IBAction func kosan(_ sender: Any) {
        label.text = tkey + "正解は" + tarr[tkey]!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

