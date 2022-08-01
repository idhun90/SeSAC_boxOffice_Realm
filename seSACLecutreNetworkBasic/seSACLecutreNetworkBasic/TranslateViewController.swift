//
//  TranslateViewController.swift
//  seSACLecutreNetworkBasic
//
//  Created by 이도헌 on 2022/07/28.
//

import UIKit

class TranslateViewController: UIViewController {
    
    // UIButton, UITextField > Action
    // UITextView, UISearchBar, UIPickerView > x
    // 이유 UIControl컨트롤을 상속 받지 않아서 -> 상속 받지 않은 것들은 프로토콜을 통해
    // UIResponderChain -> textViewDidBeginEditing, textViewDidEndEditing 연관되어 있음
    // 어떤 객체를 클릭했는지 알 수 있게 해주는 Responder chain,
    // -> userInputTextView.resignFirstResponder() // 화면 반응의 우선권 포기
    // -> userInputTextView.becomeFirstResponder() // 화면 반응의 우선권 획득
    
    
    // 우리의 목적은 텍스트뷰의 플레이스홀더
    @IBOutlet weak var userInputTextView: UITextView!
    
    
    let textViewPlacehoderText = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlacehoderText
        userInputTextView.textColor = .lightGray
        
        //폰트 프로퍼티를 활용
        //디폴트 속성들은 SF에만 적용되는 코드들, 우리가 사용할 코드는 따로 바꿔줘야 한다.
//        userInputTextView.font = UIFont(name: "SUIT-Regular", size: 17)
        
        
    }

}

extension TranslateViewController: UITextViewDelegate {
    
    // 텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    // (커서가 시작될 때)편집이 시작될 떄
    // 텍스트뷰 글자가 플레이스 홀더 글자가 같음 clear 시켜라, color도 주의
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    // 텍스트에 편집이 끝났을 때. (커서가 없어지는 순간)
    // 텍스트뷰 글자: 사용자가 아무 글자도 안 썼으면 플레이스홀더 보이게 해라
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty {
            textView.text = textViewPlacehoderText
            textView.textColor = .lightGray
            
        }
        // 편집이 종료되는 것을 따로 구현해줘야 한다.
    }
}
