
import UIKit

protocol Event {}

protocol Responder {
    func canHandle(_ event: Event) -> Bool
    func handle(_ event: Event)
}

struct ResponderIterator {
    let start: UIViewController
    func find(_ event: Event) -> Responder? {
        func check(_ ctrl: UIViewController) -> Responder? {
            if let presented = ctrl.presentedViewController,
                let responder = check(presented),
                responder.canHandle(event){
                return responder
            }
            for child in ctrl.children {
                if let responder = check(child) {
                    return responder
                }
            }
            if let responder = ctrl as? Responder,
                responder.canHandle(event) {
                return responder
            }
            return nil
        }
        
        return check(start)
    }
}

struct NetworkError: Event {}
struct ConnectionResumed: Event {}

