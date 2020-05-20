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
let diceSpeed:Double = 0.5

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

struct diceMap {
  var diceID: String!
  var sourceDegreeStart: Int!
  var sourceDegreeFinish: Int!
  var sourceAnchor: UnitPoint!
  var sourceAxisX: CGFloat!
  var sourceAxisY: CGFloat!
  var sourceAxisZ: CGFloat!
  
  var targetDegreeStart: Int!
  var targetDegreeFinish: Int!
  var targetAnchor: UnitPoint!
  var targetAxisX: CGFloat!
  var targetAxisY: CGFloat!
  var targetAxisZ: CGFloat!
}

var diceLocation = [String:diceMap]()

struct DiceView: View {
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
  
  enum Latitude: String {
    case A1,B3,C6,D4
  }
  
  enum Longitude: String {
    case A1,B2,C6,D5
  }
  
  func nextVLongitude(state: Longitude) -> Longitude? {
    switch state {
      case .A1:
        return .B2
      case .B2:
        return .C6
      case .C6:
        return .D5
      case .D5:
        return .A1
    }
    return nil
  }
  
  func prevVLongitude(state: Longitude) -> Longitude? {
    switch state {
      case .A1:
        return .D5
      case .B2:
        return .A1
      case .C6:
        return .B2
      case .D5:
        return .C6
    }
    return nil
  }
  
  func nextVLatitude(state: Latitude) -> Latitude? {
    switch state {
      case .A1:
        return .B3
      case .B3:
        return .C6
      case .C6:
        return .D4
      case .D4:
        return .A1
    }
    return nil
  }
  
  func prevVLatitude(state: Latitude) -> Latitude? {
    switch state {
      case .A1:
        return .D4
      case .B3:
        return .A1
      case .C6:
        return .B3
      case .D4:
        return .C6
    }
    return nil
  }
  
  
  
