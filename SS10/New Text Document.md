mindmap
  root((MYSQL: VIEW & INDEX))
    VIEW (KHUNG NHÌN)
      1. Khái niệm
        Là Bảng ảo (Virtual Table)
        Không chứa dữ liệu vật lý
        Chỉ lưu trữ câu lệnh SQL (Logic truy vấn)
        Cơ chế: Thực thi câu lệnh lưu sẵn -> Lấy từ bảng gốc -> Trả kết quả
      2. Đặc điểm nổi bật
        Tính ảo (Virtual): Như "cửa sổ" nhìn vào dữ liệu, cập nhật tức thì khi bảng gốc thay đổi
        Đơn giản hóa: Gói gọn query phức tạp/JOIN vào 1 tên gọi
        Bảo mật: Ẩn cột nhạy cảm, chỉ hiện cột công khai
        Tính nhất quán: Thay đổi tên cột bảng gốc không ảnh hưởng ứng dụng (nhờ Alias trong View)
      3. Cú pháp
        Tạo/Cập nhật: CREATE OR REPLACE VIEW [Tên_View] AS SELECT...
        Xóa: DROP VIEW [Tên_View] (Không mất dữ liệu gốc)
      4. WITH CHECK OPTION (Quan trọng)
        Vấn đề: Insert/Update qua View nhưng dữ liệu không thỏa mãn điều kiện WHERE -> Dữ liệu "biến mất" khỏi View
        Giải pháp: Thêm mệnh đề WITH CHECK OPTION
        Cơ chế: Bắt buộc INSERT/UPDATE phải thỏa mãn điều kiện WHERE của View
        Hậu quả vi phạm: Báo lỗi, chặn thao tác
    INDEX (CHỈ MỤC)
      1. Khái niệm
        Ví dụ: Như "Mục lục" của cuốn sách
        Bản chất: Cấu trúc dữ liệu đặc biệt (thường là B-Tree)
        Lợi ích: Tránh Full Table Scan (Quét toàn bộ), Tăng tốc SELECT/JOIN/ORDER BY
      2. Phân loại
        Primary Key Index: Bắt buộc Unique + Not Null (Tự động tạo)
        Unique Index: Đảm bảo duy nhất, cho phép NULL (Email, SĐT)
        Normal Index: Tăng tốc tìm kiếm, cho phép trùng lặp
        Full-text Index: Tìm kiếm văn bản dài, tối ưu hơn LIKE
        Composite Index: Index trên nhiều cột cùng lúc
      3. Cú pháp
        Tạo thường: CREATE INDEX hoặc ALTER TABLE... ADD INDEX
        Tạo Unique: CREATE UNIQUE INDEX
        Xóa: DROP INDEX hoặc ALTER TABLE... DROP INDEX
      4. Hạn chế (Trade-off)
        Tốn dung lượng: Chiếm không gian ổ cứng
        Giảm tốc độ Ghi (Write): Làm chậm INSERT/UPDATE/DELETE (do phải sắp xếp lại Index)
        Phức tạp bảo trì: Cần chống phân mảnh định kỳ
      5. Chiến lược sử dụng
        NÊN dùng (Do)
          Cột Primary Key, Foreign Key
          Cột hay dùng trong WHERE, ORDER BY, JOIN
          Cột có độ phân tán cao (Email, CMND)
        KHÔNG NÊN dùng (Don't)
          Bảng quá nhỏ (Full scan nhanh hơn)
          Cột bị UPDATE liên tục
          Cột có độ phân tán thấp (Giới tính, Trạng thái 0/1)