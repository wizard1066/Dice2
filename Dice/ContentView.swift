//

//  ContentView.swift

//  Access

//

//  Created by localuser on 06.05.20.

//  Copyright © 2020 localuser. All rights reserved.

//


import SwiftUI
import GameplayKit

struct Fonts {
  static func avenirNextCondensedBold (size:CGFloat) -> Font{
    return Font.custom("AvenirNextCondensed-Bold",size: size)
  }
  
  static func avenirNextCondensedMedium (size:CGFloat) -> Font{
    return Font.custom("AvenirNextCondensed-Medium",size: size)
  }
}

let dotSize:CGFloat = 24
let diceSize:CGFloat = 128
let fieldSide:CGFloat = 32
let diceSpeed:Double = 0.2

let d6 = GKRandomDistribution.d6()

var diceViews:[AnyView] = [AnyView(oneDotDice()),AnyView(twoDotDice()),AnyView(threeDotDice()),AnyView(fourDotDice()),AnyView(fiveDotDice()),AnyView(sixDotDice())]

struct ContentView: View {
  var body: some View {
    DiceView()
  }
}

struct ContentViewU: View {
@State var degree:Double = 0
@State var mover = CGSize(width:0, height:0)
@State var swinger:UnitPoint = .trailing
@State var action:CGFloat = -1
var body: some View {
   ZStack {
        Rectangle()
          .stroke(Color.black)
          .frame(width: 128, height: 128, alignment: .center)
        Circle()
          .stroke(Color.black)
          .frame(width: 120, height: 120, alignment: .center)
        
        Circle()
          .stroke(Color.black)
          .frame(width: 28, height: 28, alignment: .center)
      }.rotation3DEffect(.degrees(degree), axis: (x: 0, y: action, z: 0), anchor: swinger, anchorZ: 0, perspective: 0.5)
        .onTapGesture {
          self.swinger = UnitPoint.trailing
          self.action = -1
          self.degree = 0
          self.mover.width = 0
          withAnimation(.linear(duration: 1)) {
            self.degree = 90
            self.mover.width -= 128
          }
          DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.swinger = UnitPoint.leading
            self.action = -1
            self.mover.width = 0
            withAnimation(.linear(duration: 1)) {
              self.degree = 180
              self.mover.width = 128
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
              self.swinger = UnitPoint.trailing
              self.action = -1
              self.mover.width = -128
              withAnimation(.linear(duration: 1)) {
                self.degree = 270
                self.mover.width = 0
              }
              DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.swinger = UnitPoint.leading
                self.action = 1
                self.mover.width = 128
                self.degree = 90
                withAnimation(.linear(duration: 1)) {
                  self.degree = 0
                  self.mover.width = 0
                }
              })
            })
          })
      }
      .offset(mover)
}
}

struct ContentView2: View {
@State var degree1:Double = 0
@State var degree2:Double = 90
@State var yAxis:CGFloat = 0
@State var xAxis1:CGFloat = 0
@State var xAxis2:CGFloat = 0
@State var zAxis:CGFloat = 0
@State var anchorValue1 = UnitPoint.leading
@State var anchorValue2 = UnitPoint.trailing
@State var slide:CGFloat = 0
var body: some View {
VStack {
HStack {
ZStack {
        Image("steveJ")
          .resizable()
          .frame(width: 141, height: 199, alignment: .center)
        
        .onTapGesture {
          withAnimation(.linear(duration: 2)) {
            self.degree2 = 90
            self.degree1 = 0
            self.slide = -141
          }
        }

      }.rotation3DEffect(.degrees(degree2), axis: (x: 0, y: 1, z: zAxis), anchor: anchorValue2, anchorZ: 0, perspective: 0.3)
      .offset(x: slide, y: 0)
ZStack {
        Image("steveJ")
          .resizable()
          .frame(width: 141, height: 199, alignment: .center)
        
        .onTapGesture {
          withAnimation(.linear(duration: 2)) {
            self.degree1 = 90
            self.degree2 = 0
            self.slide = 0
          }
        }

        

      }.rotation3DEffect(.degrees(degree1), axis: (x: 0, y: 1, z: zAxis), anchor: anchorValue1, anchorZ: 0, perspective: 0.3)
      .offset(x: slide, y: 0)
      
      
      
  }
  }
  }
}

