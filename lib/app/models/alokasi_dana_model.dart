class AlokasiDanaModel {
  final String id;
  final String nama;
  final int alokasi;
  final int pengeluaran;
  final bool prioritas;

  AlokasiDanaModel({
    required this.id,
    required this.nama,
    required this.alokasi,
    required this.pengeluaran,
    required this.prioritas,
  });

  // 🔥 Tambahkan ini:
  factory AlokasiDanaModel.fromJson(Map<String, dynamic> json, String id) {
    return AlokasiDanaModel(
      id: id,
      nama: json['nama'] ?? '',
      alokasi: json['alokasi'] ?? 0,
      pengeluaran: json['pengeluaran'] ?? 0,
      prioritas: json['prioritas'] ?? false,
    );
  }

  // 🔁 Tambahkan ini kalau kamu ingin menyimpan kembali ke Firestore
  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'alokasi': alokasi,
      'pengeluaran': pengeluaran,
      'prioritas': prioritas,
    };
  }
}
