# Folder Efek Suara (Audio SFX)

Folder ini digunakan untuk menyimpan file audio efek suara aplikasi Quri.

## File yang Dibutuhkan:

1. **`correct.mp3`**
   - Efek suara saat jawaban pengguna **BENAR**.
   - Format yang disarankan: `.mp3` atau `.wav` berdurasi pendek (0.5 - 1.5 detik, seperti suara "ding" atau "chime" Duolingo).

2. **`wrong.mp3`** (Opsional tapi sudah siap di kode)
   - Efek suara saat jawaban pengguna **SALAH**.
   - Format: `.mp3` atau `.wav` (suara "buzz" atau "thud" lembut).

3. **`level_complete.mp3`** (Opsional tapi sudah siap di kode)
   - Efek suara saat berhasil menyelesaikan satu level kuis.
   - Format: `.mp3` atau `.wav` (suara terompet/kemenangan gamifikasi).

---
> **Catatan:**
> Kode aplikasi sudah langsung terhubung dengan file-file ini via `AudioService`. Begitu Anda meletakkan file dengan nama di atas ke dalam folder ini, efek suara akan otomatis berbunyi tanpa perlu mengubah kode lagi.
