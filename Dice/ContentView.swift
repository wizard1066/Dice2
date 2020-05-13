//

//  ContentView.swift

//  Access

//

//  Created by localuser on 06.05.20.

//  Copyright © 2020 localuser. All rights reserved.

//


import SwiftUI
import GameplayKit

let dotSize:CGFloat = 24
let diceSize:CGFloat = 128
let fieldSide:CGFloat = 32

let d6 = GKRandomDistribution.d6()

var diceViews:[AnyView] = [AnyView(oneDotDice()),AnyView(twoDotDice()),AnyView(threeDotDice()),AnyView(fourDotDice())]

struct ContentView: View {
  @State var showView = true
  @State var lowInt:Int = 0
  @State var midInt:Int = 1
  @State var highInt:Int = 2
  @State var ultraInt:Int = 3
  @State var q1 = CGSize(width: 0, height: 0)
  @State var q2 = CGSize(width: 128, height: 0)
  @State var q3 = CGSize(width: 128, height: 0)
  @State var q4 = CGSize(width: 128, height: 0)
  @State var p1 = 0
  @State var p2 = 90
  @State var p3 = 90
  @State var p4 = 90
  @State var z1:CGFloat = -1
  @State var z2:CGFloat = 1
  @State var z3:CGFloat = 1
  @State var z4:CGFloat = 1
  @State var f1:UnitPoint = .trailing
  @State var f2:UnitPoint = .leading
  @State var f3:UnitPoint = .leading
  @State var f4:UnitPoint = .leading
  var body: some View {
    VStack {
      Text("Roll").onTapGesture {
        withAnimation(.linear(duration: 8)) {
//          self.p3 = 0
//          self.q3.width = 0
          self.z2 = -1
        }
      }
        
          
          
//        if self.p2 == 90 {
//          withAnimation {
//            self.p1 = 90
//            self.p2 = 0
//          }
//        } else {
//          if self.p3 == 90 {
//            self.p1 = 90
//            withAnimation {
//              self.p2 = 90
//              self.p3 = 0
//            }
//          } else {
//            self.p1 = 90
//            self.p2 = 90
//            if self.p4 == 90 {
//              withAnimation {
//                self.p3 = 90
//                self.p4 = 0
//              }
//            } else {
//              self.p1 = 90
//              self.p2 = 90
//              self.p3 = 90
//              if self.p1 == 90 {
//                withAnimation {
//                  self.p4 = 90
//                  self.p1 = 0
//                }
//            }
//            }
//          }
//        }
//      }
    
    ZStack {
      diceViews[lowInt]
        .onTapGesture {
        self.z1 = -1
        self.f1 = UnitPoint.trailing
        
        self.f2 = UnitPoint.leading
        self.q2.width = 128
        self.z2 = 1
        
        withAnimation(.linear(duration: 0.5)) {
          self.p1 = 90
          self.p2 = 0
          self.q1.width = -128
          self.q2.width = 0
        }
      }.rotation3DEffect(.degrees(Double(p1)), axis: (x: 0, y: self.z1, z: 0), anchor: self.f1, anchorZ: 0.0, perspective: CGFloat(0.3))
      .offset(q1)

      diceViews[midInt].onTapGesture {
        self.z2 = -1
        self.f2 = UnitPoint.trailing
        
        self.f3 = UnitPoint.leading
        self.q3.width = 128
        self.z3 = 1
        
        withAnimation(.linear(duration: 0.5)) {
          self.p2 = 90
          self.p3 = 0
          self.q2.width = -128
          self.q3.width = 0
        }
      }.rotation3DEffect(.degrees(Double(p2)), axis: (x: 0, y: self.z2, z: 0), anchor: self.f2, anchorZ: 0.0, perspective: CGFloat(0.3))
        .offset(q2)
        
      diceViews[highInt].onTapGesture {
        self.z3 = -1
        self.f3 = UnitPoint.trailing
        
        self.f4 = UnitPoint.leading
        self.q4.width = 128
        self.z4 = 1
        
        withAnimation(.linear(duration: 0.5)) {
          self.p3 = 90
          self.q3.width = -128
          self.p4 = 0
          self.q4.width = 0
        }
      }.rotation3DEffect(.degrees(Double(p3)), axis: (x: 0, y: self.z3, z: 0), anchor: self.f3, anchorZ: 0.0, perspective: CGFloat(0.3))
        .offset(q3)
        
      diceViews[ultraInt].onTapGesture {
        self.z4 = -1
        self.f4 = UnitPoint.trailing
        
        self.f1 = UnitPoint.leading
        self.q1.width = 128
        self.z1 = 1
        
        withAnimation(.linear(duration: 0.5)) {
          self.p4 = 90
          self.q4.width = -128
          self.p1 = 0
          self.q1.width = 0
        }
      }.rotation3DEffect(.degrees(Double(p4)), axis: (x: 0, y: self.z4, z: 0), anchor: self.f4, anchorZ: 0.0, perspective: CGFloat(0.3))
        .offset(q4)
        
        
        
        
        
//      .rotation3DEffect(.degrees(Double(p2)), axis: (x: 0, y: 1, z: 0), anchor: UnitPoint.leading, anchorZ: 0.0, perspective: CGFloat(0.0))
//      oneDotDice()
//        .rotation3DEffect(.degrees(Double(p1)), axis: (x: 0, y: 1, z: 0), anchor: UnitPoint.leading, anchorZ: 0.0, perspective: CGFloat(0.0))
//
//      twoDotDice()
//        .rotation3DEffect(.degrees(Double(p2)), axis: (x: 0, y: 1, z: 0), anchor: UnitPoint.leading, anchorZ: 0.0, perspective: CGFloat(0.0))
//
//      threeDotDice()
//        .rotation3DEffect(.degrees(Double(p3)), axis: (x: 0, y: 1, z: 0), anchor: UnitPoint.leading, anchorZ: 0.0, perspective: CGFloat(0.0))
//
//      fourDotDice()
//        .rotation3DEffect(.degrees(Double(p4)), axis: (x: 0, y: 1, z: 0), anchor: UnitPoint.leading, anchorZ: 0.0, perspective: CGFloat(0.0))
//      }
    }
    
//    VStack {
//      if showInt == 1 {
//        oneDotDice()
//          .transition(AnyTransition.opacity)
//          .modifier(changeDice(showInt: self.$showInt))
//      } else {
//        if showInt == 2 {
//          twoDotDice()
//            .transition(AnyTransition.opacity)
//            .modifier(changeDice(showInt: self.$showInt))
//        } else {
//          if showInt == 3 {
//            threeDotDice(turn: true)
//              .transition(AnyTransition.opacity)
//              .modifier(changeDice(showInt: self.$showInt))
//          } else {
//            if showInt == 4 {
//              fourDotDice()
//                .transition(AnyTransition.opacity)
//                .modifier(changeDice(showInt: self.$showInt))
//            } else {
//              if showInt == 5 {
//                fiveDotDice()
//                  .transition(AnyTransition.opacity)
//                  .modifier(changeDice(showInt: self.$showInt))
//              } else {
//                if showInt == 6 {
//                  sixDotDice()
//                    .transition(AnyTransition.opacity)
//                    .modifier(changeDice(showInt: self.$showInt))
//                }
//              }
//            }
//          }
//        }
//      }
//    }
    }
  }
}

