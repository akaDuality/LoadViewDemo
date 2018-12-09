import UIKit

class CustomViewController: UIViewController, ViewSpecificController {
    typealias RootView = CustomView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view().restorePosition()
        addGesture()
    }
}

// MARK: - IBActions
extension CustomViewController {
    @IBAction func restorePosition() {
        view().restorePosition()
    }
}

// MARK: - Gesture
extension CustomViewController {
    private func addGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panRecognized(recognizer:)))
        
        view.addGestureRecognizer(panGesture)
    }
    @objc private func panRecognized(recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        
        switch recognizer.state {
        case .began:
            view().moveSquare(to: location, animated: true)
        case .changed:
            view().moveSquare(to: location, animated: false)
        default:
            break
        }
    }
}
