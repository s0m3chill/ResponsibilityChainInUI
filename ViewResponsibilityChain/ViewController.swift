
import UIKit

class ViewController: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("Show", for: .normal)
        button.addTarget(self, action: #selector(showNext), for: .touchUpInside)
        button.setTitleColor(.red, for: .normal)
        button.sizeToFit()
        view.addSubview(button)
        button.center = view.center
    }
    
    @objc func showNext() {
        present(SecondController(), animated: true, completion: nil)
    }
    
}

class SecondController: ViewController, Responder {
    override func showNext() {
        present(UINavigationController(rootViewController: ThirdController()), animated: true, completion: nil)
    }
    
    func canHandle(_ event: Event) -> Bool {
        return true
    }
    
    func handle(_ event: Event) {
        print("Oops! I should not get it")
    }
}

class ThirdController: ViewController, Responder, NoInternetViewContainer {
    override func showNext() {
        print(#function)
        if let root = view.window?.rootViewController {
            let iterator = ResponderIterator(start: root)
            let event = NetworkError()
            iterator.find(event)?.handle(event)
        }
    }
    
    func handle(_ event: Event) {
        if event is NetworkError {
            showNoInternetView()
        }
        else if event is ConnectionResumed {
            removeNoInternetView()
        }
    }
    
    func canHandle(_ event: Event) -> Bool {
        return true
    }

}
