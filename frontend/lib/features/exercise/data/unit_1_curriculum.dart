import 'models/exercise_model.dart';

/// Kurikulum lengkap Unit 1: Huruf Hijaiyah (13 Level, masing-masing 15 soal)
/// Sesuai dokumen kurikulum resmi QURI.
class Unit1Curriculum {
  Unit1Curriculum._();

  static final List<ExerciseLevel> levels = [
    // =========================================================================
    // LEVEL 1: Huruf Alif & Ba (ا - ب)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 1,
      title: 'Level 1: Alif & Ba',
      arabicSubtitle: 'ا - ب',
      description: 'Pengenalan visual dasar huruf Alif dan Ba serta posisi titik',
      xpReward: 20,
      questions: [
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ا',
          options: ['Alif', 'Ba', 'Ta'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ب',
          options: ['Ba', 'Alif', 'Jim'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Alif!',
          options: ['ا', 'ب', 'ت'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Ba!',
          options: ['ب', 'ا', 'ج'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di manakah posisi titik pada huruf Ba?',
          visualPrompt: 'ب',
          options: ['Di bawah', 'Di atas', 'Tidak ada titik'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Apakah huruf Alif memiliki titik?',
          visualPrompt: 'ا',
          options: ['Tidak ada titik', 'Ada 1 titik di bawah', 'Ada 1 titik di atas'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Berapa jumlah titik pada huruf Ba?',
          visualPrompt: 'ب',
          options: ['Satu', 'Dua', 'Tiga'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan suara tersebut!',
          audioPath: 'alif.mp3',
          options: ['ا', 'ب', 'ت'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan suara tersebut!',
          audioPath: 'ba.mp3',
          options: ['ب', 'ا', 'ح'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara yang cocok untuk huruf di atas?',
          visualPrompt: 'ا',
          options: ['Suara Alif (alif.mp3)', 'Suara Ba (ba.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara yang cocok untuk huruf di atas?',
          visualPrompt: 'ب',
          options: ['Suara Ba (ba.mp3)', 'Suara Alif (alif.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah dari dua huruf ini yang dibaca Ba?',
          visualPrompt: 'ا   ب',
          options: ['ب', 'ا'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf untuk pelafalan "Alif"!',
          options: ['ا', 'ب', 'ت'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf untuk pelafalan "Ba"!',
          options: ['ب', 'ا', 'ث'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah pasangan huruf dan nama yang TEPAT?',
          options: ['ب = Ba', 'ا = Ba', 'ب = Alif'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 2: Huruf Ta & Tsa (ت - ث)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 2,
      title: 'Level 2: Ta & Tsa',
      arabicSubtitle: 'ت - ث',
      description: 'Mengenal bentuk visual Ta dan Tsa serta membedakannya dari Ba',
      xpReward: 20,
      questions: [
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ت',
          options: ['Ta', 'Ba', 'Tsa'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ث',
          options: ['Tsa', 'Ta', 'Alif'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Ta!',
          options: ['ت', 'ث', 'ب'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Tsa!',
          options: ['ث', 'ت', 'ا'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Berapa jumlah titik di atas huruf Ta?',
          visualPrompt: 'ت',
          options: ['Dua titik', 'Tiga titik', 'Satu titik'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Berapa jumlah titik di atas huruf Tsa?',
          visualPrompt: 'ث',
          options: ['Tiga titik', 'Dua titik', 'Satu titik'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di manakah letak titik pada huruf Ta (ت) jika dibandingkan dengan Ba (ب)?',
          visualPrompt: 'ب vs ت',
          options: ['Di atas', 'Di bawah', 'Di dalam'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'ta.mp3',
          options: ['ت', 'ث', 'ب'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'tsa.mp3',
          options: ['ث', 'ت', 'ا'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara yang tepat untuk huruf di atas?',
          visualPrompt: 'ت',
          options: ['Suara Ta (ta.mp3)', 'Suara Tsa (tsa.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara yang tepat untuk huruf di atas?',
          visualPrompt: 'ث',
          options: ['Suara Tsa (tsa.mp3)', 'Suara Ta (ta.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah di antara huruf berikut yang memiliki 3 titik di atas?',
          visualPrompt: 'ب, ت, ث',
          options: ['ث', 'ت', 'ب'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah yang merupakan huruf Ta?',
          options: ['ت', 'ب', 'ا'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah yang merupakan huruf Tsa?',
          options: ['ث', 'ت', 'ب'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di antara ب, ت, dan ث, manakah huruf yang titiknya berada di bawah?',
          options: ['Ba (ب)', 'Ta (ت)', 'Tsa (ث)'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 3: Huruf Jim, Ha, Kho (ج - ح - خ)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 3,
      title: 'Level 3: Jim, Ha, Kho',
      arabicSubtitle: 'ج - ح - خ',
      description: 'Mengenalkan 3 huruf lengkung baru dan posisi titiknya',
      xpReward: 25,
      questions: [
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ج',
          options: ['Jim', 'Ha', 'Kho'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ح',
          options: ['Ha', 'Kho', 'Jim'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'خ',
          options: ['Kho', 'Jim', 'Ha'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Jim!',
          options: ['ج', 'ح', 'خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di manakah letak titik pada huruf Jim?',
          visualPrompt: 'ج',
          options: ['Di dalam/tengah', 'Di atas', 'Tidak ada titik'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Apakah huruf Ha (ح) memiliki titik?',
          visualPrompt: 'ح',
          options: ['Polos (Tidak ada titik)', 'Ada 1 titik di atas', 'Ada 1 titik di bawah'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di manakah posisi titik pada huruf Kho?',
          visualPrompt: 'خ',
          options: ['Di atas kepala', 'Di dalam perut', 'Di bawah'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'jim.mp3',
          options: ['ج', 'ح', 'خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'ha.mp3',
          options: ['ح', 'خ', 'ت'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'kho.mp3',
          options: ['خ', 'ج', 'ح'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Mana suara pelafalan yang bersih dan tepat untuk huruf di atas?',
          visualPrompt: 'ح',
          options: ['Suara Ha Bersih (ha.mp3)', 'Suara Kho (kho.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah dari kelompok huruf berikut yang bentuk dasarnya Memiliki Perut / Ekor Lengkung?',
          options: ['ج, ح, خ', 'ب, ت, ث', 'ا'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di antara dua huruf di atas, manakah huruf Jim?',
          visualPrompt: 'ث   ج',
          options: ['ج', 'ث'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Tsa (materi Level 2)!',
          options: ['ث', 'ح', 'ج'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah pasangan huruf dan nama yang TEPAT?',
          options: ['خ = Kho', 'ح = Jim', 'ج = Ha'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 4: Mini-Review & Checkpoint Test (ا – خ)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 4,
      title: 'Level 4: Mini-Review & Checkpoint',
      arabicSubtitle: 'ا - خ',
      description: 'Review & Checkpoint pembedaan kelompok Perahu vs Lengkung (Alif - Kho)',
      xpReward: 30,
      badgeLabel: 'CHECKPOINT',
      questions: [
        ExerciseQuestion(
          questionText: 'Kelompok huruf mana yang memiliki bentuk dasar \'Perahu\'?',
          options: ['ب, ت, ث', 'ج, ح, خ', 'ا'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di antara huruf-huruf di atas, manakah yang merupakan huruf Kho?',
          visualPrompt: 'ت, ث, خ',
          options: ['خ', 'ت', 'ث'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah yang merupakan huruf Jim?',
          visualPrompt: 'ب   ج',
          options: ['ج', 'ب'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Tsa!',
          options: ['ث', 'ت', 'خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dua huruf manakah dari 7 huruf pertama yang SAMA SEKALI TIDAK MEMILIKI TITIK?',
          options: ['Alif (ا) dan Ha (ح)', 'Ba (ب) dan Ta (ت)', 'Jim (ج) dan Kho (خ)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Huruf apakah yang memiliki 3 titik di atas?',
          options: ['Tsa (ث)', 'Ta (ت)', 'Kho (خ)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Apa perbedaan posisi titik antara huruf Ba (ب) dan Jim (ج)?',
          options: [
            'Ba titiknya di bawah perahu, Jim titiknya di dalam perut',
            'Ba titiknya di atas, Jim titiknya di bawah',
            'Ba dan Jim memiliki posisi titik yang sama',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan suara berikut, huruf manakah yang sesuai?',
          audioPath: 'ta.mp3',
          options: ['ت', 'ث', 'ح'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan suara berikut, huruf manakah yang sesuai?',
          audioPath: 'kho.mp3',
          options: ['خ', 'ح', 'ج'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih audio yang merupakan pelafalan untuk huruf Tsa (ث)!',
          options: ['Suara Tsa (tsa.mp3)', 'Suara Ta (ta.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih audio yang merupakan pelafalan bersih untuk huruf Ha (ح)!',
          options: ['Suara Ha (ha.mp3)', 'Suara Kho (kho.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Sebutkan nama huruf di atas!',
          visualPrompt: 'ب',
          options: ['Ba', 'Ta', 'Jim'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Sebutkan nama huruf di atas!',
          visualPrompt: 'ح',
          options: ['Ha', 'Kho', 'Alif'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Urutan huruf Hijaiyah yang benar setelah Alif (ا) dan Ba (ب) adalah...',
          options: ['ت lalu ث', 'ج lalu ح', 'خ lalu د'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pasangan huruf dan nama mana yang SALAH?',
          options: ['ح = Kho', 'ت = Ta', 'ج = Jim'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 5: Huruf Dal, Dzal, Ro, Zai (د - ذ - ر - ز)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 5,
      title: 'Level 5: Dal, Dzal, Ro, Zai',
      arabicSubtitle: 'د - ذ - ر - ز',
      description: 'Mengenal 4 huruf baru dan pasangan sudut vs lengkung',
      xpReward: 25,
      questions: [
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'د',
          options: ['Dal', 'Dzal', 'Ro'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ذ',
          options: ['Dzal', 'Dal', 'Zai'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ر',
          options: ['Ro', 'Zai', 'Dal'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Zai!',
          options: ['ز', 'ر', 'ذ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Apa perbedaan antara huruf Dal (د) dan Dzal (ذ)?',
          visualPrompt: 'د vs ذ',
          options: [
            'Dzal memiliki 1 titik di atas, Dal tidak ber-titik',
            'Dal memiliki titik di bawah',
            'Bentuknya berbeda total',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Berapa jumlah titik di atas huruf Zai?',
          visualPrompt: 'ز',
          options: ['Satu titik di atas', 'Dua titik di atas', 'Tanpa titik'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di antara dua huruf di atas, manakah yang merupakan huruf Ro?',
          visualPrompt: 'د   ر',
          options: ['ر', 'د'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'dal.mp3',
          options: ['د', 'ذ', 'ر'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'dzal.mp3',
          options: ['ذ', 'د', 'ز'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'zai.mp3',
          options: ['ز', 'ر', 'ذ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara yang cocok untuk huruf di atas?',
          visualPrompt: 'ر',
          options: ['Suara Ro (ro.mp3)', 'Suara Dal (dal.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Huruf manakah di bawah ini yang SAMA-SAMA MEMILIKI 1 TITIK DI ATAS?',
          options: [
            'ذ (Dzal), ز (Zai), dan خ (Kho)',
            'ب (Ba) dan ج (Jim)',
            'ت (Ta) dan ث (Tsa)',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Ro!',
          options: ['ر', 'د', 'ز'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Dal!',
          options: ['د', 'ذ', 'ر'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah pasangan huruf dan nama yang TEPAT?',
          options: ['ز = Zai', 'د = Dzal', 'ر = Dal'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 6: Huruf Sin & Syin (س - ش)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 6,
      title: 'Level 6: Sin & Syin',
      arabicSubtitle: 'س - ش',
      description: 'Mengenal huruf Sin dan Syin serta struktur gigi dan desisnya',
      xpReward: 25,
      questions: [
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'س',
          options: ['Sin', 'Syin', 'Sad'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ش',
          options: ['Syin', 'Sin', 'Tsa'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Sin!',
          options: ['س', 'ش', 'ث'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Syin!',
          options: ['ش', 'س', 'ت'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Apa perbedaan utama antara huruf Sin (س) dan Syin (ش)?',
          visualPrompt: 'س vs ش',
          options: [
            'Syin memiliki 3 titik di atas, Sin polos tanpa titik',
            'Sin memiliki titik di bawah',
            'Syin memiliki 1 titik di atas',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Berapa jumlah titik di atas huruf Syin?',
          visualPrompt: 'ش',
          options: ['Tiga titik', 'Dua titik', 'Satu titik'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah dari dua huruf di atas yang merupakan huruf Syin (memiliki gigi 3)?',
          visualPrompt: 'ش   ث',
          options: ['ش', 'ث'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan suara desis tersebut!',
          audioPath: 'sin.mp3',
          options: ['س', 'ش', 'ص'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan suara desis tebal tersebut!',
          audioPath: 'syin.mp3',
          options: ['ش', 'س', 'ث'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara yang tepat untuk huruf di atas?',
          visualPrompt: 'س',
          options: ['Suara Sin (sin.mp3)', 'Suara Syin (syin.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara yang tepat untuk huruf di atas?',
          visualPrompt: 'ش',
          options: ['Suara Syin (syin.mp3)', 'Suara Sin (sin.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dua huruf manakah yang SAMA-SAMA MEMILIKI 3 TITIK DI ATAS?',
          options: [
            'ث (Tsa) dan ش (Syin)',
            'ت (Ta) dan س (Sin)',
            'خ (Kho) dan ذ (Dzal)',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Syin!',
          options: ['ش', 'س', 'ز'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Sin!',
          options: ['س', 'ش', 'ر'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah Pasangan Huruf dan Nama yang TEPAT?',
          options: ['س = Sin', 'ش = Sin', 'س = Syin'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 7: Huruf Sad & Dhod (ص - ض)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 7,
      title: 'Level 7: Sad & Dhod',
      arabicSubtitle: 'ص - ض',
      description: 'Mengenal bentuk kepala bulat Sad dan Dhod serta makhraj tebalnya',
      xpReward: 25,
      questions: [
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ص',
          options: ['Sad', 'Dhod', 'Sin'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ض',
          options: ['Dhod', 'Sad', 'Dzal'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Sad!',
          options: ['ص', 'ض', 'س'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Dhod!',
          options: ['ض', 'ص', 'ش'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Apa perbedaan antara huruf Sad (ص) dan Dhod (ض)?',
          visualPrompt: 'ص vs ض',
          options: [
            'Dhod memiliki 1 titik di atas kepala, Sad polos tanpa titik',
            'Sad memiliki titik di bawah',
            'Dhod memiliki 3 titik di atas',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah dari dua huruf di atas yang merupakan huruf Sad (memiliki kepala bulat/mangkuk)?',
          visualPrompt: 'ص   س',
          options: ['ص', 'س'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Huruf Dhod (ض) memiliki berapa titik di atas kepalanya?',
          visualPrompt: 'ض   ش',
          options: ['Satu titik', 'Tiga titik', 'Dua titik'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan suara tebal tersebut!',
          audioPath: 'sad.mp3',
          options: ['ص', 'س', 'ض'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan suara berat/tebal tersebut!',
          audioPath: 'dhod.mp3',
          options: ['ض', 'د', 'ذ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara pelafalan tebal yang tepat untuk huruf di atas?',
          visualPrompt: 'ص',
          options: ['Suara Sad (sad.mp3)', 'Suara Sin (sin.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara yang tepat untuk huruf di atas?',
          visualPrompt: 'ض',
          options: ['Suara Dhod (dhod.mp3)', 'Suara Dal (dal.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di antara huruf-huruf berikut, manakah yang merupakan pasangan huruf Tebal (Sad & Dhod)?',
          options: ['ص dan ض', 'س dan ش', 'د dan ذ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Dhod!',
          options: ['ض', 'ص', 'ش'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Sad!',
          options: ['ص', 'س', 'ض'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah Pasangan Huruf dan Nama yang TEPAT?',
          options: ['ض = Dhod', 'ص = Dhod', 'ض = Sad'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 8: Check Point Mid-Unit (ا – ض)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 8,
      title: 'Level 8: Mid-Unit Checkpoint',
      arabicSubtitle: 'ا - ض',
      description: 'Evaluasi tengah unit: menguji ketelitian 15 huruf pertama',
      xpReward: 35,
      badgeLabel: 'MID CHECKPOINT',
      questions: [
        ExerciseQuestion(
          questionText: 'Manakah kelompok huruf yang memiliki ciri khas kepala bulat/mangkuk?',
          options: ['ص, ض', 'س, ش', 'ج, ح, خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Kelompok huruf mana yang memiliki bentuk dasar 3 gigi?',
          options: ['س, ش', 'ب, ت, ث', 'د, ذ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di antara dua huruf ber-titik 1 di atas, manakah yang merupakan huruf Zai (meluncur panjang)?',
          visualPrompt: 'ذ   ز',
          options: ['ز', 'ذ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Dhod!',
          options: ['ض', 'ص', 'ش'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Huruf-huruf berikut ini SEMUANYA MEMILIKI 1 TITIK DI ATAS, KECUALI...',
          options: ['ج (Jim)', 'خ (Kho)', 'ذ (Dzal)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dua huruf manakah dari 15 huruf pertama yang sama-sama memiliki 3 titik di atas?',
          options: [
            'ث (Tsa) dan ش (Syin)',
            'ت (Ta) dan س (Sin)',
            'ب (Ba) dan ض (Dhod)',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Huruf manakah di bawah ini yang POLOS TANPA TITIK?',
          options: [
            'ح (Ha), د (Dal), ر (Ro), س (Sin), ص (Sad)',
            'خ, ذ, ز, ش, ض',
            'ب, ت, ث, ج',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan pelafalan tebal berikut, manakah huruf yang sesuai?',
          audioPath: 'sad.mp3',
          options: ['ص', 'س', 'ش'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan pelafalan berat berikut, manakah huruf yang sesuai?',
          audioPath: 'dhod.mp3',
          options: ['ض', 'د', 'ذ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan suara desis berikut, pilih huruf yang tepat!',
          audioPath: 'zai.mp3',
          options: ['ز', 'ذ', 'ر'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih suara yang tepat untuk huruf di atas!',
          visualPrompt: 'ش',
          options: ['Suara Syin (syin.mp3)', 'Suara Sin (sin.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Sebutkan nama huruf di atas!',
          visualPrompt: 'ذ',
          options: ['Dzal', 'Dal', 'Zai'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Sebutkan nama huruf di atas!',
          visualPrompt: 'ص',
          options: ['Sad', 'Dhod', 'Sin'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Urutan huruf yang benar setelah س (Sin) dan ش (Syin) adalah...',
          options: ['ص lalu ض', 'د lalu ذ', 'ط lalu ظ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pasangan huruf dan nama mana yang SALAH?',
          options: ['ض = Sad', 'ذ = Dzal', 'ز = Zai'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 9: Huruf Tho, Zho, 'Ain, Ghoin (ط - ظ - ع - غ)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 9,
      title: 'Level 9: Tho, Zho, \'Ain, Ghoin',
      arabicSubtitle: 'ط - ظ - ع - غ',
      description: 'Mengenal bentuk mangkuk bertangkai dan paruh tenggorokan',
      xpReward: 25,
      questions: [
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ط',
          options: ['Tho', 'Zho', 'Dhod'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ظ',
          options: ['Zho', 'Tho', 'Zai'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ع',
          options: ['\'Ain', 'Ghoin', 'Hamzah'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Ghoin!',
          options: ['غ', 'ع', 'ظ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Apa perbedaan antara huruf Tho (ط) dan Zho (ظ)?',
          visualPrompt: 'ط vs ظ',
          options: [
            'Zho memiliki 1 titik di atas, Tho polos tanpa titik',
            'Tho memiliki titik di bawah',
            'Zho memiliki 2 titik',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Berapa jumlah titik di atas huruf Ghoin?',
          visualPrompt: 'غ',
          options: ['Satu titik di atas', 'Dua titik di atas', 'Tanpa titik'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di antara dua huruf di atas, manakah yang merupakan huruf \'Ain?',
          visualPrompt: 'ط   ع',
          options: ['ع', 'ط'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tebal tersebut!',
          audioPath: 'tho.mp3',
          options: ['ط', 'ظ', 'ت'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan suara tenggorokan tersebut!',
          audioPath: 'ain.mp3',
          options: ['ع', 'غ', 'ا'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'ghoin.mp3',
          options: ['غ', 'ع', 'خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara yang tepat untuk huruf di atas?',
          visualPrompt: 'ظ',
          options: ['Suara Zho (zho.mp3)', 'Suara Tho (tho.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Huruf manakah di bawah ini yang memiliki bentuk mangkuk bertangkai tegak?',
          options: ['ط dan ظ', 'ع dan غ', 'ص dan ض'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf \'Ain!',
          options: ['ع', 'غ', 'ح'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Zho!',
          options: ['ظ', 'ط', 'ض'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah pasangan huruf dan nama yang TEPAT?',
          options: ['غ = Ghoin', 'ع = Ghoin', 'ط = Zho'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 10: Huruf Fa, Qof, Kaf (ف - ق - ك)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 10,
      title: 'Level 10: Fa, Qof, Kaf',
      arabicSubtitle: 'ف - ق - ك',
      description: 'Mengenal huruf Fa, Qof, Kaf serta membedakan titik dan kedalamannya',
      xpReward: 25,
      questions: [
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ف',
          options: ['Fa', 'Qof', 'Kaf'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ق',
          options: ['Qof', 'Fa', 'Kaf'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ك',
          options: ['Kaf', 'Qof', 'Alif'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Qof!',
          options: ['ق', 'ف', 'ك'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Berapa jumlah titik pada huruf Qof (ق) dibanding huruf Fa (ف)?',
          visualPrompt: 'ف vs ق',
          options: [
            'Qof memiliki 2 titik di atas, Fa memiliki 1 titik di atas',
            'Qof memiliki 1 titik, Fa tidak ber-titik',
            'Kedua huruf memiliki jumlah titik yang sama',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Simbol apa yang terdapat di dalam badan huruf Kaf (ك)?',
          visualPrompt: 'ك',
          options: [
            'Simbol seperti S/Hamzah kecil',
            'Satu titik bulat',
            'Garis lurus',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah di antara dua huruf di atas yang bentuk badannya melengkung lebih dalam ke bawah garis?',
          visualPrompt: 'ف   ق',
          options: ['ق', 'ف'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio desis bibir tersebut!',
          audioPath: 'fa.mp3',
          options: ['ف', 'ق', 'ك'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan pelafalan tebal dari pangkal lidah tersebut!',
          audioPath: 'qof.mp3',
          options: ['ق', 'ك', 'ف'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan pelafalan ringan \'K\' tersebut!',
          audioPath: 'kaf.mp3',
          options: ['ك', 'ق', 'خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara tebal yang tepat untuk huruf di atas?',
          visualPrompt: 'ق',
          options: ['Suara Qof (qof.mp3)', 'Suara Kaf (kaf.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dua huruf manakah yang SAMA-SAMA MEMILIKI 2 TITIK DI ATAS?',
          options: [
            'ت (Ta) dan ق (Qof)',
            'ف (Fa) dan ن (Nun)',
            'ث (Tsa) dan ش (Syin)',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Fa!',
          options: ['ف', 'ق', 'ك'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Kaf!',
          options: ['ك', 'ق', 'ل'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah pasangan huruf dan nama yang TEPAT?',
          options: ['ق = Qof', 'ف = Qof', 'ك = Qof'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 11: Huruf Lam, Mim, Nun, Wawu (ل - م - ن - و)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 11,
      title: 'Level 11: Lam, Mim, Nun, Wawu',
      arabicSubtitle: 'ل - م - ن - و',
      description: 'Mengenal 4 huruf baru: mangkuk, bulatan dan kepala meluncur',
      xpReward: 25,
      questions: [
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ل',
          options: ['Lam', 'Alif', 'Kaf'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'م',
          options: ['Mim', 'Wawu', 'Ha'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ن',
          options: ['Nun', 'Ba', 'Zai'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Wawu!',
          options: ['و', 'م', 'ر'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Apa perbedaan bentuk antara huruf Alif (ا) dan Lam (ل)?',
          visualPrompt: 'ا vs ل',
          options: [
            'Lam memiliki cangkang/mangkuk lengkung di bawah, Alif lurus tegak',
            'Alif memiliki titik di atas',
            'Lam dan Alif bentuknya sama persis',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Apa perbedaan posisi titik antara huruf Nun (ن) dan Ba (ب)?',
          visualPrompt: 'ن vs ب',
          options: [
            'Nun titiknya di dalam/atas mangkuk, Ba titiknya di bawah perahu',
            'Nun tidak memiliki titik',
            'Ba titiknya di atas perahu',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Huruf manakah di atas yang memiliki kepala bulat sebelum meluncur miring?',
          visualPrompt: 'و   ر',
          options: ['و (Wawu)', 'ر (Ro)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'lam.mp3',
          options: ['ل', 'ا', 'ك'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio bibir rapat tersebut!',
          audioPath: 'mim.mp3',
          options: ['م', 'ن', 'و'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio dengung pangkal hidung tersebut!',
          audioPath: 'nun.mp3',
          options: ['ن', 'ب', 'م'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan audio di bawah, mana suara yang tepat untuk huruf di atas?',
          visualPrompt: 'و',
          options: ['Suara Wawu (wawu.mp3)', 'Suara Ro (ro.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah di antara huruf-huruf berikut yang MEMILIKI 1 TITIK DI DALAM/ATAS MANGKUK?',
          options: ['ن (Nun)', 'ب (Ba)', 'ج (Jim)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Mim!',
          options: ['م', 'و', 'ن'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Lam!',
          options: ['ل', 'ا', 'ك'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah pasangan huruf dan nama yang TEPAT?',
          options: ['و = Wawu', 'ن = Mim', 'م = Nun'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 12: Huruf Ha Besar, Hamzah, Ya (هـ - ء - ي)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 12,
      title: 'Level 12: Ha, Hamzah, Ya',
      arabicSubtitle: 'هـ - ء - ي',
      description: 'Mengenal 3 huruf terakhir hijaiyah dan anatomi titiknya',
      xpReward: 25,
      questions: [
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'هـ',
          options: ['Ha (Besar)', 'Ha (Bersih/ح)', '\'Ain'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ء',
          options: ['Hamzah', 'Alif', '\'Ain'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Ini adalah huruf...',
          visualPrompt: 'ي',
          options: ['Ya', 'Ba', 'Ta'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Ya!',
          options: ['ي', 'ب', 'ت'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Berapa jumlah dan posisi titik pada huruf Ya (ي)?',
          visualPrompt: 'ي',
          options: ['2 titik di bawah', '1 titik di bawah', '2 titik di atas'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Mana di antara huruf berikut yang merupakan Ha Besar (dada)?',
          visualPrompt: 'هـ vs ح',
          options: ['هـ', 'ح'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah yang merupakan huruf Hamzah yang berdiri sendiri?',
          visualPrompt: 'ء   ع',
          options: ['ء', 'ع'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio suara dalam/dada tersebut!',
          audioPath: 'ha_besar.mp3',
          options: ['هـ', 'ح', 'خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan pelafalan vokal tegas tersebut!',
          audioPath: 'hamzah.mp3',
          options: ['ء', 'ع', 'هـ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan audio tersebut!',
          audioPath: 'ya.mp3',
          options: ['ي', 'ب', 'ت'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih audio pelafalan bersih tenggorokan tengah yang tepat untuk huruf di atas!',
          visualPrompt: 'ح',
          options: ['Suara Ha Bersih (ha_bersih.mp3)', 'Suara Ha Besar (ha_besar.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Huruf manakah di bawah ini yang memiliki 2 TITIK DI BAWAH?',
          options: ['ي (Ya)', 'ت (Ta)', 'ق (Qof)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Hamzah!',
          options: ['ء', 'ع', 'ا'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Ha Besar!',
          options: ['هـ', 'ح', 'خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah Pasangan Huruf dan Nama yang TEPAT?',
          options: ['ي = Ya', 'هـ = Ha Clean', 'ء = \'Ain'],
          correctOptionIndex: 0,
        ),
      ],
    ),

    // =========================================================================
    // LEVEL 13: Boss Level Unit 1 (ا – ي)
    // =========================================================================
    const ExerciseLevel(
      levelNumber: 13,
      title: 'Level 13: Boss Level Unit 1',
      arabicSubtitle: 'ا - ي',
      description: 'Ujian pamungkas seluruh 28 huruf Hijaiyah sebelum lulus Unit 1',
      xpReward: 50,
      badgeLabel: 'BOSS LEVEL',
      questions: [
        ExerciseQuestion(
          questionText: 'Kelompok huruf mana yang memiliki ciri khas cetakan mangkuk bertangkai tegak?',
          options: ['ط, ظ', 'ب, ت, ث', 'س, ش'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Di antara huruf-huruf ber-kepala bulat di atas, manakah yang merupakan huruf Wawu (meluncur miring)?',
          visualPrompt: 'ف, ق, و',
          options: ['و', 'ف', 'ق'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Huruf manakah yang merupakan huruf Lam?',
          visualPrompt: 'ا   ل',
          options: ['ل', 'ا'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf Ya!',
          options: ['ي', 'ب', 'ت'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah pasangan huruf yang SAMA-SAMA MEMILIKI 3 TITIK DI ATAS?',
          options: [
            'ث (Tsa) dan ش (Syin)',
            'ت (Ta) dan ق (Qof)',
            'خ (Kho) dan ذ (Dzal)',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dua huruf manakah yang memiliki TITIK DI BAWAH?',
          options: [
            'ب (Ba - 1 titik) dan ي (Ya - 2 titik)',
            'ت (Ta) dan ث (Tsa)',
            'ج (Jim) dan خ (Kho)',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah di antara kelompok huruf berikut yang SEMUA HURUFNYA POLOS TANPA TITIK?',
          options: [
            'ا, ح, د, ر, س, ص, ط, ع, ك, ل, م, هـ',
            'ب, ت, ث, ج, خ, ذ, ز',
            'ش, ض, ظ, غ, ف, ق, ن',
          ],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan pelafalan bersih berikut, huruf manakah yang sesuai?',
          audioPath: 'ha_bersih.mp3',
          options: ['ح', 'هـ', 'خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Dengarkan pelafalan tebal berikut, manakah huruf yang tepat?',
          audioPath: 'qof.mp3',
          options: ['ق', 'ك', 'خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih huruf yang sesuai dengan pelafalan tenggorokan tersebut!',
          audioPath: 'ain.mp3',
          options: ['ع', 'غ', 'ء'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Pilih audio yang cocok untuk huruf tebal di atas!',
          visualPrompt: 'ض',
          options: ['Suara Dhod (dhod.mp3)', 'Suara Dal (dal.mp3)'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Hamzah!',
          options: ['ء', 'ع', 'ا'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Cari huruf Ghoin!',
          options: ['غ', 'ع', 'خ'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Urutan 3 huruf pertama dalam Hijaiyah adalah...',
          options: ['ا, ب, ت', 'ج, ح, خ', 'د, ذ, ر'],
          correctOptionIndex: 0,
        ),
        ExerciseQuestion(
          questionText: 'Manakah pasangan huruf dan nama yang TEPAT?',
          options: ['ش = Syin', 'ص = Sin', 'ط = Zho'],
          correctOptionIndex: 0,
        ),
      ],
    ),
  ];

  /// Mengambil level berdasarkan nomor level (1-indexed).
  static ExerciseLevel getLevel(int levelNumber) {
    if (levelNumber < 1 || levelNumber > levels.length) {
      return levels.first;
    }
    return levels[levelNumber - 1];
  }
}