  @State var longitude:Longitude = .A1
  @State var latitude:Latitude = .A1
  @State var source:DiceFace = .one
  
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
  
  
  var body: some View {
    func takesAPointer(_ p: UnsafeMutablePointer<CGFloat>) {
      print("pointer ",p.pointee)
    }
    
    func setAxis(axisX: UnsafeMutablePointer<CGFloat>, axisXV: CGFloat, axisY: UnsafeMutablePointer<CGFloat>, axisYV: CGFloat) {
      axisX.pointee = axisXV
      axisY.pointee = axisYV
    }
    
    func setAnchor(anchorPoint:UnsafeMutablePointer<UnitPoint>,anchorPointV: UnitPoint) {
      anchorPoint.pointee = anchorPointV
    }
    
    func setDegree(startingPoint:UnsafeMutablePointer<Int>,startingPointV: Int) {
      startingPoint.pointee = startingPointV
    }
    
    func setHeight(variable:UnsafeMutablePointer<CGFloat>, variableV: CGFloat) {
      variable.pointee = variableV
    }
    
    func setSide1(axisX: CGFloat, axisY: CGFloat, anchorPoint:UnitPoint, starting:Int, width:CGFloat, height:CGFloat) {
      self.x1 = axisX
      self.y1 = axisY
      self.f1 = anchorPoint
      self.p1 = starting
      self.q1.width = width
      self.q1.height = height
    }
    
    func setSide2(axisX: CGFloat, axisY: CGFloat, anchorPoint:UnitPoint, starting:Int, width:CGFloat, height:CGFloat) {
      self.x2 = axisX
      self.y2 = axisY
      self.f2 = anchorPoint
      self.p2 = starting
      self.q2.width = width
      self.q2.height = height
    }
    
    func setSide3(axisX: CGFloat, axisY: CGFloat, anchorPoint:UnitPoint, starting:Int, width:CGFloat, height:CGFloat) {
      self.x3 = axisX
      self.y3 = axisY
      self.f3 = anchorPoint
      self.p3 = starting
      self.q3.width = width
      self.q3.height = height
    }
    
    func setSide4(axisX: CGFloat, axisY: CGFloat, anchorPoint:UnitPoint, starting:Int, width:CGFloat, height:CGFloat) {
      self.x4 = axisX
      self.y4 = axisY
      self.f4 = anchorPoint
      self.p4 = starting
      self.q4.width = width
      self.q4.height = height
    }
    
    func setSide5(axisX: CGFloat, axisY: CGFloat, anchorPoint:UnitPoint, starting:Int, width:CGFloat, height:CGFloat) {
      self.x5 = axisX
      self.y5 = axisY
      self.f5 = anchorPoint
      self.p5 = starting
      self.q5.width = width
      self.q5.height = height
    }
    
    func setSide6(axisX: CGFloat, axisY: CGFloat, anchorPoint:UnitPoint, starting:Int, width:CGFloat, height:CGFloat) {
      self.x6 = axisX
      self.y6 = axisY
      self.f6 = anchorPoint
      self.p6 = starting
      self.q6.width = width
      self.q6.height = height
    }
    
//    func setDegrees()
//    func setCSizes()

    var direction: SwipeHVDirection?
    
                      

  
    func detectDirection(value: DragGesture.Value) -> SwipeHVDirection {
      if value.startLocation.x < value.location.x - 24 {
        direction = .left
      }
      if value.startLocation.x > value.location.x + 24 {
        direction = .right
      }
      if value.startLocation.y < value.location.y - 24 {
        direction = .down
      }
      if value.startLocation.y > value.location.y + 24 {
        direction = .up
      }
      return direction!
    }
    
    return VStack {
      ZStack {
        diceViews[DiceSides.six.rawValue]
          .rotation3DEffect(.degrees(Double(p6)), axis: (x: self.x6, y:self.y6 , z: 0), anchor: self.f6, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q6)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              switch direction {
              case .up:
                self.longitude = self.nextVLongitude(state: self.longitude)!
              case .left:
                self.latitude = self.nextVLatitude(state: self.latitude)!
              case .right:
                self.latitude = self.prevVLatitude(state: self.latitude)!
              case .down:
                self.longitude = self.prevVLongitude(state: self.longitude)!
              default:
                break
              }
              let select = self.latitude.rawValue + self.longitude.rawValue
              print("select ",select)
                switch select {
                case "A1D5":
                  setSide6(axisX: 1, axisY: 0, anchorPoint: UnitPoint.bottom, starting: 0, width: 0, height: 0)
                  setSide5(axisX: -1, axisY: 0, anchorPoint: UnitPoint.top, starting: 90, width: 0, height: 128)
                case "D4A1":
                  setSide6(axisX: 0, axisY: 1, anchorPoint: UnitPoint.leading, starting: 0, width: 0, height: 0)
                  setSide4(axisX: 0, axisY: -1, anchorPoint: UnitPoint.trailing, starting: 90, width: -128, height: 0)
                case "B3A1":
                  setSide6(axisX: 0, axisY: -1, anchorPoint: UnitPoint.trailing, starting: 0, width: 0, height: 0)
                  setSide3(axisX: 0, axisY: 1, anchorPoint: UnitPoint.leading, starting: 90, width: 128, height: 0)
                case "A1B2":
                    setSide6(axisX: -1, axisY: 0, anchorPoint: UnitPoint.top, starting: 0, width: 0, height: 0)
                    setSide2(axisX: 1, axisY: 0, anchorPoint: UnitPoint.bottom, starting: 90, width: 0, height: -128)
                  
                
                
                  
                default:
                  print("oops")
                }
                withAnimation(.linear(duration: diceSpeed)) {
                  switch select {
                  case "A1D5":
                    self.p6 = 90
                    self.q6.height = -128
                    self.q5.height = 0
                    self.p5 = 0
                  case "D4A1":
                    self.p6 = 90
                    self.q6.width = 128
                    self.q4.width = 0
                    self.p4 = 0
                  case "B3A1": // right
                    self.p6 = 90
                    self.q6.width = -128
                    self.q3.width = 0
                    self.p3 = 0
                  case "A1B2": // down
                    self.p6 = 90
                    self.q6.height = 128
                    self.q2.height = 0
                    self.p2 = 0
                  default:
                    print("oops")
                  }
                
              }
          })
        diceViews[DiceSides.five.rawValue]
          .rotation3DEffect(.degrees(Double(p5)), axis: (x: self.x5, y:self.y5 , z: 0), anchor: self.f5, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q5)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              switch direction {
              case .up:
                self.longitude = self.nextVLongitude(state: self.longitude)!
              case .left:
                self.latitude = self.nextVLatitude(state: self.latitude)!
              case .right:
                self.latitude = self.prevVLatitude(state: self.latitude)!
              case .down:
                self.longitude = self.prevVLongitude(state: self.longitude)!
              default:
                break
              }
              let select = self.latitude.rawValue + self.longitude.rawValue
              print("select ",select)
                switch select {
                case "A1A1":
                  setSide5(axisX: 1, axisY: 0, anchorPoint: UnitPoint.bottom, starting: 0, width: 0, height: 0)
                  setSide1(axisX: -1, axisY: 0, anchorPoint: UnitPoint.top, starting: 90, width: 0, height: 128)
                case "A1C6":
                  setSide5(axisX: -1, axisY: 0, anchorPoint: UnitPoint.top, starting: 0, width: 0, height: 0)
                  setSide6(axisX: 1, axisY: 0, anchorPoint: UnitPoint.bottom, starting: 90, width: 0, height: -128)
                  
                  
                    
                default:
                  break
                }
                withAnimation(.linear(duration: diceSpeed)) {
                  switch select {
                  case "A1A1":
                    self.p5 = 90
                    self.q5.height = -128
                    self.q1.height = 0
                    self.p1 = 0
                  case "A1C6": // up
                    self.p5 = 90
                    self.q5.height = 128
                    self.q6.height = 0
                    self.p6 = 0
                  default:
                    print("oops")
                  }
                }
          })
        diceViews[DiceSides.four.rawValue]
          .rotation3DEffect(.degrees(Double(p4)), axis: (x: self.x4, y:self.y4 , z: 0), anchor: self.f4, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q4)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              switch direction {
              case .up:
                self.longitude = self.nextVLongitude(state: self.longitude)!
              case .left:
                self.latitude = self.nextVLatitude(state: self.latitude)!
              case .right:
                self.latitude = self.prevVLatitude(state: self.latitude)!
              case .down:
                self.longitude = self.prevVLongitude(state: self.longitude)!
              default:
                break
              }
              let select = self.latitude.rawValue + self.longitude.rawValue
              print("select ",select)
                
                print("select ",select)
                switch select {
                case "A1A1":
                  setSide4(axisX: 0, axisY: 1, anchorPoint: UnitPoint.leading, starting: 0, width: 0, height: 0)
                  setSide1(axisX: 0, axisY: -1, anchorPoint: UnitPoint.trailing, starting: 90, width: -128, height: 0)
                case "C6A1":
                  setSide4(axisX: 0, axisY: -1, anchorPoint: UnitPoint.trailing, starting: 0, width: 0, height: 0)
                  setSide6(axisX: 0, axisY: 1, anchorPoint: UnitPoint.leading, starting: 90, width: 128, height: 0)
                
                default:
                  break
                }
                withAnimation(.linear(duration: diceSpeed)) {
                  switch select {
                  case "A1A1":
                    self.p4 = 90
                    self.q4.width = 128
                    self.q1.width = 0
                    self.p1 = 0
                  case "C6A1": // right
                    self.p4 = 90
                    self.q4.width = -128
                    self.q6.width = 0
                    self.p6 = 0
                  default:
                    print("oops")
                  }
                }
              
          })
        diceViews[DiceSides.three.rawValue]
          .rotation3DEffect(.degrees(Double(p3)), axis: (x: self.x3, y:self.y3 , z: 0), anchor: self.f3, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q3)
          .gesture(DragGesture()
            .onEnded { value in
               let direction = detectDirection(value: value)
              switch direction {
              case .up:
                self.longitude = self.nextVLongitude(state: self.longitude)!
              case .left:
                self.latitude = self.nextVLatitude(state: self.latitude)!
              case .right:
                self.latitude = self.prevVLatitude(state: self.latitude)!
              case .down:
                self.longitude = self.prevVLongitude(state: self.longitude)!
              default:
                break
              }
              let select = self.latitude.rawValue + self.longitude.rawValue
              print("select ",select)
              switch select {
                case "C6A1":
                  setSide3(axisX: 0, axisY: 1, anchorPoint: UnitPoint.leading, starting: 0, width: 0, height: 0)
                  setSide6(axisX: 0, axisY: -1, anchorPoint: UnitPoint.trailing, starting: 90, width: -128, height: 0)
                  
                  case "A1A1":
                setSide3(axisX: 0, axisY: -1, anchorPoint: UnitPoint.trailing, starting: 0, width: 0, height: 0)
                setSide1(axisX: 0, axisY: 1, anchorPoint: UnitPoint.leading, starting: 90, width: 128, height: 0)
                  
                    
                default:
                  break
                }
                withAnimation(.linear(duration: diceSpeed)) {
                  switch select {
                  case "C6A1":
                    self.p3 = 90
                    self.q3.width = 128
                    self.q6.width = 0
                    self.p6 = 0
                  case "A1A1": // right
                    self.p3 = 90
                    self.q3.width = -128
                    self.q1.width = 0
                    self.p1 = 0
                  default:
                    print("oops")
                  }
                }
              })
        diceViews[DiceSides.two.rawValue]
          .rotation3DEffect(.degrees(Double(p2)), axis: (x: self.x2, y:self.y2 , z: 0), anchor: self.f2, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q2)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              switch direction {
              case .up:
                self.longitude = self.nextVLongitude(state: self.longitude)!
              case .left:
                self.latitude = self.nextVLatitude(state: self.latitude)!
              case .right:
                self.latitude = self.prevVLatitude(state: self.latitude)!
              case .down:
                self.longitude = self.prevVLongitude(state: self.longitude)!
              default:
                break
              }
              let select = self.latitude.rawValue + self.longitude.rawValue
              print("select ",select)
                switch select {
                case "A1C6":
                  setSide2(axisX: 1, axisY: 0, anchorPoint: UnitPoint.bottom, starting: 0, width: 0, height: 0)
                  setSide6(axisX: -1, axisY: 0, anchorPoint: UnitPoint.top, starting: 90, width: 0, height: 128)
                case "A1A1":
                  setSide2(axisX: -1, axisY: 0, anchorPoint: UnitPoint.top, starting: 0, width: 0, height: 0)
                  setSide1(axisX: 1, axisY: 0, anchorPoint: UnitPoint.bottom, starting: 90, width: 0, height: -128)
                default:
                  break
                }
                withAnimation(.linear(duration: diceSpeed)) {
                  switch select {
                  case "A1C6":
                    self.p2 = 90
                    self.q2.height = -128
                    self.q6.height = 0
                    self.p6 = 0
                  case "A1A1": // up
                    self.p2 = 90
                    self.q2.height = 128
                    self.q1.height = 0
                    self.p1 = 0
                  default:
                    print("oops")
                  }
                }
              
          })
        
        diceViews[DiceSides.one.rawValue]
          .rotation3DEffect(.degrees(Double(p1)), axis: (x: self.x1, y: self.y1, z: 0), anchor: self.f1, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q1)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              switch direction {
              case .up:
                self.longitude = self.nextVLongitude(state: self.longitude)!
              case .left:
                self.latitude = self.nextVLatitude(state: self.latitude)!
              case .right:
                self.latitude = self.prevVLatitude(state: self.latitude)!
              case .down:
                self.longitude = self.prevVLongitude(state: self.longitude)!
              default:
                break
              }
              let select = self.latitude.rawValue + self.longitude.rawValue
            
      
              print("select ",select)
              switch select {
              case "A1B2": // up
                setSide1(axisX: 1, axisY: 0, anchorPoint: UnitPoint.bottom, starting: 0, width: 0, height: 0)
                setSide2(axisX: -1, axisY: 0, anchorPoint: UnitPoint.top, starting: 90, width: 0, height: 128)
              case "B3A1":
                setSide1(axisX: 0, axisY: 1, anchorPoint: UnitPoint.leading, starting: 0, width: 0, height: 0)
                setSide3(axisX: 0, axisY: -1, anchorPoint: UnitPoint.trailing, starting: 90, width: -128, height: 0)
              case "D4A1":
                setSide1(axisX: 0, axisY: -1, anchorPoint: UnitPoint.trailing, starting: 0, width: 0, height: 0)
                setSide4(axisX: 0, axisY: 1, anchorPoint: UnitPoint.leading, starting: 90, width: 128, height: 0)
              case "A1D5":
                setSide1(axisX: -1, axisY: 0, anchorPoint: UnitPoint.top, starting: 0, width: 0, height: 0)
                setSide5(axisX: 1, axisY: 0, anchorPoint: UnitPoint.bottom, starting: 90, width: 0, height: -128)
                
                
                
              default:
                break
              }
              withAnimation(.linear(duration: diceSpeed)) {
                switch select {
                case "A1B2": // up
                  self.p1 = 90
                  self.q1.height = -128
                  self.q2.height = 0
                  self.p2 = 0
                case "B3A1": // left
                  self.p1 = 90
                  self.q1.width = 128
                  self.q3.width = 0
                  self.p3 = 0
                case "D4A1": // right
                  self.p1 = 90
                  self.q1.width = -128
                  self.q4.width = 0
                  self.p4 = 0
                case "A1D5": // up
                  self.p1 = 90
                  self.q1.height = 128
                  self.q5.height = 0
                  self.p5 = 0
                default:
                  print("oops")
                }
              }
              
          })
        
      }
    }
  }
}