struct DiceView: View {
  //  @State var showView = true
  enum SwipeHVDirection: String {
    case left, right, up, down, none
  }
  
  enum DiceFace: String {
    case one, two, three, four, five, six
  }
  
  enum DiceSides: Int {
    case one = 0
    case two
    case three
    case four
    case five
    case six
  }
  
  @State var source:DiceFace = .one
  
  
  @State var lowInt:Int = 0
  @State var midInt:Int = 1
  @State var highInt:Int = 2
  @State var ultraInt:Int = 3
  @State var topInt: Int = 4
  @State var botInt: Int = 5
  @State var q1 = CGSize(width: 0, height: 0)
  @State var q2 = CGSize(width: 128, height: 0)
  @State var q3 = CGSize(width: 128, height: 0)
  @State var q4 = CGSize(width: 128, height: 0)
  @State var q5 = CGSize(width: 0, height: 0)
  @State var q6 = CGSize(width: 0, height: 0)
  @State var p1 = 0
  @State var p2 = 90
  @State var p3 = 90
  @State var p4 = 90
  @State var p5 = 90
  @State var p6 = 90
  @State var y1:CGFloat = 1
  @State var y2:CGFloat = 1
  @State var y3:CGFloat = 1
  @State var y4:CGFloat = 1
  @State var y5:CGFloat = 0
  @State var y6:CGFloat = 0
  @State var x1:CGFloat = -1
  @State var x2:CGFloat = 0
  @State var x3:CGFloat = 0
  @State var x4:CGFloat = 0
  @State var x5:CGFloat = 90
  @State var x6:CGFloat = 90
  @State var f1:UnitPoint = .leading
  @State var f2:UnitPoint = .leading
  @State var f3:UnitPoint = .leading
  @State var f4:UnitPoint = .leading
  @State var f5:UnitPoint = .top
  @State var f6:UnitPoint = .top
  
  //  @State var swipeDirection: SwipeHVDirection = .none { didSet { print(swipeDirection) } }
  
  
  
