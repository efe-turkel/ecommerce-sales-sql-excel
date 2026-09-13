-- 1. Tabloların Oluşturulması ve Veri Girişi
CREATE TABLE musteriler (
    musteri_id INT PRIMARY KEY,
    ad_soyad VARCHAR(50),
    sehir VARCHAR(50),
    kayit_tarihi DATE
);

CREATE TABLE urunler (
    urun_id INT PRIMARY KEY,
    urun_adi VARCHAR(50),
    kategori VARCHAR(50),
    alis_fiyati DECIMAL(10,2),
    satis_fiyati DECIMAL(10,2)
);

CREATE TABLE siparisler (
    siparis_id INT PRIMARY KEY,
    musteri_id INT,
    urun_id INT,
    adet INT,
    siparis_tarihi DATE,
    durum VARCHAR(20),
    FOREIGN KEY (musteri_id) REFERENCES musteriler(musteri_id),
    FOREIGN KEY (urun_id) REFERENCES urunler(urun_id)
);

-- 2. Analitik İş Sorgusu (Ciro, Net Kâr ve Durum Birleştirmesi)
SELECT 
    s.siparis_id,
    s.siparis_tarihi,
    m.ad_soyad AS musteri,
    m.sehir,
    u.kategori,
    u.urun_adi,
    s.adet,
    (s.adet * u.satis_fiyati) AS toplam_ciro,
    (s.adet * (u.satis_fiyati - u.alis_fiyati)) AS net_kar,
    s.durum
FROM siparisler s
INNER JOIN musteriler m ON s.musteri_id = m.musteri_id
INNER JOIN urunler u ON s.urun_id = u.urun_id
ORDER BY s.siparis_id;