struct DiceViewV: View {
  
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
      
      ZStack {
        diceViews[DiceSides.six.rawValue]
          .rotation3DEffect(.degrees(Double(p6)), axis: (x: self.x6, y:self.y6 , z: 0), anchor: self.f6, anchorZ: 0.0, perspective: CGFloat(0.5))
          .offset(q6)
          .gesture(DragGesture()
            .onEnded { value in
              let direction = detectDirection(value: value)
              if direction == .up {
                self.x6 = 1
                self.y6 = 0
                self.f6 = UnitPoint.bottom
                
                
                self.f5 = UnitPoint.top
                self.y5 = 0
                self.x5 = -1
                self.p5 = 90
                self.q5.height = 128
                self.q5.width = 0
                

              
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p6 = 90
                  self.q6.height = -128
                  
                  self.q5.height = 0
                  self.p5 = 0
                  

                }
              }
              if direction == .down {
                self.y6 = 0
                self.x6 = -1
                self.f6 = UnitPoint.top
                
                self.f2 = UnitPoint.bottom
                self.x2 = 1
                self.y2 = 0
                self.p2 = 90
                self.q2.height = -128
                self.q2.width = 0
                

                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p6 = 90
                  self.q6.height = 128
                  
                  self.q2.height = 0
                  self.p2 = 0
                  
                  
                }
              }
              if direction == .left {
                self.x6 = 0
                self.y6 = 1
                self.f6 = UnitPoint.leading
                
                self.f3 = UnitPoint.trailing
                self.y3 = -1
                self.x3 = 0
                self.q3.width = -128
                self.q3.height = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p6 = 90
                  self.q6.width = 128
                  self.p3 = 0
                  self.q3.width = 0
                }
              }
              if direction == .right  {
                self.x6 = 0
                self.y6 = -1
                self.f6 = UnitPoint.trailing
                
                self.y4 = 1
                self.x4 = 0
                self.f4 = UnitPoint.leading
                self.q4.width = 128
                self.q4.height = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p6 = 90
                  self.q6.width = -128
                  self.p4 = 0
                  self.q4.width = 0
                }
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
                self.y5 = 0
                self.f5 = UnitPoint.bottom
                
