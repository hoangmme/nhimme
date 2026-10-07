# Hệ Thống Điểm Danh Trường Học Nội Bộ

Ứng dụng web điểm danh trường học nội bộ chạy hoàn toàn Client-side trên trình duyệt, lưu trữ RAM an toàn tuyệt đối.

## 🚀 Tính năng chính
1. **Phân quyền người dùng**:
   - **Admin**: Quản lý 21 lớp toàn trường, xuất báo cáo Excel chuẩn tuần/tháng của Bộ GD&ĐT.
   - **Giáo viên**: Mở phiên điểm danh QR động (tự hủy sau 5 phút), lưới học sinh đổi trạng thái nhanh (Có mặt, Vắng, Muộn, Vắng có phép).
   - **Học sinh**: Xác nhận điểm danh nhanh tại lớp, xem lịch sử chuyên cần theo tháng.
2. **Chống gian lận & Đơn từ**:
   - Giới hạn dải IP nội bộ trường (chặn điểm danh từ xa nếu dùng 4G hoặc mạng ngoài).
   - Tự động đồng bộ học sinh có đơn nghỉ phép đã duyệt trước sang trạng thái "Vắng có phép".

## 🛠️ Cách sử dụng
- Mở trực tiếp file `index.html` bằng trình duyệt web bất kỳ.
- Chạy file `push_to_github.bat` khi muốn tự động đẩy các thay đổi lên GitHub kèm ngày giờ commit.