  var body: some View {
    
    func detectDirection(value: DragGesture.Value) -> SwipeHVDirection {
      if value.startLocation.x < value.location.x - 24 {
        return .left
      }
      if value.startLocation.x > value.location.x + 24 {
        return .right
      }
      if value.startLocation.y < value.location.y - 24 {
        return .down
      }
      if value.startLocation.y > value.location.y + 24 {
        return .up
      }
      return .none
    }
    
    return VStack {
//      ZStack {
//
//        Circle()
//          .stroke(Color.black)
//          .frame(width: 64, height: 64, alignment: .center)
//        Circle()
//          .fill(Color.red)
//          .frame(width: 64, height: 64, alignment: .center)
//          .opacity(0.6)
//          .offset(x: 2, y: 2)
//      }.rotation3DEffect(.degrees(degree), axis: (x: 0, y: action, z: 0), anchor: swinger, anchorZ: 0, perspective: 0.2)
     
      
      
      
      ZStack {
        diceViews[DiceSides.six.rawValue]
          .rotation3DEffect(.degrees(Double(p6)), axis: (x: self.x6, y:self.y6 , z: 0), anchor: self.f6, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q6)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              if direction == .up {
                self.x6 = 1
                self.f6 = UnitPoint.bottom
                self.y6 = 0
                
                switch self.source {
                case .one:
                  self.f3 = UnitPoint.top
                  self.y3 = 0
                  self.x3 = -1
                  self.p3 = 90
                  self.q3.height = 128
                  self.q3.width = 0
                case .two:
                  self.f4 = UnitPoint.top
                  self.y4 = 0
                  self.x4 = -1
                  self.p4 = 90
                  self.q4.height = 128
                  self.q4.width = 0
                case .three:
                  self.f1 = UnitPoint.top
                  self.y1 = 0
                  self.x1 = -1
                  self.p1 = 90
                  self.q1.height = 128
                  self.q1.width = 0
                case .four:
                  self.f2 = UnitPoint.top
                  self.y2 = 0
                  self.x2 = -1
                  self.p2 = 90
                  self.q2.height = 128
                  self.q2.width = 0
                default:
                  print("oops")
                  break
                }
              
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p6 = 90
                  self.q6.height = -128
                  
                  switch self.source {
                  case .one:
                    self.q3.height = 0
                    self.p3 = 0
                  case .two:
                    self.q4.height = 0
                    self.p4 = 0
                  case .three:
                    self.q1.height = 0
                    self.p1 = 0
                  case .four:
                    self.q2.height = 0
                    self.p2 = 0
                  default:
                    print("oops")
                    break
                  }
                }
              }
              if direction == .down {
                self.y6 = 0
                self.x6 = -1
                self.f6 = UnitPoint.top
                
                switch self.source {
                case .one:
                  self.f1 = UnitPoint.bottom
                  self.x1 = 1
                  self.y1 = 0
                  self.p1 = 90
                  self.q1.height = -128
                case .two:
                  self.f2 = UnitPoint.bottom
                  self.x2 = 1
                  self.y2 = 0
                  self.p2 = 90
                  self.q2.height = -128
                case .three:
                  self.f3 = UnitPoint.bottom
                  self.x3 = 1
                  self.y3 = 0
                  self.p3 = 90
                  self.q3.height = -128
                  self.q3.width = 0
                case .four:
                  self.f4 = UnitPoint.bottom
                  self.x4 = 1
                  self.y4 = 0
                  self.p4 = 90
                  self.q4.height = -128
                  self.q4.width = 0
                default:
                  print("fooBar ",self.source)
                  break
                  // do nothing
                }
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p6 = 90
                  self.q6.height = 128
                  
                  switch self.source {
                  case .one:
                    self.q1.height = 0
                    self.p1 = 0
                  case .two:
                    self.q2.height = 0
                    self.p2 = 0
                  case .three:
                    self.q3.height = 0
                    self.p3 = 0
                  case .four:
                    self.q4.height = 0
                    self.p4 = 0
                  default:
                    print("fooBar ",self.source)
                    break
                  }
                  
                }
              }
              if direction == .left {
                print("six left")
              }
              if direction == .right {
                print("six right")
              }
          })
        
        
        // five
        diceViews[DiceSides.five.rawValue]
          .rotation3DEffect(.degrees(Double(p5)), axis: (x: self.x5, y:self.y5 , z: 0), anchor: self.f5, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q5)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              print("direction ",direction,self.source)
              if direction == .up {
                self.x5 = 1
                self.f5 = UnitPoint.bottom
                
                switch self.source {
                case .one:
                  self.f1 = UnitPoint.top
                  self.y1 = 0
                  self.p1 = 90
                  self.q1.height = 128
                case .two:
                  self.f2 = UnitPoint.top
                  self.y2 = 0
                  self.p2 = 90
                  self.q2.height = 128
                case .three:
                  self.f3 = UnitPoint.top
                  self.y3 = 0
                  self.p3 = 90
                  self.q3.height = 128
                case .four:
                  self.f4 = UnitPoint.top
                  self.y4 = 0
                  self.p4 = 90
                  self.q4.height = 128
                default:
                  print("fooBar ",self.source)
                  break
                  // do nothing
                }
                
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p5 = 90
                  self.q5.height = -128
                  
                switch self.source {
                  case .one:
                    self.q1.height = 0
                    self.p1 = 0
                  case .two:
                    self.q2.height = 0
                    self.p2 = 0
                  case .three:
                    self.q3.height = 0
                    self.p3 = 0
                  case .four:
                    self.q4.height = 0
                    self.p4 = 0
                  default:
                    print("fooBar ",self.source)
                    break
                  }
                }
              }
              if direction == .down {
                self.y5 = 0
                self.x5 = -1
                self.f5 = UnitPoint.top
                
                switch self.source {
                case .one:
                  self.f3 = UnitPoint.bottom
                  self.x3 = 1
                  self.y3 = 0
                  self.p3 = 90
                  self.q3.height = -128
                  self.q3.width = 0
                case .two:
                  self.f4 = UnitPoint.bottom
                  self.x4 = 1
                  self.y4 = 0
                  self.p4 = 90
                  self.q4.height = -128
                  self.q4.width = 0
                case .three:
                  self.f1 = UnitPoint.bottom
                  self.x1 = 1
                  self.y1 = 0
                  self.p1 = 90
                  self.q1.height = -128
                  self.q1.width = 0
                case .four:
                  self.f2 = UnitPoint.bottom
                  self.x2 = 1
                  self.y2 = 0
                  self.p2 = 90
                  self.q2.height = -128
                  self.q2.width = 0
                default:
                  print("fooBar ",self.source)
                  break
                }
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p5 = 90
                  self.q5.height = 128
                  
                  switch self.source {
                  case .one:
                    self.q3.height = 0
                    self.p3 = 0
                  case .two:
                    self.q4.height = 0
                    self.p4 = 0
                  case .three:
                    self.q1.height = 0
                    self.p1 = 0
                  case .four:
                    self.q2.height = 0
                    self.p2 = 0
                  default:
                    print("fooBar ",self.source)
                    break
                  }
                }
              }
              if direction == .left {
                print("five left")
              }
              if direction == .right {
                print("five right")
              }
            }
        )
        
        
        diceViews[DiceSides.one.rawValue]
          // dice face 1
          .rotation3DEffect(.degrees(Double(p1)), axis: (x: self.x1, y: self.y1, z: 0), anchor: self.f1, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q1)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              if direction == .up {
                self.source = .one
                self.x1 = 1
                self.f1 = UnitPoint.bottom
                self.y1 = 0
                
                self.f6 = UnitPoint.top
                self.y6 = 0
                self.x6 = -1
                self.p6 = 90
                self.q6.height = 128
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p1 = 90
                  self.q1.height = -128
                  
                  self.q6.height = 0
                  self.p6 = 0
                }
              }
              if direction == .down {
                print("1down")
                self.source = .one
                self.y1 = 0
                self.x1 = -1
                self.f1 = UnitPoint.top
                self.q1.width = 0
                
                self.f5 = UnitPoint.bottom
                self.x5 = 1
                self.y5 = 0
                self.p5 = 90
                self.q5.height = -128
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p1 = 90
                  self.q1.height = 128
                  
                  self.q5.height = 0
                  self.p5 = 0
                  
                }
              }
              if direction == .left {
                self.x1 = 0
                self.y1 = 1
                self.f1 = UnitPoint.leading
                
                self.f4 = UnitPoint.trailing
                self.y4 = -1
                self.x4 = 0
                self.q4.width = -128
                self.q4.height = 0
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p1 = 90
                  self.q1.width = 128
                  self.p4 = 0
                  self.q4.width = 0
                }
              }
              if direction == .right  {
                self.x1 = 0
                self.y1 = -1
                self.f1 = UnitPoint.trailing
                
                self.y2 = 1
                self.x2 = 0
                self.f2 = UnitPoint.leading
                self.q2.width = 128
                self.q2.height = 0
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p1 = 90
                  self.q1.width = -128
                  self.p2 = 0
                  self.q2.width = 0
                }
              }
            }
        )
        
        
        diceViews[DiceSides.two.rawValue]
          .rotation3DEffect(.degrees(Double(p2)), axis: (x: self.x2, y: self.y2, z: 0), anchor: self.f2, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q2)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              if direction == .left {
                self.x2 = 0
                self.y2 = 1
                self.f2 = UnitPoint.leading
                
                self.y1 = -1
                self.x1 = 0
                self.f1 = UnitPoint.trailing
                self.q1.width = -128
                
                self.q1.height = 0
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p2 = 90
                  self.q2.width = 128
                  
                  self.p1 = 0
                  self.q1.width = 0
                }
              }
              if direction == .right {
                self.x2 = 0
                self.y2 = -1
                
                self.f2 = UnitPoint.trailing
                
                self.y3 = 1
                self.x3 = 0
                self.f3 = UnitPoint.leading
                self.q3.width = 128
                self.q3.height = 0
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p2 = 90
                  self.q2.width = -128
                  self.p3 = 0
                  self.q3.width = 0
                }
              }
              if direction == .up {
                self.source = .two
                self.x2 = 1
                self.f2 = UnitPoint.bottom
                self.y2 = 0
                
                self.f6 = UnitPoint.top
                self.y6 = 0
                self.x6 = -1
                self.y6 = 0
                self.p6 = 90
                self.q6.height = 128
                self.q2.width = 0
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p2 = 90
                  self.q2.height = -128
                  
                  self.q6.height = 0
                  self.p6 = 0
                }
              }
              if direction == .down {
                self.source = .two
                self.y2 = 0
                self.x2 = -1
                self.f2 = UnitPoint.top
                
                self.f5 = UnitPoint.bottom
                self.x5 = 1
                self.y5 = 0
                self.p5 = 90
                self.q5.height = -128
                self.q2.width = 0
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p2 = 90
                  self.q2.height = 128
                  
                  self.q5.height = 0
                  self.p5 = 0
                  
                }
              }
            }
        )
        
        diceViews[DiceSides.three.rawValue]
          .rotation3DEffect(.degrees(Double(p3)), axis: (x: self.x3, y: self.y3, z: 0), anchor: self.f3, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q3)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              if direction == .left {
                self.x3 = 0
                self.y3 = 1
                self.f3 = UnitPoint.leading
                
                self.y2 = -1
                self.f2 = UnitPoint.trailing
                self.q2.width = -128
                
                self.q2.height = 0
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p3 = 90
                  self.q3.width = 128
                  self.p2 = 0
                  self.q2.width = 0
                }
              }
              if direction == .right {
                self.x3 = 0
                self.y3 = -1
                self.f3 = UnitPoint.trailing
                
                self.y4 = 1
                self.x4 = 0
                self.f4 = UnitPoint.leading
                self.q4.width = 128
                self.q4.height = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p3 = 90
                  self.q3.width = -128
                  self.p4 = 0
                  self.q4.width = 0
                }
              }
              if direction == .up {
                print("3up")
                self.source = .three
                self.x3 = 1
                self.f3 = UnitPoint.bottom
                self.y3 = 0
                self.q3.width = 0
                
                self.f6 = UnitPoint.top
                self.y6 = 0
                self.x6 = -1
                self.p6 = 90
                self.q6.height = 128
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p3 = 90
                  self.q3.height = -128
                  
                  self.q6.height = 0
                  self.p6 = 0
                }
              }
              if direction == .down {
                print("3down")
                self.source = .three
                self.x3 = -1
                self.f3 = UnitPoint.top
                self.y3 = 0
                self.q3.width = 0
                
                self.f5 = UnitPoint.bottom
                self.x5 = 1
                self.y5 = 0
                self.p5 = 90
                self.q5.height = -128
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p3 = 90
                  self.q3.height = 128
                  
                  self.q5.height = 0
                  self.p5 = 0
                  
                }
              }
            }
        )
        
        diceViews[DiceSides.four.rawValue]
          .rotation3DEffect(.degrees(Double(p4)), axis: (x: self.x4, y: self.y4, z: 0), anchor: self.f4, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q4)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              if direction == .left {
                
                self.x4 = 0
                self.y4 = 1
                self.f4 = UnitPoint.leading
                
                self.y3 = -1
                self.f3 = UnitPoint.trailing
                self.q3.width = -128
                self.q3.height = 0
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p4 = 90
                  self.q4.width = 128
                  self.p3 = 0
                  self.q3.width = 0
                }
              }
              if direction == .right {
                self.x4 = 0
                self.y4 = -1
                self.f4 = UnitPoint.trailing
                
                self.y1 = 1
                self.x1 = 0
                self.f1 = UnitPoint.leading
                self.q1.width = 128
                self.q1.height = 0
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p4 = 90
                  self.q4.width = -128
                  self.p1 = 0
                  self.q1.width = 0
                }
              }
              if direction == .up {
                self.source = .four
                self.x4 = 1
                self.f4 = UnitPoint.bottom
                self.y4 = 0
                
                self.f6 = UnitPoint.top
                self.y6 = 0
                self.x6 = -1
                self.p6 = 90
                self.q6.height = 128
                self.q4.width = 0
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p4 = 90
                  self.q4.height = -128
                  
                  self.q6.height = 0
                  self.p6 = 0
                }
              }
              if direction == .down {
                self.source = .four
                self.y4 = 0
                self.x4 = -1
                self.f4 = UnitPoint.top
                self.q4.width = 0
                
                self.f5 = UnitPoint.bottom
                self.x5 = 1
                self.y5 = 0
                self.p5 = 90
                self.q5.height = -128
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p4 = 90
                  self.q4.height = 128
                  
                  self.q5.height = 0
                  self.p5 = 0
                  
                }
              }
            }
        )
      }
      
    }
  }
}

