import UIKit

struct Todo {
    var done: Bool
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var XIB: UITableView!
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.placeholder = "didSet으로 초기화"
            textField.text = "didSet 구문으로 초기화됨"
            textField.textAlignment = .left
            textField.font = .systemFont(ofSize: 17)
            textField.textColor = .black
            print("didSet 호출됨")
        }
    }
    
    var list: [Todo] = [
        Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false), Todo(done: false)
    ] {
        didSet {
//            XIB.reloadData()
            print("데이터 리로드됨")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad 호출됨")
        
        XIB.delegate = self
        XIB.dataSource = self
        XIB.register(UINib(nibName: XIBTableViewCell.id, bundle: nil), forCellReuseIdentifier: XIBTableViewCell.id)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: XIBTableViewCell.id, for: indexPath) as? XIBTableViewCell else { return UITableViewCell()}
        
        cell.checkBoxButton.tag = indexPath.row
        cell.checkBoxButton.addTarget(self, action: #selector(clickedButton(sender:)), for: .touchUpInside)
        
//        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
//        cell.checkBoxButton.setImage(UIImage(systemName: value), for: .normal)
        
        return cell
    }
    
    @objc func clickedButton(sender: UIButton) {
        print("클릭한 버튼은 \(sender.tag)번째 버튼")
        
//        list[sender.tag].done = !list[sender.tag].done
////        XIB.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
//        XIB.reloadData()
        
        if list[sender.tag].done == false {
            list[sender.tag].done = true
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else if list[sender.tag].done == true {
            list[sender.tag].done = false
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        XIB.reloadData()
        
        // 데이터도 재사용되는 문제
//        sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
    }
}

// 특정 Cell은 tag를 활용해 확인하자.
// 버튼에 아울렛 메소드를 추가해서 클릭 효과를 구현하면 모든 Cell에 클릭하는 결과를 가져온다.
// 따라서 addTarget 코드를 사용한다.
