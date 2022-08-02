
import UIKit
//애플 임포트에서 한칸 띄고 알파벳 순서로 써준다
//1. 임포트
import Alamofire
import SwiftyJSON


class LottoViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    
    @IBOutlet weak var numberTextField: UITextField!
    //    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    var lottoPickerView = UIPickerView()
    // 클래스의 인스턴스를 생성하면 끝
    // 등록한 뷰는 inputView에 들어가 있어서 레이아웃을 안 잡아줘도 된다.
    // 코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있다. -> 레이아웃 대응 등
    
    // 사용자 환경 개선
    let numberList: [Int] = Array(1...1025).reversed() // 거꾸로 데이터를 돌림
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lottoPickerView.dataSource = self
        lottoPickerView.delegate = self
        
        viewUI()
        
        // 텍스트필드를 누르면 키보드가 나온다 따라서 아래 방법
        // 텍스트필드에 뷰를 심을 수 있다. 클릭할 때 할당한 뷰가 올라온다.
        
        numberTextField.inputView = lottoPickerView
        numberTextField.borderStyle = .none
        
        requestLotto(number: 1025)
    }
    
    //0801
    func requestLotto(number: Int) {
        
        // AF: 200~299 성공으로 간주 status code
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                //swiftyJSOn에서 원하는 값 가져오기
                let labelList = [self.label1, self.label2, self.label3, self.label4, self.label5, self.label6, self.label7]
                
                let jsonNo = ["drwtNo1", "drwtNo2", "drwtNo3", "drwtNo4", "drwtNo5", "drwtNo6", "bnusNo"]
                
                for number in 0...jsonNo.count-1 {
                    
                    labelList[number]?.text = "\(json[jsonNo[number]].intValue)"
                }
                
                
//                let bonus = json["bnusNo"].intValue
//                print(bonus)
//
                let date = json["drwNoDate"].stringValue
//                print(date)
                
                //스토리보드에 표현해주기
                self.numberTextField.text = date
                print("====2====")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    // 알라모 파이어로 겟을 요청할 것이다 -> 유효성 검증(상태 코드, 200번 성공) -> JSON 형태로 받아오겠다.
    
    func viewUI() {
        let viewlist = [view1, view2, view3, view4, view5, view6, view7]
        
        for lottoView in viewlist {
            
            lottoView?.layer.cornerRadius = (lottoView?.frame.width)! / 2
            
            
        }
    }
    
}

//MARK: - UIPickerView 프로토콜 채택
// 스위프트 파일에서 따로 관리할 수도 있다. 하지만 기능이 방대해지면 찾아 보기가 어렵기 때문에 일반적으로는 하단에 배치하는 방법을 사용.
extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
        // 1024 //component == 0 ? 10: 20 // 각각 다르게 주고 싶을 때
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
        print("====1====")
//        numberTextField.text = "\(numberList[row])회차"
        print("\(numberList[row])회차")
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
    
}