struct oneDotDiceV: View {
  var body: some View {
    //    Image("d1")
    //      .resizable()
    //      .frame(width: 128, height: 128, alignment: .center)
    VStack {
      ZStack {
        Rectangle()
          .fill(Color.clear)
          .overlay(Rectangle().stroke(Color.black))
          .frame(width: 128, height: 128, alignment: .center)
        Circle()
          .fill(Color.clear)
          .overlay(Circle().stroke(Color.black))
          .frame(width: 120, height: 120, alignment: .center)
        Circle()
          .stroke(Color.black)
          .frame(width: 28, height: 28, alignment: .center)
      }
    }
  }
}

struct twoDotDiceV: View {
  var body: some View {
    //    Image("d2")
    //    .resizable()
    //      .frame(width: 128, height: 128, alignment: .center)
    VStack {
      ZStack {
        Rectangle()
          .fill(Color.clear)
          .overlay(Rectangle().stroke(Color.black))
          .frame(width: 128, height: 128, alignment: .center)
        Circle()
          .fill(Color.clear)
          .overlay(Circle().stroke(Color.black))
          .frame(width: 120, height: 120, alignment: .center)
        Circle()
          .stroke(Color.black)
          .frame(width: 28, height: 28, alignment: .center)
      }
    }
  }
}

