//
//  ContentView.swift
//  NotesCoreData
//
//  Created by Admin on 21.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM : CoreDataManager
    @State private var dmTittle: String = ""
    @State private var dmData: String = ""
    @State private var datacore: [EntityData] = [EntityData]()
    @State private var needsRefresh: Bool = false
    
    private func populateDate() {
        datacore = coreDM.getAllDate()
       }
    
    var body: some View {
        
        NavigationView{
           
            VStack{
                Text("Заметки").frame(width: 350, alignment: .leading).font(Font.system(size: 37).bold()).foregroundColor(Color.init(#colorLiteral(red: 0.9061674476, green: 0.8705458045, blue: 0.5355166793, alpha: 1)))
               
                TextField("Введите Заголовок", text: $dmTittle)
                    .foregroundColor(.white)
                Button("Добавить") {
                    guard dmTittle != "" else{return}
                    coreDM.saveData(tittle: dmTittle, data: dmData)
                    populateDate()
                    hidekeyboard()
                }.font(Font.system(size: 22).italic().bold()).foregroundColor(Color.init(#colorLiteral(red: 0.9061674476, green: 0.8705458045, blue: 0.5355166793, alpha: 1)))
                
                List {
                    ForEach (datacore, id: \.self) { datacoree in
                        NavigationLink(
                            destination: DataDetail(datacore: datacoree, coreDM: coreDM, needsRefresh: $needsRefresh),
                            label: {
                                Text(datacoree.tittle ?? "")
                            })
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in let data = datacore[index]
                            coreDM.deleteData(data: data)
                            populateDate()
                        }
                        
                    }).listRowBackground(Color.black)
                    .font(Font.system(size: 20).italic()).foregroundColor(Color.init(#colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)))
                }
                
            }
            //.navigationTitle("Заметки").navigationBarHidden(false).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .onAppear(perform: {
                populateDate()
                
            })
            
        
        }.preferredColorScheme(.dark)
        .accentColor(Color.init(#colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)))
    }
    
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
}
