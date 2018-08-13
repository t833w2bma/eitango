//  ViewController.swift
//  eitango
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tf: UITextField!
  
    var tango = [["月曜日": "monday"],["火曜日":"tuesday"],["水曜日":"wednesday"],["木曜日":"thursday"],["金曜日":"friday"],["土曜日":"saturday"],["日曜日":"sunday"]]
    var tkey = ""
    var tarr =  [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         shaffle()// ここで問題を呼び出す
    }
    
    
    @IBAction func tapNext(_ sender: Any) {
        shaffle() // nextボタンでも問題を呼び出す
    }
    
    func shaffle(){
        let tc =  UInt32( tango.count) //配列の要素数
        let i = Int(arc4random_uniform(tc)) //要素数分の乱数発生
        tarr = tango[i] //ランダムな曜日セットを取り出す
        tkey = Array(tarr.keys)[0]  // 曜日セットからキーを取り出す
        label.text = tkey   // キーをラベル文字に表示する
        tf.text = ""        // テキストフィールドをからにする
    }
    

    @IBAction func answer(_ sender: Any) {
        if tarr[tkey]! == tf.text!{
            label.text = tkey + " 正解!"
            
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