struct threeDotDiceV: View {
  var body: some View {
    //    Image("d3")
    //    .resizable()
    //      .frame(width: 128, height: 128, alignment: .center)
    
    VStack {
      ZStack {
        Rectangle()
          .fill(Color.clear)
          .overlay(Rectangle().stroke(Color.black))
          .frame(width: 128, height: 128, alignment: .center)
        Circle()
          .fill(Color.clear)
          .overlay(Circle().stroke(Color.black))
          .frame(width: 120, height: 120, alignment: .center)
        Circle()
          .stroke(Color.black)
          .frame(width: 28, height: 28, alignment: .center)
      }
    }
    
  }
}

struct fourDotDiceV: View {
  var body: some View {
    //    Image("d4")
    //    .resizable()
    //      .frame(width: 128, height: 128, alignment: .center)
    
    VStack {
      ZStack {
        Rectangle()
          .fill(Color.clear)
          .overlay(Rectangle().stroke(Color.black))
          .frame(width: 128, height: 128, alignment: .center)
        Circle()
          .fill(Color.clear)
          .overlay(Circle().stroke(Color.black))
          .frame(width: 120, height: 120, alignment: .center)
        Circle()
          .stroke(Color.black)
          .frame(width: 28, height: 28, alignment: .center)
      }
    }
    
  }
}

