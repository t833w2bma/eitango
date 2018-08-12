//  ViewController2.swift
//  eitango

import UIKit
import Foundation
import AVFoundation

class ViewController2: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tf: UITextField!
    
    var tango:[[String:String]] = [[:]] // jisho initialize
    var tkey = ""
    var tarr =  [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        loadUri()  //読み込み
        
    }
 
    
    //Next Button
    @IBAction func tap2(_ sender: Any) {
        var tng = [String:String]()
        let userDefault = UserDefaults.standard
        
        // textというキーを指定して保存していた値を取り出して配列作成
        if let value = userDefault.string(forKey: "eitangot") {
            // 取り出した値をテキストフィールドに設定
            let val = value.split(separator: ",")
            tango.removeFirst() //初期化時に入れた0番目を削除
            
            for (v) in val{
                let kv = v.split(separator: ":")
                tng=[String(kv[0]): String(kv[1])]
                tango+=[tng] // 設問セットを加算代入
            }
        }else{
            print("保存されてない")
        }
        shaffle() // nextボタンでも問題を呼び出す
        
    }
    
 ///解答ボタン
    @IBAction func button(_ sender: Any) {
        guard let tarrAns:String = tarr[tkey] else {
            return
        }
        print(tarrAns.count , tf.text!.count)
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
        let speech = AVSpeechUtterance(string: tarrAns)
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
    
    
    func loadUri(){
        // セッションの取り出し
        let session = URLSession.shared
        var html:String? = ""
        // URLオブジェクトを生成
        if let uri = URL(string: "https://ultimai.org/mdlsrc/fiddle/eitangot.txt") {
            // リクエストオブジェクトを生成
            let request = URLRequest(url: uri)
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
                // eitangotというキーで値を保存する
                userDefault.set(htmlds, forKey: "eitangot")
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
     print(tarr)
        tkey = Array(tarr.keys)[0]
        label.text = tkey
        tf.text = ""
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