                self.f1 = UnitPoint.top
                self.y1 = 0
                self.x1 = -1 // WTF
                
                self.p1 = 90
                self.q1.height = 128
                self.q1.width = 0
              
                
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p5 = 90
                  self.q5.height = -128
                  
                  self.q1.height = 0
                  self.p1 = 0
                  
                }
              }
              if direction == .down {
                self.y5 = 0
                self.x5 = -1
                self.f5 = UnitPoint.top
                
                self.f6 = UnitPoint.bottom
                self.x6 = 1
                self.y6 = 0
                self.p6 = 90
                self.q6.height = -128
                self.q6.width = 0
                
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p5 = 90
                  self.q5.height = 128
                  
                  self.q6.height = 0
                  self.p6 = 0
              
                }
              }
              if direction == .left {
                self.x5 = 0
                self.y5 = 1
                self.f5 = UnitPoint.leading
                
                self.f3 = UnitPoint.trailing
                self.y3 = -1
                self.x3 = 0
                self.q3.width = -128
                self.q3.height = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p5 = 90
                  self.q5.width = 128
                  self.p3 = 0
                  self.q3.width = 0
                }
              }
              if direction == .right  {
                self.x5 = 0
                self.y5 = -1
                self.f5 = UnitPoint.trailing
                
                self.y4 = 1
                self.x4 = 0
                self.f4 = UnitPoint.leading
                self.q4.width = 128
                self.q4.height = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p5 = 90
                  self.q5.width = -128
                  self.p4 = 0
                  self.q4.width = 0
                }
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
                self.y1 = 0
                self.f1 = UnitPoint.bottom
                
                
                self.f5 = UnitPoint.top
                self.y5 = 0
                self.x5 = -1
                self.p5 = 90
                self.q5.height = 128
                self.q5.width = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p1 = 90
                  self.q1.height = -128
                  
                  self.q5.height = 0
                  self.p5 = 0
                }
              }
              if direction == .down {
                self.source = .one
                self.y1 = 0
                self.x1 = -1
                self.f1 = UnitPoint.top
                self.q1.width = 0
                
                self.f2 = UnitPoint.bottom
                self.x2 = 1
                self.y2 = 0
                self.p2 = 90
                self.q2.height = -128
                self.q2.width = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p1 = 90
                  self.q1.height = 128
                  
                  self.q2.height = 0
                  self.p2 = 0
                  
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
                
                self.y3 = 1
                self.x3 = 0
                self.f3 = UnitPoint.leading
                self.q3.width = 128
                self.q3.height = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p1 = 90
                  self.q1.width = -128
                  self.p3 = 0
                  self.q3.width = 0
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
                
                self.y4 = -1
                self.x4 = 0
                self.f4 = UnitPoint.trailing
                self.q4.width = -128
                self.q4.height = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p2 = 90
                  self.q2.width = 128
                  
                  self.p4 = 0
                  self.q4.width = 0
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
                self.y2 = 0
                self.f2 = UnitPoint.bottom
                
                
                self.f1 = UnitPoint.top
                self.y1 = 0
                self.x1 = -1
                self.y1 = 0
                self.p1 = 90
                self.q1.height = 128
                self.q1.width = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p2 = 90
                  self.q2.height = -128
                  
                  self.q1.height = 0
                  self.p1 = 0
                }
              }
              if direction == .down {
                self.source = .two
                self.y2 = 0
                self.x2 = -1
                self.f2 = UnitPoint.top
                
                self.f6 = UnitPoint.bottom
                self.x6 = 1
                self.y6 = 0
                self.p6 = 90
                self.q6.height = -128
                self.q6.width = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p2 = 90
                  self.q2.height = 128
                  
                  self.q6.height = 0
                  self.p6 = 0
                  
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
                self.x2 = 0
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
                
                self.y5 = 1
                self.x5 = 0
                self.f5 = UnitPoint.leading
                self.q5.width = 128
                self.q5.height = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p3 = 90
                  self.q3.width = -128
                  self.p5 = 0
                  self.q5.width = 0
                }
              }
              if direction == .up {
                self.source = .three
                self.x3 = 1
                self.y3 = 0
                self.f3 = UnitPoint.bottom
                self.q3.width = 0
                
                self.f1 = UnitPoint.top
                self.y1 = 0
                self.x1 = -1
                self.p1 = 90
                self.q1.height = 128
                self.q1.width = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p3 = 90
                  self.q3.height = -128
                  
                  self.q1.height = 0
                  self.p1 = 0
                }
              }
              if direction == .down {
                self.source = .three
                self.x3 = -1
                self.y3 = 0
                self.f3 = UnitPoint.top
                
                self.q3.width = 0
                
                self.f6 = UnitPoint.bottom
                self.x6 = 1
                self.y6 = 0
                self.p6 = 90
                self.q6.height = -128
                self.q6.width = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p3 = 90
                  self.q3.height = 128
                  
                  self.q6.height = 0
                  self.p6 = 0
                  
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
                
                self.y5 = -1
                self.x5 = 0
                self.f5 = UnitPoint.trailing
                self.q5.width = -128
                self.q5.height = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p4 = 90
                  self.q4.width = 128
                  self.p5 = 0
                  self.q5.width = 0
                }
              }
              if direction == .right {
                self.x4 = 0
                self.y4 = -1
                self.f4 = UnitPoint.trailing
                
                self.y2 = 1
                self.x2 = 0
                self.f2 = UnitPoint.leading
                self.q2.width = 128
                self.q2.height = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p4 = 90
                  self.q4.width = -128
                  self.p2 = 0
                  self.q2.width = 0
                }
              }
              if direction == .up {
                self.source = .four
                self.x4 = 1
                self.y4 = 0
                self.f4 = UnitPoint.bottom
                self.q4.width = 0
                
                self.f1 = UnitPoint.top
                self.y1 = 0
                self.x1 = -1
                self.p1 = 90
                self.q1.height = 128
                self.q1.width = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p4 = 90
                  self.q4.height = -128
                  
                  self.q1.height = 0
                  self.p1 = 0
                }
              }
              if direction == .down {
                self.source = .four
                self.y4 = 0
                self.x4 = -1
                self.f4 = UnitPoint.top
                self.q4.width = 0
                
                self.f6 = UnitPoint.bottom
                self.x6 = 1
                self.y6 = 0
                self.p6 = 90
                self.q6.height = -128
                self.q6.width = 0
                
                withAnimation(.linear(duration: diceSpeed)) {
                  self.p4 = 90
                  self.q4.height = 128
                  
                  self.q6.height = 0
                  self.p6 = 0
                  
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

//                let nDice = diceMap(diceID: "1N", sourceDegreeStart: 0, sourceDegreeFinish: 90, sourceAnchor: UnitPoint.bottom, sourceAxisX: 1, sourceAxisY: 0, sourceAxisZ: 0, targetDegreeStart: 90, targetDegreeFinish: 0, targetAnchor: UnitPoint.top, targetAxisX: -1, targetAxisY: 0, targetAxisZ: 0)
//      diceLocation["1N"] = nDice
                
//                setAxis(axisX: &self.x1, axisXV: 1, axisY: &self.y1, axisYV: 0)
//                setAxis(axisX: &self.x2, axisXV: -1, axisY: &self.y2, axisYV: 0)
//                setAnchor(anchorPoint: &self.f1, anchorPointV: UnitPoint.bottom)
//                setAnchor(anchorPoint: &self.f2, anchorPointV: UnitPoint.top)
//                setDegree(startingPoint: &self.p1, startingPointV: 0)
//                setDegree(startingPoint: &self.p2, startingPointV: 90)
//                self.q1 = .zero
//                self.q2 = .zero
//                setHeight(variable: &self.q1.height, variableV: 0)
//                setHeight(variable: &self.q2.height, variableV: 128)

