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
      ZStack {
        Rectangle()
          .fill(LinearGradient(gradient: Gradient(colors: [.red, Color.init(0x8b0000)]), startPoint: .topTrailing, endPoint: .bottomLeading))
          .frame(width: 128, height: 128, alignment: .center)
        Circle()
          .fill(LinearGradient(gradient: Gradient(colors: [Color.init(0x8b0000), .red]), startPoint: .topTrailing, endPoint: .bottomLeading))
          .frame(width: 120, height: 120, alignment: .center)
        Circle()
          .fill(Color.white)
          .frame(width: 28, height: 28, alignment: .center)
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
      }.rotation3DEffect(.degrees(Double(p1)), axis: (x: 0, y: self.z1, z: 0), anchor: self.f1, anchorZ: 0.0, perspective: CGFloat(0.5))
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
      }.rotation3DEffect(.degrees(Double(p2)), axis: (x: 0, y: self.z2, z: 0), anchor: self.f2, anchorZ: 0.0, perspective: CGFloat(0.5))
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
      }.rotation3DEffect(.degrees(Double(p3)), axis: (x: 0, y: self.z3, z: 0), anchor: self.f3, anchorZ: 0.0, perspective: CGFloat(0.5))
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
      }.rotation3DEffect(.degrees(Double(p4)), axis: (x: 0, y: self.z4, z: 0), anchor: self.f4, anchorZ: 0.0, perspective: CGFloat(0.5))
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


extension Color {
init(_ hex: Int, opacity: Double = 1.0) {
    let red = Double((hex & 0xff0000) >> 16) / 255.0
    let green = Double((hex & 0xff00) >> 8) / 255.0
    let blue = Double((hex & 0xff) >> 0) / 255.0
    self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
}
}
