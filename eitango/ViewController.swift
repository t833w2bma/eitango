//  ViewController.swift
//  eitango
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tf: UITextField!
   // let tango:[Int:[String:String]] = [["月曜日":"monday"],["火曜日":"tuesday"],["水曜日":"wednesday"],["木曜日":"thursday"],["金曜日":"friday"],["土曜日":"saturday"],["日曜日":"sunday"]]
    var tango = [["月曜日": "monday"],["火曜日":"tuesday"],["水曜日":"wednesday"],["木曜日":"thursday"],["金曜日":"friday"],["土曜日":"saturday"],["日曜日":"sunday"]]
    var tkey = ""
    var tarr =  [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      label.layer.masksToBounds=true
        label.layer.cornerRadius = 12
        label.layer.borderWidth = 1
        shaffle()
    }
    
    
    
    func shaffle(){
        let i = Int(arc4random_uniform(7))
        tarr = tango[i]
        tkey = Array(tarr.keys)[0]
        label.text = tkey
        
    }
    
    
    

    @IBAction func button(_ sender: Any) {
        print(tarr[tkey]!)
        if tarr[tkey]! == tf.text!{
            label.text = tkey + " 正解!"
        }else{
            label.text = tkey + " はずれ!"

        }
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

