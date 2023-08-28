//
//  CalendarView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import SwiftUI

import ToolinderShared

public struct CalendarView: View {
    public init() {}
    
    public var body: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7), spacing: .zero) {
            ForEach(0..<30) { i in
                Text("\(i)")
            }
        }
    }
}

//import ComposableArchitecture
//
//struct FileItemView: View {
//    let file: File
//
//    init(file: File) {
//        self.file = file
//    }
//
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text("\(file.startDate.toString(format: "HH:mm a"))")
//                    .font(.headline)
//                    .fontWeight(.semibold)
//
//                Text("\(file.endDate.toString(format: "HH:mm a"))")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//
//            Divider()
//                .frame(width: 5)
//                .overlay(Color(rgb: file.rgb))
//                .cornerRadius(2, corners: .allCorners)
//
//            Text(file.title)
//                .lineLimit(1)
//
//            Spacer()
//        }
//    }
//}
//
//struct FileLabelView: View {
//    let file: File
//
//    init(file: File) {
//        self.file = file
//    }
//
//    var body: some View {
//        HStack(spacing: .zero) {
//            Divider()
//                .frame(width: 2, height: 10)
//                .overlay(Color(rgb: file.rgb))
//                .cornerRadius(2, corners: .allCorners)
//                .padding(.trailing, 3)
//
//            Text(file.title)
//                .font(.caption2)
//                .fontWeight(.light)
//                .lineLimit(1)
//
//            Spacer()
//        }
//        .background(file.term > 1 ? Color(rgb: file.rgb).opacity(0.15) : .clear)
//    }
//}
//
//public struct CalendarView: View {
//    let store: StoreOf<Calendar>
//
//    private let weeks: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
//
//    public init() {
//        self.store = .init(initialState: .init(), reducer: Calendar()._printChanges())
//    }
//
//    public var body: some View {
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            ScrollView {
//                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7), spacing: .zero) {
//                    ForEach(weeks, id: \.self) { week in
//                        VStack {
//                            Text(week)
//                                .font(.caption2)
//                                .fontWeight(.light)
//                        }
//                    }
//
//                    ForEach(viewStore.calendarFiles) { calendarFile in
//                        VStack(spacing: .zero) {
//                            HStack(spacing: .zero) {
//                                Spacer()
//
//                                Text("\(calendarFile.date.day)")
//                                    .font(.callout)
//                                    .fontWeight(.semibold)
//                                    .opacity(
//                                        calendarFile.date.month == viewStore.date.month
//                                        ? 1 : 0.4
//                                    )
//
//                                Spacer()
//                            }
//
//                            ZStack() {
//                                ForEach(Array(calendarFile.visiableFiles.enumerated()), id: \.element) { index, file in
//                                    if let file = file, file.isHead(date: calendarFile.date) {
//                                        FileLabelView(file: file)
//                                            .frame(width: file.width(date: calendarFile.date))
//                                            .offset(file.offset(date: calendarFile.date, index: index))
//                                    }
//                                }
//                            }
//
//                            Spacer()
//                        }
//                        .onTapGesture {
//                            print("[D] \(calendarFile)")
//                            viewStore.send(.selectCalendarCell(calendarFile.date), animation: .default)
//                        }
//                        .frame(height: UIScreen.screenHeight * 0.08)
//                    }
//                }
//                .padding(.horizontal, 10)
//
//                VStack {
//                    HStack {
//                        Text(Date.toString(date: viewStore.date))
//                            .font(.title3)
//                            .fontWeight(.bold)
//
//                        Spacer()
//
//                        Button {
//                            viewStore.send(.tapMemoButton)
//                        } label: {
//                            Image(systemName: "calendar.badge.plus")
//                                .font(.title3)
//                        }
//                    }
//
//                    if let calendarFile = viewStore.calendarFile {
//                        ForEach(calendarFile.files) { file in
//                            FileItemView(file: file)
//                                .padding()
//                                .onTapGesture {
//                                    viewStore.send(.tapFileLabel(file))
//                                }
//                                .background(Color(.systemGray6))
//                                .cornerRadius(10, corners: .allCorners)
//                        }
//                    }
//
//                    Spacer()
//                }
//                .padding(.horizontal)
//            }
//            .toolbar {
//                ToolbarItemGroup(placement: .navigationBarLeading) {
//                    Text(Date.toString(format: "yyyy.MM", date: viewStore.date))
//                }
//
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        viewStore.send(.tapLeftButton, animation: .default)
//                    }, label: {
//                        Image(systemName: "chevron.left")
//                            .font(.caption)
//                            .fontWeight(.bold)
//                    })
//                }
//
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        viewStore.send(.tapRightButton, animation: .default)
//                    }, label: {
//                        Image(systemName: "chevron.right")
//                            .font(.caption)
//                            .fontWeight(.bold)
//                    })
//                }
//
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        viewStore.send(.setAccountSheet(isPresented: true))
//                    }, label: {
//                        Image(systemName: "person.crop.circle")
//                            .fontWeight(.bold)
//                    })
//                }
//            }
//            .sheet(isPresented: viewStore.binding(get: \.isSheetPresented, send: Calendar.Action.setSheet(isPresented:))) {
//                EditFileView(store: self.store.scope(state: \.editFile, action: Calendar.Action.editFile))
//                    .presentationDetents([.medium])
//            }
//            .sheet(isPresented: viewStore.binding(get: \.isAccountSheetPresented, send: Calendar.Action.setAccountSheet(isPresented:))) {
//                AccountView()
//            }
//            .task {
//                viewStore.send(.refresh, animation: .default)
//            }
//        }
//    }
//}
//
