//
//  ChartView.swift
//  Graph
//
//  Created by PRIYANS on 9/12/19.
//  Copyright © 2019 PRIYANS. All rights reserved.
//

import Foundation
import Macaw

class ChartView: MacawView {
    
    static let data: [Double] = [101, 142, 66, 178, 92]
    static let palette = [0xf08c00, 0xbf1a04, 0xffd505, 0x8fcc16, 0xd1aae3].map { val in Color(val: val)}
    static var animations = [Animation]()
    
    required init?(coder aDecoder: NSCoder) {
        let button = ChartView.createButton()
        let chart = ChartView.createChart(button)
        super.init(node: Group(contents: [button, chart]), coder: aDecoder)
        backgroundColor = .clear
    }
    
    private static func createButton() -> Group {
           let shape = Shape(
               form: Rect(x: -100, y: -15, w: 200, h: 30).round(r: 5),
               fill: LinearGradient(degree: 90, from: Color(val: 0xfcc07c), to: Color(val: 0xfc7600)),
               stroke: Stroke(fill: Color(val: 0xff9e4f), width: 1))

           let text = Text(
               text: "Show", font: Font(name: "Serif", size: 21),
               fill: Color.white, align: .mid, baseline: .mid)

        

           return Group(contents: [shape, text], place: .move(dx: 375 / 2, dy: 75))
       }
    
    private static func createChart(_ button: Node) -> Group {
        var items: [Node] = []
        for i in 1...6 {
            let y = 200 - Double(i) * 30.0
            items.append(Line(x1: 0, y1: y, x2: 275, y2: y).stroke(fill: Color.white.with(a: 0.25)))
            let text = Text(text: "\(i*30)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            text.fill = Color.white
            items.append(text)
        }
        items.append(createBars(button))
        items.append(Line(x1: 0, y1: 200, x2: 275, y2: 200).stroke(fill: Color.white))
        items.append(Line(x1: 0, y1: 0, x2: 0, y2: 200).stroke(fill: Color.white))
        return Group(contents: items, place: .move(dx: 50, dy: 200))
    }

    private static func createBars(_ button: Node) -> Group {
        var items: [Node] = []
        
        for (i, item) in data.enumerated() {
            let bar = Shape(
                form: Rect(x: Double(i) * 50 + 25, y: 0, w: 30, h: item),
                fill: LinearGradient(degree: 90, from: palette[i], to: palette[i].with(a: 0.3)),
                place: .scale(sx: 1, sy: 0))
            items.append(bar)
            animations.append(bar.placeVar.animation(to: .move(dx: 0, dy: -data[i]), delay: Double(i) * 0.1))
            button.onTap { _ in animations.combine().play()
            }
            
        }
        return Group(contents: items, place: .move(dx: 0, dy: 200))
    }

    
}
