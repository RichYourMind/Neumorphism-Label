//
//  MyBoldButtonView.swift
//  Restaurant App
//
//  Created by ArshMini on 8/21/21.
//

import UIKit


open class NeumorphismLabel: UIView {
    
    
    
    
    //MARK: - IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var firstOutterShadowView: UIView!
    @IBOutlet weak var secondOutterShadowView: UIView!
    @IBOutlet weak var containerView: UIView!






    //MARK: - Init
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    required public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

    }








    //MARK: - Setup
    func setup() {
        let bundle = Bundle.module
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        insertSubview(contentView, at: 0)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = boxView.heightAnchor.constraint(equalToConstant: 120)
        NSLayoutConstraint.activate([self.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
                                     self.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
                                     self.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
                                     self.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
                                     heightConstraint
        ])

        configureStyle()
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.layoutIfNeeded()
            self.configureStyle()
            self.configureViews()
        }
    }

    
    
    
    
    
    
    
    //MARK: - Public Properties
    @IBInspectable public var title: String = "Hello"
    public var font: UIFont = .systemFont(ofSize: 85)




    //MARK: - Private Properties
    var firstInnerShadowView: UIView = .init()
    var secondInnerShadowView: UIView = .init()
    private var animationDurationTimeInterval: TimeInterval = 0.2
    private var firstOutterShadowSelectedOpacity: Float = 0.0 //Upper Left
    private var firstOutterShadowNormalOpacity: Float = 0.9 //Upper Left
    private var secondOutterShadowSelectedOpacity: Float = 0.20 // lower Right
    private var secondOutterShadowNormalOpacity: Float = 0.2 // lower Right
    private var firstInnerShadowSelectedOpacity: Float = 1.0 //Lower Right
    private var firstInnerShadowNormalOpacity: Float = 0.0 //Lower Right
    private var secondInnerShadowSelectedOpacity: Float = 0.20 //Upper Left
    private var secondInnerShadowNormalOpacity: Float = 0.0 //Upper Left
    private var selectedOutterOffset: CGFloat = 6.0
    private var selectedInnderOffset: CGFloat = 6.0
    private var outterShadowRadius: CGFloat = 4.7
    private var innerShadowRadius: CGFloat = 4.7
    private var animationIsInProgress: Bool = false
    private var selectedScaleFactor: CGFloat = 0.97
    private var heightConstraint: NSLayoutConstraint!


    //MARK: - Public Properties
    private var backColor: UIColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 1)
    private var firstInnerColor: UIColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) //Lower Right
    private var firstOutterColor: UIColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) //Upper Left
    private var secondInnerColor: UIColor = #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 1) // upper Left
    private var secondOutterColor: UIColor = #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 1) // lower Right
    @IBInspectable public var cornerRadius: CGFloat = 20
    var animationDuration: CGFloat = 0.2 {
        didSet {
            self.animationDurationTimeInterval = TimeInterval(animationDuration)
        }
    }
    
    func configureFirstInner(offset innderOffsert: CGFloat) {

        let shaowPath = title.path(withFont: self.font)

        let innerRadius: CGFloat = innderOffsert
        let firstInnerPath = UIBezierPath(cgPath: shaowPath)
        let firstInnerPathScaleX = (firstInnerShadowView.frame.width)/firstInnerShadowView.frame.width
        let firstInnerPathScaleY = (firstInnerShadowView.frame.height)/firstInnerShadowView.frame.height
        firstInnerPath.apply(CGAffineTransform(scaleX: firstInnerPathScaleX, y: firstInnerPathScaleY))
        var firstCutOut = UIBezierPath(cgPath: shaowPath)
        let firstCutOutScaleX = (firstInnerShadowView.frame.width)/firstInnerShadowView.frame.width
        let firstCutOutScaleY = (firstInnerShadowView.frame.height)/firstInnerShadowView.frame.height
        firstCutOut.apply(CGAffineTransform(translationX: -innerRadius, y: -innerRadius).scaledBy(x: firstCutOutScaleX, y: firstCutOutScaleY))
        firstCutOut = firstCutOut.reversing()
        firstInnerPath.append(firstCutOut)
        firstInnerShadowView.layer.shadowColor = firstInnerColor.cgColor
        firstInnerShadowView.layer.shadowOpacity = Float(firstInnerShadowSelectedOpacity)
        firstInnerShadowView.layer.shadowRadius = innerShadowRadius
        firstInnerShadowView.layer.shadowPath = firstInnerPath.cgPath
        firstInnerShadowView.layer.shadowOffset = .zero
        if firstInnerShadowView.superview == nil {containerView.addSubview(firstInnerShadowView)}
        
    }
    
    func configureSecondInner(offset innderOffsert: CGFloat) {
        
        let shaowPath = title.path(withFont: self.font)

        let innerRadius: CGFloat = innderOffsert
        
        //Second Inner View
        secondInnerShadowView.frame = containerView.bounds
        let secondInnerPath = UIBezierPath(cgPath: shaowPath)
        let secondInnerPathScaleX = (secondInnerShadowView.frame.width)/secondInnerShadowView.frame.width
        let secondInnerPathScaleY = (secondInnerShadowView.frame.height)/secondInnerShadowView.frame.height
        secondInnerPath.apply(CGAffineTransform(scaleX: secondInnerPathScaleX, y: secondInnerPathScaleY))
        var secondCutOut = UIBezierPath(cgPath: shaowPath)
        let secondCutOutScaleX = (secondInnerShadowView.frame.width)/secondInnerShadowView.frame.width
        let secondCutOutScaleY = (secondInnerShadowView.frame.height)/secondInnerShadowView.frame.height
        secondCutOut.apply(CGAffineTransform(translationX: innerRadius, y: innerRadius).scaledBy(x: secondCutOutScaleX, y: secondCutOutScaleY))
        secondCutOut = secondCutOut.reversing()
        secondInnerPath.append(secondCutOut)
        secondInnerShadowView.layer.shadowColor = secondInnerColor.cgColor
        secondInnerShadowView.layer.shadowOpacity = Float(secondInnerShadowSelectedOpacity)
        secondInnerShadowView.layer.shadowRadius = innerShadowRadius
        secondInnerShadowView.layer.shadowPath = secondInnerPath.cgPath
        secondInnerShadowView.layer.shadowOffset = .zero
        

    }
    
    
    func configureInnerShadow(opacity: CGFloat) {
        self.secondInnerShadowSelectedOpacity = Float(opacity)
        self.firstInnerShadowSelectedOpacity = Float(opacity)
        firstInnerShadowView.layer.shadowOpacity = Float(opacity)
        secondInnerShadowView.layer.shadowOpacity = Float(opacity)
    }
    
    func configureFirstInnerShadow(radisu: CGFloat) {
        self.innerShadowRadius = radisu
        firstInnerShadowView.layer.shadowRadius = CGFloat(Float(radisu))
    }
    func configureSecondInnerShadow(radisu: CGFloat) {
        self.innerShadowRadius = radisu
        secondInnerShadowView.layer.shadowRadius = CGFloat(Float(radisu))
    }
    

    func configureFirstInnerShadow(shadowRadisu: CGFloat) {
        firstOutterShadowView.layer.shadowRadius = shadowRadisu
        secondOutterShadowView.layer.shadowRadius = shadowRadisu
        firstInnerShadowView.layer.shadowRadius = shadowRadisu
        secondInnerShadowView.layer.shadowRadius = shadowRadisu

    }
    
    


    //MARK: - Configure Views
    public func configureViews() {
        [firstOutterShadowView , secondOutterShadowView , containerView].forEach{
            $0?.backgroundColor = .clear
            $0?.layer.cornerRadius = cornerRadius
        }
        let shaowPath = title.path(withFont: self.font)

        
        //MaskView
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shaowPath
        let insetValue: CGFloat = 18.0
        shapeLayer.frame = self.bounds.insetBy(dx: insetValue, dy: insetValue)
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.shadowOffset = .zero
        self.layer.addSublayer(shapeLayer)
        self.containerView.layer.mask = shapeLayer
        self.containerView.backgroundColor = backColor
        
        
        //First Ouuter Shadow
        firstOutterShadowView.clipsToBounds = false
        firstOutterShadowView.layer.shadowRadius = outterShadowRadius
        firstOutterShadowView.layer.shadowOpacity = firstOutterShadowNormalOpacity
        firstOutterShadowView.layer.shadowColor = firstOutterColor.cgColor
        firstOutterShadowView.layer.shadowOffset = .zero
        let firstOutterShadowPath = UIBezierPath(cgPath: shaowPath)
        let firstOutterShadowPathScaleX: CGFloat = (firstOutterShadowView.frame.width + selectedOutterOffset)/firstOutterShadowView.frame.width
        let firstOutterShadowPathScaleY: CGFloat = (firstOutterShadowView.frame.height + selectedOutterOffset)/firstOutterShadowView.frame.height
        firstOutterShadowPath.apply(CGAffineTransform(translationX: selectedOutterOffset + (-0.06*self.font.pointSize + 8.7) + (insetValue - 8.0), y: selectedOutterOffset + (-0.06*self.font.pointSize + 8.7) + (insetValue - 8.0)).scaledBy(x: firstOutterShadowPathScaleX, y: firstOutterShadowPathScaleY))
        firstOutterShadowView.layer.shadowPath = firstOutterShadowPath.cgPath
        


        //Second Outter Shadow
        secondOutterShadowView.clipsToBounds = false
        secondOutterShadowView.layer.shadowRadius = outterShadowRadius
        secondOutterShadowView.layer.shadowOpacity = secondOutterShadowNormalOpacity
        secondOutterShadowView.layer.shadowColor = secondOutterColor.cgColor
        secondOutterShadowView.layer.shadowOffset = .zero
        let secondOutterShadowPath = UIBezierPath(cgPath: shaowPath)
        let secondOutterShadowPathScaleX = (secondOutterShadowView.frame.width + selectedOutterOffset)/secondOutterShadowView.frame.width
        let secondOutterShadowPathScaleY = (secondOutterShadowView.frame.height + selectedOutterOffset)/secondOutterShadowView.frame.height
        secondOutterShadowPath.apply(CGAffineTransform(translationX: selectedOutterOffset + 9 + (insetValue - 8.0), y: selectedOutterOffset + 9 + (insetValue - 8.0)).scaledBy(x: secondOutterShadowPathScaleX, y: secondOutterShadowPathScaleY))
        secondOutterShadowView.layer.shadowPath = secondOutterShadowPath.cgPath


        //First Inner View
        firstInnerShadowView.frame = containerView.bounds
        let innerRadius: CGFloat = selectedInnderOffset
        let firstInnerPath = UIBezierPath(cgPath: shaowPath)
        let firstInnerPathScaleX = (firstInnerShadowView.frame.width + innerRadius)/firstInnerShadowView.frame.width
        let firstInnerPathScaleY = (firstInnerShadowView.frame.height + innerRadius)/firstInnerShadowView.frame.height
        firstInnerPath.apply(CGAffineTransform(scaleX: firstInnerPathScaleX, y: firstInnerPathScaleY))
        var firstCutOut = UIBezierPath(cgPath: shaowPath)
        let firstCutOutScaleX = (firstInnerShadowView.frame.width - innerRadius)/firstInnerShadowView.frame.width
        let firstCutOutScaleY = (firstInnerShadowView.frame.height - innerRadius)/firstInnerShadowView.frame.height
        firstCutOut.apply(CGAffineTransform(translationX: -(innerRadius * 3), y: -(innerRadius * 3)).scaledBy(x: firstCutOutScaleX, y: firstCutOutScaleY))
        firstCutOut = firstCutOut.reversing()
        firstInnerPath.append(firstCutOut)
        firstInnerShadowView.layer.shadowColor = firstInnerColor.cgColor
        firstInnerShadowView.layer.shadowOpacity = Float(firstInnerShadowSelectedOpacity)
        firstInnerShadowView.layer.shadowRadius = innerShadowRadius
        firstInnerShadowView.layer.shadowPath = firstInnerPath.cgPath
        firstInnerShadowView.layer.shadowOffset = .zero
        if firstInnerShadowView.superview == nil {containerView.addSubview(firstInnerShadowView)}
        

        //Second Inner View
        secondInnerShadowView.frame = containerView.bounds
        let secondInnerPath = UIBezierPath(cgPath: shaowPath)
        let secondInnerPathScaleX = (secondInnerShadowView.frame.width + innerRadius)/secondInnerShadowView.frame.width
        let secondInnerPathScaleY = (secondInnerShadowView.frame.height + innerRadius)/secondInnerShadowView.frame.height
        secondInnerPath.apply(CGAffineTransform(scaleX: secondInnerPathScaleX, y: secondInnerPathScaleY))
        var secondCutOut = UIBezierPath(cgPath: shaowPath)
        let secondCutOutScaleX = (secondInnerShadowView.frame.width - innerRadius)/secondInnerShadowView.frame.width
        let secondCutOutScaleY = (secondInnerShadowView.frame.height - innerRadius)/secondInnerShadowView.frame.height
        secondCutOut.apply(CGAffineTransform(translationX: innerRadius * 3, y: innerRadius * 3).scaledBy(x: secondCutOutScaleX, y: secondCutOutScaleY))
        secondCutOut = secondCutOut.reversing()
        secondInnerPath.append(secondCutOut)
        secondInnerShadowView.layer.shadowColor = secondInnerColor.cgColor
        secondInnerShadowView.layer.shadowOpacity = Float(secondInnerShadowSelectedOpacity)
        secondInnerShadowView.layer.shadowRadius = innerShadowRadius
        secondInnerShadowView.layer.shadowPath = secondInnerPath.cgPath
        secondInnerShadowView.layer.shadowOffset = .zero
        if secondInnerShadowView.superview == nil {containerView.addSubview(secondInnerShadowView)}


        configureState()
        
        heightConstraint.constant = shaowPath.boundingBox.height + (2 * insetValue)
        self.layoutIfNeeded()
        let boindingBoxMidY: CGFloat = shaowPath.boundingBox.midY
        let offset: CGFloat = self.boxView.frame.midY - boindingBoxMidY
//        self.boxView.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: offset))
        self.boxView.layer.setAffineTransform(CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: (offset - insetValue)/2 ))
    }

    private func configureState() {
            firstInnerShadowView.layer.shadowOpacity = firstInnerShadowNormalOpacity
            secondInnerShadowView.layer.shadowOpacity = secondInnerShadowNormalOpacity
            firstOutterShadowView.layer.shadowOpacity = firstOutterShadowNormalOpacity
            secondOutterShadowView.layer.shadowOpacity = secondOutterShadowNormalOpacity
    }

    func configureStyle() {
        
        self.firstOutterShadowSelectedOpacity = 0.0 //Upper Left
        self.firstOutterShadowNormalOpacity = 0.9 //Upper Left
        self.secondOutterShadowSelectedOpacity = 0.00 // lower Right
        self.secondOutterShadowNormalOpacity = 0.5 // lower Right
        self.firstInnerShadowSelectedOpacity = 0.6 //Lower Right
        self.firstInnerShadowNormalOpacity = 0.0 //Lower Right
        self.secondInnerShadowSelectedOpacity = 1.50 //Upper Left // 0.5
        self.secondInnerShadowNormalOpacity = 0.0 //Upper Left
        self.backColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 1)
        self.firstInnerColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) //Lower Right
        self.firstOutterColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) //Upper Left
        self.secondInnerColor = #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 1) // upper Left
        self.secondOutterColor = #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.7529411765, alpha: 1) // lower Right
        self.selectedOutterOffset = (0.01722222 * self.font.pointSize) + 0.33333333
        self.selectedInnderOffset = (0.01055556 * self.font.pointSize) + 0.53333333
        self.outterShadowRadius = (0.01277778 * self.font.pointSize) + 0.46666667
        self.innerShadowRadius = (0.37666667 * self.font.pointSize) - 11.2
        
        containerView.clipsToBounds = true
        
    }


}










