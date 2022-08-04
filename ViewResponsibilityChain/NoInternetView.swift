
import UIKit

class NoInternetView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        bounces = true
        alwaysBounceVertical = true
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        
        let label = UILabel()
        label.text = "No Connection"
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)
        
        [container.leadingAnchor.constraint(equalTo: leadingAnchor),
         container.trailingAnchor.constraint(equalTo: trailingAnchor),
         container.topAnchor.constraint(equalTo: topAnchor),
         container.bottomAnchor.constraint(equalTo: bottomAnchor),
         container.widthAnchor.constraint(equalTo: widthAnchor),
         container.heightAnchor.constraint(equalTo: heightAnchor),
         label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
         label.centerYAnchor.constraint(equalTo: container.centerYAnchor)]
            .forEach{ $0.isActive = true }
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self,
                                  action: #selector(refreshAction),
                                  for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func refreshAction() {
        if let root = window?.rootViewController {
            let iterator = ResponderIterator(start: root)
            let event = ConnectionResumed()
            iterator.find(event)?.handle(event)
        }
    }
}