struct oneDotDice: View {
  var body: some View {
    Image("d1")
  }
}

struct twoDotDice: View {
  var body: some View {
    Image("d2")
  }
}

struct threeDotDice: View {
  var body: some View {
    Image("d3")
  }
}

struct fourDotDice: View {
  var body: some View {
    Image("d4")
  }
}

struct fiveDotDice: View {
  var body: some View {
    Image("d5")
  }
}

struct sixDotDice: View {
  var body: some View {
    Image("d6")
  }
}


//struct oneDotDice: View {
//  var body: some View {
//    ZStack {
//      Rectangle()
//        .fill(Color.clear)
//        .frame(width: diceSize, height: diceSize, alignment: .center)
//        .border(Color.black)
//      Circle()
//        .fill(Color.black)
//        .frame(width: dotSize, height: dotSize, alignment: .center)
//    }.background(Color.red)
//  }
//}

//struct twoDotDice: View {
//  var body: some View {
//  ZStack {
//    Rectangle()
//      .fill(Color.white)
//      .frame(width: diceSize, height: diceSize, alignment: .center)
//      .border(Color.black)
//    HStack {
//        Spacer()
//        Circle()
//          .fill(Color.black)
//          .frame(width: dotSize, height: dotSize, alignment: .center)
//        Spacer()
//        Circle()
//          .fill(Color.black)
//          .frame(width: dotSize, height: dotSize, alignment: .center)
//        Spacer()
//      }.frame(width: diceSize, height: diceSize, alignment: .center)
//    }
////      .background(Color.blue)
//  }
//}
//
//struct threeDotDice: View {
//  @State var turn:Bool
//  var body: some View {
//    ZStack {
//    Rectangle()
//      .fill(Color.white)
//      .frame(width: diceSize, height: diceSize, alignment: .center)
//      .border(turn ? Color.black: Color.clear)
//      HStack {
//        Spacer()
//        Circle()
//          .fill(Color.black)
//          .frame(width: dotSize, height: dotSize, alignment: .center)
//        Spacer()
//        Circle()
//          .fill(Color.black)
//          .frame(width: dotSize, height: dotSize, alignment: .center)
//        Spacer()
//        Circle()
//          .fill(Color.black)
//          .frame(width: dotSize, height: dotSize, alignment: .center)
//        Spacer()
//      }.frame(width: diceSize, height: diceSize, alignment: .center)
//      }
//    }
//}
//
//struct fourDotDice: View {
//  var body: some View {
//    ZStack {
//    Rectangle()
//      .fill(Color.white)
//      .frame(width: diceSize, height: diceSize, alignment: .center)
//      .border(Color.black)
//
//        VStack {
//          HStack {
//            Spacer()
//              .frame(width: fieldSide )
//            Circle()
//              .fill(Color.black)
//              .frame(width: dotSize, height: dotSize, alignment: .center)
//            Spacer()
//              .frame(width: fieldSide )
//            Circle()
//              .fill(Color.black)
//              .frame(width: dotSize, height: dotSize, alignment: .center)
//            Spacer()
//              .frame(width: fieldSide)
//          } // HStack
//          Spacer()
//            .frame(height: fieldSide )
//          HStack {
//            Spacer()
//              .frame(width: fieldSide)
//            Circle()
//              .fill(Color.black)
//              .frame(width: dotSize, height: dotSize, alignment: .center)
//            Spacer()
//              .frame(width: fieldSide )
//            Circle()
//              .fill(Color.black)
//              .frame(width: dotSize, height: dotSize, alignment: .center)
//            Spacer()
//              .frame(width: fieldSide)
//          } // HStack
//        }.frame(width: diceSize, height: diceSize, alignment: .center)
//         //VStack
//
//  }
//  }
//}
//
//struct fiveDotDice: View {
//  var body: some View {
//    ZStack {
//      fourDotDice()
//      oneDotDice()
//    }
//  }
//}
//
//struct sixDotDice: View {
//  var body: some View {
//    Rectangle()
//      .fill(Color.clear)
//      .frame(width: diceSize, height: diceSize, alignment: .center)
//      .border(Color.black)
//      .background(
//        ZStack {
//          VStack {
//            Spacer()
//            threeDotDice(turn: false)
//              .offset(CGSize(width: 0, height: fieldSide * 1.3))
//            threeDotDice(turn: false)
//              .offset(CGSize(width: 0, height: -fieldSide * 1.3))
//            Spacer()
//          }
//      })
//  }
//}