struct fiveDotDiceV: View {
  var body: some View {
    Image("d5")
  }
}

struct sixDotDiceV: View {
  var body: some View {
    Image("d6")
  }
}


struct oneDotDice: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: diceSize, height: diceSize, alignment: .center)
      //        .border(Color.black)
      Circle()
        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: 120, height: 120, alignment: .center)
      Circle()
        .fill(Color.white)
        .frame(width: dotSize, height: dotSize, alignment: .center)
    }
  }
}

struct twoDotDice: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: diceSize, height: diceSize, alignment: .center)
      //      .border(Color.black)
      Circle()
        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: 120, height: 120, alignment: .center)
      HStack {
        Spacer()
        Circle()
          .fill(Color.white)
          .frame(width: dotSize, height: dotSize, alignment: .center)
        Spacer()
        Circle()
          .fill(Color.white)
          .frame(width: dotSize, height: dotSize, alignment: .center)
        Spacer()
      }.frame(width: diceSize, height: diceSize, alignment: .center)
    }
  }
}

struct threeDotDice: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: diceSize, height: diceSize, alignment: .center)
      //      .border(turn ? Color.black: Color.clear)
      Circle()
        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: 120, height: 120, alignment: .center)
            HStack {
              Spacer()
              Circle()
                .fill(Color.white)
                .frame(width: dotSize, height: dotSize, alignment: .center)
              Spacer()
              Circle()
                .fill(Color.white)
                .frame(width: dotSize, height: dotSize, alignment: .center)
              Spacer()
              Circle()
                .fill(Color.white)
                .frame(width: dotSize, height: dotSize, alignment: .center)
              Spacer()
            }
        .frame(width: diceSize, height: diceSize, alignment: .center)
        .rotationEffect(.degrees(45))
    }
  }
}

