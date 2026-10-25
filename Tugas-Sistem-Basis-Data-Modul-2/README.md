# Modul 2 - Sistem Basis Data (`its_library`)

Petunjuk pengerjaan dan eksekusi skrip SQL untuk Modul 2.

---

## 🚀 Urutan Eksekusi Skrip

Jalankan skrip secara berurutan:

1. **`Maker.sql`** (DDL)
   - Membuat database `its_library`.
   - Membuat tabel: `publisher`, `book`, `author`, `book_author`, `staff`, `member`, `loan`, dan `fine`.
   - Menetapkan Primary Key, Foreign Key, serta constraint relasi (`ON UPDATE CASCADE ON DELETE CASCADE`).

2. **`Inserter.sql`** (Data Seeding)
   - Melakukan insert data awal ke seluruh tabel perpustakaan.

3. **`DML.sql`** (Data Manipulation)
   - Menambahkan data denda (`fine`).
   - Memperbarui tanggal pengembalian dan status pinjaman (`loan`).
   - Memperbarui nomor telepon anggota (`member`).
   - Memperbarui status pembayaran denda menjadi *Paid*.
   - Menghapus buku dan pinjaman yang berstatus *Returned*.
