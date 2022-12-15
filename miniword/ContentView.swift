//
//  ContentView.swift
//  miniword  【极简单词】
//
//  Created by 章珂 on 2022/5/28.
//
//
//  1.0版本需要新增以下功能
//  优化Text显示，参考苹果自带的翻译显示的style，正常需要有英文单词 词性 英标和中文
//  每个单词行都有三个选项 一个是喜爱，点击后会新增到我的收藏里，第二个是播放语音，第三个是下一个单词
//  可以自定义轮换的时间，默认是10分钟换一个，按分钟来计算，在设置里配置
//  最好固定软件窗口大小，固定为一个长方形，如果能强制显示在最前端就最好了
//  要在mac的最上面显示，同样要有三个选项可以点击，参考网易云音乐
//
//
//
//

import SwiftUI


struct ContentView: View {
    @StateObject var vm = ViewModel()
    @StateObject var bvm = bookViewModel()
    @ObservedObject var cvm = CoreDataModel()
    @EnvironmentObject var userSettings: UserSettings
    @State var selectKeeper = Set<String>()
    @State var window : NSWindow.Level = .floating
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("个人收藏", destination: FavWordList())
                ForEach(bvm.bookInfo,id: \.self){ w in
                    NavigationLink(w.bookName+"(\(w.bookCount))", destination: Tabe(bookId: w.bookId))
                }
            }   
                .navigationTitle("极简单词")
                .onAppear{
                    bvm.bookfetchData()
                }
            HStack{
                Text("请选择词汇").font(.largeTitle)
                Text("by KeZhang").foregroundColor(Color.gray).opacity(0.1).offset(x:110,y: 180)
            }
            
        }.toolbar {
            ToolbarItem(placement: .navigation) {
                HStack{
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.leading")
                    })
                    Text("轮播时间：").lineLimit(1).minimumScaleFactor(0.1)
                    TextField("Enter your time", value: $userSettings.changeTime, format: .number).textFieldStyle(.roundedBorder)
                    Text("秒").padding()
                }
            }
        }
    }
    

    struct FavWordList: View {
        @StateObject var cvm = CoreDataModel()
        @State private var loaded = false
        
        var body: some View {
            List{
                ForEach(cvm.favwords.indices, id: \.self){ w in
                    HStack{
                        Text(cvm.favwords[w].word!).bold().font(.largeTitle)
                        Text(cvm.favwords[w].meanCn!)
                        Image(systemName:"trash")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .lineLimit(1).minimumScaleFactor(0.1)
                            .onTapGesture {
                                cvm.deleteFav(indexSet: IndexSet([w]))
                            }
                    } // Provides some buffer around the produc
                }
                .listRowInsets(EdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10))
            }
            .onAppear {
                if !loaded{
                    cvm.queryFav()
                    loaded = true
                }
            }
           
        }
        
    }
    
    
    struct Tabe: View{
        @EnvironmentObject var userSettings: UserSettings
        @StateObject var vm = ViewModel()
        @StateObject var cvm = CoreDataModel()
        var bookId:Int = 0
        @State private var word:String=""
        @State private var meanCn:String=""
        @State private var loaded = false
        @State private var countNum = 0
        @State private var allword:[Words] = []
        @State private var fav:String="heart"
        @State private var allfavword:[FavwordEntity] = []
        var body: some View {
            HStack{
                Text(word).bold().font(Font.system(size: 200)).lineLimit(1).minimumScaleFactor(0.1)
                    .onTapGesture(count: 1) {
                        let url = URL(string: "https://dict.youdao.com/result?word=\(word)&lang=en")!

                        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                            guard let data = data else { return }
                            print(String(data: data, encoding: .utf8)!)
                        }

                        task.resume()
                    }
                Text(meanCn).font(Font.system(size: 50)).lineLimit(1).minimumScaleFactor(0.1)
                List{
                    if countNum > 0{
                        Image(systemName: "backward.end")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .lineLimit(1).minimumScaleFactor(0.1)
                            .onTapGesture(count: 1) {
                                if countNum < allword.count - 1 {
                                    countNum -= 1
                                } else if countNum >= allword.count - 1 {
                                    countNum = 0
                                }
                                self.word = allword[countNum].word
                                self.meanCn = allword[countNum].meanCn
                                
                                for i in cvm.favwords.indices{
                                    if allword[countNum].word == cvm.favwords[i].word{
                                        self.fav = "heart.fill"
                                        break
                                    }else{
                                        self.fav = "heart"
                                    }
                                }
                            }
                            .lineLimit(1).minimumScaleFactor(0.1)
                    }
                    Image(systemName: fav)
                                .resizable()
                                .frame(width: 38, height: 38)
                                .lineLimit(1).minimumScaleFactor(0.1)
                                .onTapGesture(count: 1) {
                                    if fav == "heart"{
                                        fav = "heart.fill"
                                        cvm.addFav(word: self.word, mean: self.meanCn)
                                    }else{
                                        fav = "heart"
                                        for i in cvm.favwords.indices{
                                            if allword[countNum].word == cvm.favwords[i].word{
                                                cvm.deleteFav(indexSet: IndexSet([i]))
                                                break
                                            }
                                        }
                                        
                                    }
                                }
                                .lineLimit(1).minimumScaleFactor(0.1)
                    if countNum != allword.count{
                        Image(systemName: "forward.end")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .lineLimit(1).minimumScaleFactor(0.1)
                            .onTapGesture(count: 1) {
                                if countNum < allword.count - 1 {
                                    countNum += 1
                                } else if countNum >= allword.count - 1 {
                                    countNum = 0
                                }
                                self.word = allword[countNum].word
                                self.meanCn = allword[countNum].meanCn
                                
                                for i in cvm.favwords.indices{
                                    if allword[countNum].word == cvm.favwords[i].word{
                                        self.fav = "heart.fill"
                                        break
                                    }else{
                                        self.fav = "heart"
                                    }
                                }
                            }
                            .lineLimit(1).minimumScaleFactor(0.1)
                    }
                }
                .minimumScaleFactor(0.1)
                .frame(width: 80,alignment: .center)
                
            } // Provides some buffer around the product
            .onReceive(Timer.publish(every: userSettings.changeTime, on: .main, in: .common).autoconnect()){input in
                    if countNum < allword.count - 1 {
                        countNum += 1
                    } else if countNum >= allword.count - 1 {
                        countNum = 0
                    }
                self.word = allword[countNum].word
                self.meanCn = allword[countNum].meanCn
                for i in cvm.favwords.indices{
                    if allword[countNum].word == cvm.favwords[i].word{
                        self.fav = "heart.fill"
                        break
                    }else{
                        self.fav = "heart"
                    }
                }
            }.onAppear{
                if !loaded{
                    vm.fetchData()
                    cvm.queryFav()
                    for f in vm.wordInfo{
                        if (f.bookId == self.bookId){
                            self.allword = f.AllWord
                        }
                    }
                    self.word = allword[countNum].word
                    self.meanCn = allword[countNum].meanCn
                    for i in cvm.favwords.indices{
                        if allword[countNum].word == cvm.favwords[i].word{
                            self.fav = "heart.fill"
                            break
                        }else{
                            self.fav = "heart"
                        }
                    }
                    
                    loaded = true
                }
            }
            
        }
    }
    
    
    private func toggleSidebar() { // 2
        #if os(iOS)
        #else
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
}
            
extension NSTableView {
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()

        backgroundColor = NSColor.clear
        enclosingScrollView!.drawsBackground = false
    }
}

extension ContentView {
    
    class ViewModel: ObservableObject{
        //获取英文单词
        let service = FileService()
        @Published var wordInfo: [AllBookModel] = []
        func fetchData(){
            if let word = service.fetchJsonFile(){
                self.wordInfo = word.english
            }
        }
    }
    
    class bookViewModel: ObservableObject{
        let service = FileService()
        //获取单词书
        @Published var bookInfo: [Books] = []
        func bookfetchData(){
            if let book = service.fetchbookJsonFile(){
                self.bookInfo = book.books
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
