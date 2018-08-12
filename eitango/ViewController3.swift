//  ViewController3.swift
//  eitango

import UIKit
import Foundation
import AVFoundation

class ViewController3: UIViewController {
   
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tf: UITextField!
    
    var tango:[[String:String]] = [[:]] // jisho initialize
    var tkey = ""
    var tarr =  [String: String]()
 
//描画時実行
    override func viewDidLoad() {
        super.viewDidLoad()
        
        issueName()
  
    }
    
    //Next Button
    @IBAction func tap2(_ sender: Any) {
        if tarr.count < 2{
           cleateArr()
        }
        shaffle() // nextボタンでも問題を呼び出す
    }
    
    // 配列作成
    func cleateArr(){
        var tng = [String:String]()
        let userDefault = UserDefaults.standard
        
        // textというキーを指定して保存していた値を取り出して配列作成
        if let value = userDefault.string(forKey: "h1acv") {
            // 取り出した値をテキストフィールドに設定
            let val = value.split(separator: ",")
            tango.removeFirst() //初期化時に入れた0番目を削除
            for (v) in val{
                let kv = v.split(separator: ":")
                tng=[String(kv[0]): String(kv[1])]
                tango+=[tng] // 設問セットを加算代入
            }
            
            shaffle()
            
        }else{
            print("data not found")
        }
    }
    
    
    ///解答ボタン
    @IBAction func button(_ sender: Any) {
        guard let tarrAns:String = tarr[tkey] else {
            return
        }
        if tarrAns == tf.text!{
            label.text = tkey + " 正解!"
            
        }else{
            label.text = tkey + " はずれ!"
            tf.text = ""
        }
    }
    
    
    // 聞くボタン
    @IBAction func hir(_ sender: Any) {
        guard let tarrAns:String = tarr[tkey] else {
            return
        }
        
        let speak:AVSpeechSynthesizer = AVSpeechSynthesizer()
        let speech = AVSpeechUtterance(string: tarrAns )
        speech.voice = AVSpeechSynthesisVoice(language: "en-US")
        speak.speak(speech)
    }
    
    
    //降参ボタン
    @IBAction func kosan(_ sender: Any) {
        guard let tarrAns:String = tarr[tkey] else {
            return
        }
        label.text = tkey + " 正解は " + tarrAns
        // キーボードを閉じる
        tf.endEditing(true);
    }
    
 // web 読み込み
    @IBAction func noun(_ sender: Any) {
        issueName()
    }
    func issueName(){
        let urin="https://ultimai.org/mdlsrc/fiddle/eitango_h1nam4.txt"
        loadUri(uri:urin)
    }
   
    @IBAction func verb(_ sender: Any) {
        issueAct()
    }
    func issueAct(){
        let urin="https://ultimai.org/mdlsrc/fiddle/eitango_h1acv.txt"
        loadUri(uri:urin)
    }
    
    func loadUri(uri:String){
        // セッションの取り出し
        let session = URLSession.shared
        var html:String? = ""
  

        
        // URLオブジェクトを生成
        if let uria = URL(string: uri) {
            // リクエストオブジェクトを生成
            let request = URLRequest(url: uria)
            // 処理タスクを生成
            let task = session.dataTask(with: request, completionHandler: {
                (data:Data?, response:URLResponse?, error:Error?) in
                // データ取得後に呼ばれる処理はここに記載する
                guard let data = data else {
                    print("データなし")
                    return
                }
                // Data型の変数をString型に変換してprintで出力
                html = String(data: data, encoding: String.Encoding.utf8)
               guard let htmls = html else { return }
                let htmlds = htmls.replacingOccurrences(of: "\r\n", with: "")
                // UserDefaultsの参照
                let userDefault = UserDefaults.standard
                userDefault.removeObject(forKey: "h1acv") //ストレージから削除
                
                // h1acvというキーで値を保存する
                userDefault.set(htmlds, forKey: "h1acv")
                // UserDefaultsへの値の保存を明示的に行う
                userDefault.synchronize()
            })
            // 処理開始
            task.resume()
        } //if let
    }
    
    
    //配列をシャッフルし問題表示
    func shaffle(){
        let tc =  UInt32( tango.count)
        let i = Int(arc4random_uniform(tc))
        tarr = tango[i]
        tkey = Array(tarr.keys)[0]
        label.text = tkey
        tf.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
