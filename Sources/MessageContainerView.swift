/*
 MIT License

 Copyright (c) 2017 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
import UIKit

open class MessageContainerView: UIView {

    override open var frame: CGRect {
        didSet {
            setNeedsDisplay()
        }
    }

    open var messageContainerColor: UIColor? {
        didSet {
            guard messageContainerColor != oldValue else { return }
            setNeedsDisplay()
        }
    }

    open override func draw(_ rect: CGRect) {

        let tailHeight: CGFloat = 10
        let tailWidth: CGFloat = 6
        let widthInset = UIEdgeInsets(top: 0, left: tailWidth, bottom: 0, right: 0)
        let insetRect = UIEdgeInsetsInsetRect(rect, widthInset)

        messageContainerColor?.setFill()

        /* Bottom Left Unrounded Edge
        let messageBasePath = UIBezierPath(roundedRect: insetRect, byRoundingCorners: [.topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        */

        /*
        // Bottom Left Triangle Tail
        let messageBasePath = UIBezierPath(roundedRect: insetRect, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10, height: 10))

        let tailPath = UIBezierPath()
        let triangleStart = CGPoint(x: insetRect.minX, y: insetRect.maxY - (tailHeight * 2))
        let trianglePeak = CGPoint(x: insetRect.minX - tailWidth, y: insetRect.maxY - (tailHeight * 1.5))
        tailPath.move(to: triangleStart)
        tailPath.addLine(to: trianglePeak)
        let triangleEnd = CGPoint(x: insetRect.minX, y: insetRect.maxY - tailHeight)
        tailPath.addLine(to: triangleEnd)
        tailPath.close()
        tailPath.fill()
        messageBasePath.fill()
        */

        // Bottom Left Curved Tail
        let messageBasePath = UIBezierPath(roundedRect: insetRect, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10, height: 10))
        let tailPath = UIBezierPath()

        let tailStartPoint = CGPoint(x: insetRect.minX, y: insetRect.maxY - tailHeight)
        let tailBottomPoint = CGPoint(x: insetRect.minX - tailWidth, y: insetRect.maxY)
        let controlPoint1 = CGPoint(x: tailHeight/2, y: insetRect.maxY - tailWidth)
        tailPath.move(to: tailStartPoint)
        tailPath.addQuadCurve(to: tailBottomPoint, controlPoint: controlPoint1)

        let tailMiddlePoint = CGPoint(x: tailWidth * 2, y: insetRect.maxY - ((tailWidth * 2)/3))
        let controlPoint2 = CGPoint(x: tailWidth, y: insetRect.maxY - 1)
        tailPath.addQuadCurve(to: tailMiddlePoint, controlPoint: controlPoint2)
        tailPath.close()
        tailPath.fill()
        messageBasePath.fill()
    }

}
