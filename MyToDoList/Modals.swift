//
//  Modals.swift
//  MyToDoList
//
//  Created by Trần Văn Cam on 17/11/2022.
//

import Foundation

struct ToDoList {
    var id: String
    var todo: String
    var isDone: Bool
    var expired: String
    
    init(todo: String, isDone: Bool, expired: String) {
        self.id = UUID().uuidString
        self.todo = todo
        self.isDone = isDone
        self.expired = expired
    }
}

func fakeData() -> [ToDoList] {
    let todo1 = ToDoList(todo: "Ngừng lo lắng về tiền bạc", isDone: false, expired: "20/11/2022")
    let todo2 = ToDoList(todo: "Ngừng lo lắng về suy nghĩ của người khác", isDone: true, expired: "20/11/2022")
    let todo3 = ToDoList(todo: "Đi nghỉ 2 lần mỗi năm", isDone: false, expired: "20/11/2022")
    let todo4 = ToDoList(todo: "Tận hưởng những phút giây vui vẻ trong đời", isDone: true, expired: "20/11/2022")
    let todo5 = ToDoList(todo: "Trải nghiệm những nền văn hóa khác nhau", isDone: false, expired: "20/11/2022")
    let todo6 = ToDoList(todo: "Làm việc để sống thay vì sống để làm việc", isDone: false, expired: "20/11/2022")
    let todo7 = ToDoList(todo: "Trả hết nợ nần", isDone: true, expired: "20/11/2022")
    let todo8 = ToDoList(todo: "Thành thực với chính bản thân mình", isDone: false, expired: "20/11/2022")
    let todo9 = ToDoList(todo: "Quan tâm đến những gì bạn có thay vì những gì bạn không có", isDone: false, expired: "20/11/2022")

//    let todo10 = ToDoList(todo: "Dùng tiền để có thêm nhiều trải nghiệm hơn là dành dụm cho những lúc khó khăn", isDone: false, expired: "20/11/2022")
//    let todo11 = ToDoList(todo: "Dành thời gian cho gia đình và bạn bè", isDone: false, expired: "20/11/2022")
//    let todo12 = ToDoList(todo: "Nếm thử tất cả các món ăn", isDone: false, expired: "20/11/2022")
//    let todo13 = ToDoList(todo: "Tìm kiếm tình yêu đích thực", isDone: false, expired: "20/11/2022")
//    let todo14 = ToDoList(todo: "Đi du lịch đến ít nhất 25 quốc gia khác nhau", isDone: false, expired: "20/11/2022")
//    let todo15 = ToDoList(todo: "Ra ngoài nhiều hơn", isDone: true, expired: "20/11/2022")
//    let todo16 = ToDoList(todo: "Học một ngôn ngữ mới", isDone: false, expired: "20/11/2022")
//    let todo17 = ToDoList(todo: "Được gia đình và bạn bè nghĩ tốt về mình", isDone: false, expired: "20/11/2022")
//    let todo18 = ToDoList(todo: "Giúp đỡ các thành viên trong gia đình khi học thực sự cần đến bạn", isDone: false, expired: "20/11/2022")
//    let todo19 = ToDoList(todo: "Giảm 14 pound cân nặng", isDone: false, expired: "20/11/2022")
//    let todo20 = ToDoList(todo: "Xem mỗi ngày như thể là ngày cuối cùng của bạn", isDone: false, expired: "20/11/2022")
//    let todo21 = ToDoList(todo: "Đến thăm tất cả các di tích lịch sử", isDone: false, expired: "20/11/2022")
//    let todo22 = ToDoList(todo: "Đặt vé đi du lịch vào phút cuối cùng", isDone: false, expired: "20/11/2022")
//    let todo23 = ToDoList(todo: "Tham gia hoạt động thiện nguyện", isDone: false, expired: "20/11/2022")
//    let todo24 = ToDoList(todo: "Nhận lời thách thức", isDone: false, expired: "20/11/2022")
//    let todo25 = ToDoList(todo: "Tham gia một chuyến đi săn", isDone: false, expired: "20/11/2022")
//    let todo26 = ToDoList(todo: "Vung tiền vào một cuộc đi mua sắm, chỉ bởi bạn có thể làm điều đó 27. Học một nhạc cụ mới", isDone: false, expired: "20/11/2022")
//    let todo27 = ToDoList(todo: "Kéo dài cuộc sống hôn nhân trên 20 năm", isDone: false, expired: "20/11/2022")
//    let todo28 = ToDoList(todo: "Có đủ tiền để cho các cháu chắt", isDone: false, expired: "20/11/2022")
//    let todo29 = ToDoList(todo: "Lập gia đình", isDone: false, expired: "20/11/2022")
//    let todo30 = ToDoList(todo: "Kiếm nhiều tiền hơn số tuổi của bạn", isDone: false, expired: "20/11/2022")
//    let todo31 = ToDoList(todo: "Nuôi một con thú cưng", isDone: false, expired: "20/11/2022")
//    let todo32 = ToDoList(todo: "Lái một chiếc xe tốt", isDone: false, expired: "20/11/2022")
//    let todo33 = ToDoList(todo: "Đi du lịch một mình", isDone: false, expired: "20/11/2022")
//    let todo34 = ToDoList(todo: "Nuôi dạy con cái một cách khéo léo", isDone: false, expired: "20/11/2022")
//    let todo35 = ToDoList(todo: "Gặp gỡ những người lạ", isDone: false, expired: "20/11/2022")
//    let todo36 = ToDoList(todo: "Đến một địa điểm lạ", isDone: false, expired: "20/11/2022")
//    let todo37 = ToDoList(todo: "Trải qua cuộc tình một đêm", isDone: false, expired: "20/11/2022")
//    let todo38 = ToDoList(todo: "Thi đỗ bằng lái xe", isDone: false, expired: "20/11/2022")
//    let todo39 = ToDoList(todo: "Đạt được một trình độ học vấn nhất định", isDone: false, expired: "20/11/2022")
//    let todo40 = ToDoList(todo: "Cứu sống ai đó và bạn sẽ là người hùng", isDone: false, expired: "20/11/2022")
//    let todo41 = ToDoList(todo: "Hẹn hò với ai đó thú vị nhưng thực sự không phù hợp với bạn", isDone: false, expired: "20/11/2022")
//    let todo42 = ToDoList(todo: "Được thăng chức", isDone: false, expired: "20/11/2022")
//    let todo43 = ToDoList(todo: "Đạt tới đỉnh cao sự nghiệp mà bạn mong muốn ở tuổi 40", isDone: false, expired: "20/11/2022")
//    let todo44 = ToDoList(todo: "Tiệc tùng thâu đêm", isDone: false, expired: "20/11/2022")
//    let todo45 = ToDoList(todo: "Biểu diễn một tiết mục nào đó trên sân khấu trước những người khác", isDone: false, expired: "20/11/2022")
//    let todo46 = ToDoList(todo: "Hôn một người lạ", isDone: false, expired: "20/11/2022")
//    let todo47 = ToDoList(todo: "Lên kế hoạch cho một bữa tiệc bất ngờ", isDone: false, expired: "20/11/2022")
//    let todo48 = ToDoList(todo: "Chơi những môn thể thao gây cảm giác mạnh như nhảy dù hoặc nhảy bungee", isDone: false, expired: "20/11/2022")
//    let todo49 = ToDoList(todo: "Dành thời gian chơi với trẻ nhỏ, ngay cả khi chúng không phải là con bạn", isDone: false, expired: "20/11/2022")
//
    return [todo1 , todo2, todo3, todo4, todo5, todo6, todo7, todo8, todo9//, todo10, todo11, todo12, todo13, todo14, todo15, todo16, todo17, todo18, todo19, todo20, todo21, todo22, todo23, todo24, todo25, todo26, todo27, todo28, todo29, todo30, todo31, todo32, todo33, todo34, todo35, todo36, todo37, todo38, todo39, todo40, todo41, todo42, todo43, todo44, todo45, todo46, todo47, todo48, todo49
    ]
}
