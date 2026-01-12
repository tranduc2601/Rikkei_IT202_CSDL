# SS3: Thao tác dữ liệu SQL (DML & DQL)

## Lesson 01: Câu lệnh INSERT (Thêm mới)
- **Khái niệm**
    - Nhóm DML (Data Manipulation Language)
    - Tác động trực tiếp dữ liệu trong bảng
    - Thực hiện sau quá trình DDL (tạo khung)
- **Các cách chèn dữ liệu**
    - Chèn 1 bản ghi
        - Cú pháp: `INSERT INTO table... VALUES...`
        - Ví dụ: Thêm 1 khách hàng mới
    - Chèn nhiều bản ghi (Bulk Insert)
        - Dùng nhiều giá trị trong VALUES ngăn cách bởi dấu phẩy
    - Chèn từ bảng khác
        - Cú pháp: `INSERT INTO ... SELECT ...`
        - Mục đích: Sao chép, backup, tổng hợp số liệu
- **Lưu ý quan trọng**
    - Ràng buộc NOT NULL: Không được để trống
    - Giá trị mặc định (Default): Tự điền nếu không nhập, nếu không có Default sẽ là NULL
    - Khóa ngoại (Foreign Key): Phải tồn tại ở bảng cha trước
    - Định dạng ngày: 'YYYY-MM-DD' (cần kiểm tra kỹ)
- **Lợi ích & Ứng dụng**
    - Dễ dàng thêm/tích hợp dữ liệu
    - Dùng trong đăng ký thành viên, tạo đơn hàng...

## Lesson 02: Câu lệnh UPDATE (Cập nhật)
- **Khái niệm**
    - Nhóm DML
    - Sửa dữ liệu đã có, không đổi cấu trúc bảng
    - Quản lý dữ liệu động (số dư, trạng thái...)
- **Cấu trúc lệnh**
    - `UPDATE table_name`
    - `SET column = value` (Cột cần sửa)
    - `WHERE condition` (Điều kiện lọc)
- **Phân loại theo điều kiện WHERE**
    - Theo ID (Khóa chính)
        - An toàn nhất, duy nhất (Unique)
        - Tác động chính xác 1 bản ghi
    - Cập nhật hàng loạt
        - Dùng toán tử logic: =, <>, BETWEEN, IN...
        - Ví dụ: Giảm giá toàn bộ hàng tồn kho
- **⚠️ CẢNH BÁO QUAN TRỌNG**
    - **Quên WHERE = THẢM HỌA**
    - Hậu quả: Toàn bộ dữ liệu trong bảng bị sửa về cùng 1 giá trị

## Lesson 03: Câu lệnh DELETE (Xóa)
- **Khái niệm**
    - Nhóm DML
    - Xóa dòng dữ liệu (Row), không xóa cấu trúc bảng
    - Khác lệnh DROP (xóa cả bảng)
- **Cấu trúc lệnh**
    - `DELETE FROM table_name`
    - `WHERE condition`
- **Phân loại theo điều kiện WHERE**
    - Theo ID (Khóa chính)
        - An toàn, xóa chính xác đối tượng
    - Theo điều kiện logic
        - Ví dụ: Xóa khách hàng tên "A"
- **⚠️ CẢNH BÁO QUAN TRỌNG**
    - **Quên WHERE = XÓA SẠCH BẢNG**
    - `DELETE FROM Customers` (không WHERE) -> Mất hết dữ liệu

## Lesson 04: Câu lệnh SELECT (Truy xuất)
- **Khái niệm**
    - Nhóm DQL (Data Query Language)
    - Quan trọng nhất trong SQL
    - Chỉ đọc/hiển thị, không làm thay đổi dữ liệu gốc
    - Kết quả trả về: Tập kết quả (Result Set)
- **Các thao tác lấy dữ liệu**
    - Lấy tất cả (`SELECT *`)
        - Kiểm tra nhanh toàn bộ bảng
    - Lấy cột cụ thể (`SELECT col1, col2`)
        - Tối ưu hiệu suất, tiết kiệm băng thông
- **Lưu ý tối ưu**
    - Viết điều kiện chính xác
    - Dùng `LIMIT`: Giới hạn số dòng trả về
    - Dùng `ORDER BY`: Sắp xếp kết quả
- **Lợi ích & Ứng dụng**
    - Truy xuất nhanh, tìm kiếm chính xác
    - Hỗ trợ phân tích, báo cáo
    - Ví dụ: Xem tồn kho, lịch sử bệnh án, danh sách user