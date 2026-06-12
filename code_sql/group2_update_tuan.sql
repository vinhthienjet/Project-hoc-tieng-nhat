DROP DATABASE IF EXISTS hoc_tieng_nhat;
CREATE DATABASE hoc_tieng_nhat;
USE hoc_tieng_nhat;

-- =========================
-- BANG NGUOI DUNG
-- =========================
CREATE TABLE nguoi_dung (
ma_nguoi_dung INT AUTO_INCREMENT PRIMARY KEY,
ten_dang_nhap VARCHAR(50) UNIQUE NOT NULL,
mat_khau VARCHAR(255) NOT NULL,
ho_ten VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE,
vai_tro ENUM('USER','ADMIN') DEFAULT 'USER',
trang_thai BOOLEAN DEFAULT TRUE,
ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE lich_su_dang_nhap (
    ma_dang_nhap INT AUTO_INCREMENT PRIMARY KEY,
    ma_nguoi_dung INT NOT NULL,
    thoi_gian_dang_nhap DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (ma_nguoi_dung)
    REFERENCES nguoi_dung(ma_nguoi_dung)
);
/* CHỦ ĐỀ*/
CREATE TABLE chu_de (
    ma_chu_de INT AUTO_INCREMENT PRIMARY KEY,
    ten_chu_de VARCHAR(100) NOT NULL
);

-- =========================
-- BANG BAI HOC
-- =========================
CREATE TABLE bai_hoc (
ma_bai_hoc INT AUTO_INCREMENT PRIMARY KEY,
ma_chu_de INT NOT NULL,
tieu_de VARCHAR(200) NOT NULL,
mo_ta TEXT,
noi_dung TEXT,
ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (ma_chu_de) REFERENCES chu_de(ma_chu_de)
);

-- =========================
-- BANG TU VUNG
-- =========================
CREATE TABLE tu_vung (
ma_tu_vung INT AUTO_INCREMENT PRIMARY KEY,
ma_bai_hoc INT NOT NULL,

kanji VARCHAR(100),
hiragana VARCHAR(100),
nghia VARCHAR(255) NOT NULL,
vi_du TEXT,
am_thanh VARCHAR(255),

FOREIGN KEY (ma_bai_hoc)
    REFERENCES bai_hoc(ma_bai_hoc)
    ON DELETE CASCADE

);

-- =========================
-- BANG BAI QUIZ
-- =========================
CREATE TABLE bai_quiz (
ma_quiz INT AUTO_INCREMENT PRIMARY KEY,
ma_bai_hoc INT NOT NULL,

ten_quiz VARCHAR(200) NOT NULL,
mo_ta TEXT,

FOREIGN KEY (ma_bai_hoc)
    REFERENCES bai_hoc(ma_bai_hoc)
    ON DELETE CASCADE

);

-- =========================
-- BANG CAU HOI
-- =========================
CREATE TABLE cau_hoi (
ma_cau_hoi INT AUTO_INCREMENT PRIMARY KEY,
ma_quiz INT NOT NULL,

loai_cau_hoi ENUM(
'chon_dap_an',
'dien_tu',
'nghe'
),
noi_dung TEXT NOT NULL,

FOREIGN KEY (ma_quiz)
    REFERENCES bai_quiz(ma_quiz)
    ON DELETE CASCADE

);

-- =========================
-- BANG DAP AN
-- =========================
CREATE TABLE dap_an (
ma_dap_an INT AUTO_INCREMENT PRIMARY KEY,
ma_cau_hoi INT NOT NULL,

noi_dung VARCHAR(255) NOT NULL,
dap_an_dung BOOLEAN DEFAULT FALSE,

FOREIGN KEY (ma_cau_hoi)
    REFERENCES cau_hoi(ma_cau_hoi)
    ON DELETE CASCADE

);

-- =========================
-- BANG TIEN DO BAI HOC
-- =========================
CREATE TABLE tien_do_bai_hoc (
ma_tien_do INT AUTO_INCREMENT PRIMARY KEY,

ma_nguoi_dung INT NOT NULL,
ma_bai_hoc INT NOT NULL,

da_hoan_thanh BOOLEAN DEFAULT FALSE,
ngay_hoan_thanh DATETIME,

FOREIGN KEY (ma_nguoi_dung)
    REFERENCES nguoi_dung(ma_nguoi_dung)
    ON DELETE CASCADE,

FOREIGN KEY (ma_bai_hoc)
    REFERENCES bai_hoc(ma_bai_hoc)
    ON DELETE CASCADE

);

-- =========================
-- BANG TU VUNG DA HOC
-- =========================
CREATE TABLE tu_vung_da_hoc (
ma_hoc_tu_vung INT AUTO_INCREMENT PRIMARY KEY,

ma_nguoi_dung INT NOT NULL,
ma_tu_vung INT NOT NULL,

ngay_hoc DATETIME DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY (ma_nguoi_dung)
    REFERENCES nguoi_dung(ma_nguoi_dung)
    ON DELETE CASCADE,

FOREIGN KEY (ma_tu_vung)
    REFERENCES tu_vung(ma_tu_vung)
    ON DELETE CASCADE

);

-- =========================
-- BANG KET QUA QUIZ
-- =========================
CREATE TABLE ket_qua_quiz (
ma_ket_qua INT AUTO_INCREMENT PRIMARY KEY,

ma_nguoi_dung INT NOT NULL,
ma_quiz INT NOT NULL,

diem DECIMAL(5,2),
thoi_gian_nop DATETIME DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY (ma_nguoi_dung)
    REFERENCES nguoi_dung(ma_nguoi_dung)
    ON DELETE CASCADE,

FOREIGN KEY (ma_quiz)
    REFERENCES bai_quiz(ma_quiz)
    ON DELETE CASCADE

);