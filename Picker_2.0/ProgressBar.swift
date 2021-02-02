//
//  ProgressBar.swift
//  Picker_2.0
//
//  Created by Vilius Bundulas on 2021-01-23.
//

import UIKit

class ProgressBar: UIView {

    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var progressTextLayer: CATextLayer!
    private var progressDescriptionTextLayer: CATextLayer!
    
    var numberOfStudents: Int = 12 {
        didSet {
            didStudentListUpdated()
        }
    }
    var progress: Int = 0 {
        didSet {
            didProgressUpdated()
            
        }
    }
    
//MARK:- Custom shape drawing

    override func draw(_ rect: CGRect) {
        let center = UIView(frame: rect).center
        let radius = CGFloat(55)
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        let lineWidth = CGFloat(12.0)
        
        let strokeShapeColor = UIColor(red: 73.0/255, green: 159.0/255.0, blue: 213.0/255.0, alpha: 1)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        backgroundLayer = CAShapeLayer()
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.fillColor = .none
        backgroundLayer.lineCap = .round

        foregroundLayer = CAShapeLayer()
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.strokeColor = strokeShapeColor.cgColor
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = .none
        foregroundLayer.lineCap = .round
        foregroundLayer.strokeEnd = 0.005
        
        progressTextLayer = createProgressTextLayer(rect: rect)
        progressDescriptionTextLayer = createProgressTextDescriptionLayer(rect: rect)
        
        layer.addSublayer(progressDescriptionTextLayer)
        layer.addSublayer(progressTextLayer)
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
    }

//MARK:- Progress text layer
    
    private func createProgressTextLayer(rect: CGRect) -> CATextLayer {
        let width = rect.width
        let height = rect.height
        let fontSize = CGFloat(30)
        let offset = min(width, height) / 2
        
        let layer = CATextLayer()
        layer.string = "\(progress)/\(numberOfStudents)"
        layer.backgroundColor = .none
        layer.foregroundColor = UIColor.black.cgColor
        layer.fontSize = fontSize
        layer.frame = CGRect(x: 0, y: (height - fontSize - offset), width: width, height: fontSize + offset)
        layer.alignmentMode = .center
        
        
        return layer
    }

//MARK:- Progress text description layer
    
    private func createProgressTextDescriptionLayer(rect: CGRect) -> CATextLayer {
        let width = rect.width
        let height = rect.height
        let fontSize = CGFloat(18)
        let offset = min(width, height) / 2.6
        
        let layer = CATextLayer()
        layer.string = "Progresas"
        layer.backgroundColor = .none
        layer.foregroundColor = UIColor.black.cgColor
        layer.fontSize = fontSize
        layer.frame = CGRect(x: 0, y: (height - fontSize - offset), width: width, height: fontSize + offset)
        layer.alignmentMode = .center
        
        
        return layer
    }

//MARK:- Did progress updated func
    
     func didProgressUpdated() {
        progressTextLayer?.string = "\(progress)/\(numberOfStudents)"
        foregroundLayer?.strokeEnd = CGFloat(progress) / CGFloat(numberOfStudents)
        print("\(self.progress) from progress bar") // just checking if its updating value here
    }
    
    func didStudentListUpdated() {
        progressTextLayer?.string = "\(progress)/\(numberOfStudents)"
    }
}