struct changeDice: ViewModifier {
  @Binding var showInt:Int
  func body(content: Content) -> some View {
    content
      .onTapGesture {
        withAnimation(.linear(duration: 8)) {
          self.showInt = d6.nextInt()
        }
        print("Int ",self.showInt)
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    
    ContentView()
    
  }
  
}

struct RectangularShape: Shape {
    var pct: CGFloat
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
//        path.addRect(rect.insetBy(dx: pct * rect.width / 1.0, dy: pct * rect.height / 1.0))
//        path.addRect(rect.insetBy(dx: pct * rect.width / 1.0, dy:0 ))
        
        path.move(to: CGPoint(x: 0,y: 0))
        path.addLine(to: CGPoint(x: 20,y: 44))
        path.addLine(to: CGPoint(x: 40,y: 0))
        path.addLine(to: CGPoint(x: 0,y: 0))

        return path
    }
}

extension AnyTransition {
    static var rectangular: AnyTransition { get {
        AnyTransition.modifier(
            active: ShapeClipModifier(shape: RectangularShape(pct: 0)),
            identity: ShapeClipModifier(shape: RectangularShape(pct: 1)))
        }
    }
}

struct ShapeClipModifier<S: Shape>: ViewModifier {
    let shape: S
    
    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}

extension AnyTransition {
    static var fly: AnyTransition { get {
          AnyTransition.modifier(active: FlyTransition(pct: 0), identity: FlyTransition(pct: 1))
        }
    }
}

struct FlyTransition: GeometryEffect {
    var pct: Double
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {

        let rotationPercent = pct
        let a = CGFloat(Angle(degrees: 90 * (1-rotationPercent)).radians)
        
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, a, 1, 0, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        
        let affineTransform1 = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        let affineTransform2 = ProjectionTransform(CGAffineTransform(scaleX: CGFloat(pct * 2), y: CGFloat(pct * 2)))
        
        if pct <= 0.5 {
            return ProjectionTransform(transform3d).concatenating(affineTransform2).concatenating(affineTransform1)
        } else {
            return ProjectionTransform(transform3d).concatenating(affineTransform1)
        }
    }
}
