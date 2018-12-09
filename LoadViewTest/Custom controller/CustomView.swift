import UIKit

class CustomView: UIView {
    
    // MARK: - Subviews
    private var square = UIView()
    private var validZone = UIView()
    @IBOutlet weak var restoreButton: UIButton!
    
    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupSquare()
        setupValidZone()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutValidZone()
    }
    
    private func layoutValidZone() {
        let heightHalf = bounds.height / 2
        let bottomHalf = CGRect(x: 0, y: heightHalf, width: bounds.width, height: heightHalf)
        validZone.frame = bottomHalf.insetBy(dx: 16, dy: 16)
    }
    
    // MARK: - Setup
    private func setupSquare() {
        square.frame = CGRect(x: 0, y: 0, width: squareSize, height: squareSize)
        addSubview(square)
        isSquarePositionValid = true
    }
    private func setupValidZone() {
        validZone.backgroundColor = UIColor.green.withAlphaComponent(0.25)
        validZone.layer.cornerRadius = 24
        validZone.isUserInteractionEnabled = false
        addSubview(validZone)
    }
    
    // MARK: - Validation
    private var isSquarePositionValid: Bool = true {
        didSet {
            square.backgroundColor = isSquarePositionValid ? .green: .red
        }
    }
    private func validateSquare(position: CGPoint) {
        isSquarePositionValid = validZone.frame.contains(square.center)
    }
    
    // MARK: - Positions
    func moveSquare(to point: CGPoint, animated: Bool = false) {
        let duration = animated ? 0.3: 0
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
            self.square.center = point
            self.validateSquare(position: point)
        })
    }
    func restorePosition() {
        moveSquare(to: restoreButton.center)
    }
    
    private let squareSize: CGFloat = 100
}