//struct threeDotAux: View {
//  var body: some View {
//    HStack {
//      Spacer()
//      Circle()
//        .fill(Color.white)
//        .frame(width: dotSize, height: dotSize, alignment: .center)
//      Spacer()
//      Circle()
//        .fill(Color.white)
//        .frame(width: dotSize, height: dotSize, alignment: .center)
//      Spacer()
//      Circle()
//        .fill(Color.white)
//        .frame(width: dotSize, height: dotSize, alignment: .center)
//      Spacer()
//    }
//  }
//}

struct fourDotDice: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: diceSize, height: diceSize, alignment: .center)
      //      .border(Color.black)
      Circle()
        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: 120, height: 120, alignment: .center)
      VStack {
        HStack {
          Spacer()
            .frame(width: fieldSide )
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide )
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide)
        } // HStack
        Spacer()
          .frame(height: fieldSide )
        HStack {
          Spacer()
            .frame(width: fieldSide)
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide )
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide)
        } // HStack
      }.frame(width: diceSize, height: diceSize, alignment: .center)
      //VStack
      
    }
  }
}

struct fiveDotDice: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: diceSize, height: diceSize, alignment: .center)
      //      .border(Color.black)
      Circle()
        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: 120, height: 120, alignment: .center)
      Circle()
        .fill(Color.white)
        .frame(width: dotSize, height: dotSize, alignment: .center)
      VStack {
        HStack {
          Spacer()
            .frame(width: fieldSide )
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide )
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide)
        } // HStack
        
        Spacer()
          .frame(height: fieldSide )
        HStack {
          Spacer()
            .frame(width: fieldSide)
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide )
          Circle()
            .fill(Color.white)
            .frame(width: dotSize, height: dotSize, alignment: .center)
          Spacer()
            .frame(width: fieldSide)
        } // HStack
      }.frame(width: diceSize, height: diceSize, alignment: .center)
      //VStack
      
    }
  }
}

struct sixDotDice: View {
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: diceSize, height: diceSize, alignment: .center)
      Circle()
        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .frame(width: 120, height: 120, alignment: .center)
        
     HStack {
      Circle()
        .fill(Color.white)
        .frame(width: dotSize, height: dotSize, alignment: .center)
     
      Circle()
        .fill(Color.white)
        .frame(width: dotSize, height: dotSize, alignment: .center)
      
      Circle()
        .fill(Color.white)
        .frame(width: dotSize, height: dotSize, alignment: .center)
    }.offset(CGSize(width: 0, height: 24))
    HStack {
      Circle()
        .fill(Color.white)
        .frame(width: dotSize, height: dotSize, alignment: .center)
     
      Circle()
        .fill(Color.white)
        .frame(width: dotSize, height: dotSize, alignment: .center)
      
      Circle()
        .fill(Color.white)
        .frame(width: dotSize, height: dotSize, alignment: .center)
    }.offset(CGSize(width: 0, height: -24))
    
    }
  }
}


extension Color {
  init(_ hex: Int, opacity: Double = 1.0) {
    let red = Double((hex & 0xff0000) >> 16) / 255.0
    let green = Double((hex & 0xff00) >> 8) / 255.0
    let blue = Double((hex & 0xff) >> 0) / 255.0
    self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
  }
}
