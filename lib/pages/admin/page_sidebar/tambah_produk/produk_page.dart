class SubVariasi {
  String namaSubVariasi;
  String usia;
  int stok;
  double harga;

  SubVariasi({
    required this.namaSubVariasi,
    required this.usia,
    required this.stok,
    required this.harga,
  });

  Map<String, dynamic> toJson() => {
        'nama_sub_variasi': namaSubVariasi,
        'usia': usia,
        'stok': stok,
        'harga': harga,
      };
}

class Variasi {
  String namaVariasi;
  List<SubVariasi> subVariasi;

  Variasi({
    required this.namaVariasi,
    required this.subVariasi,
  });

  Map<String, dynamic> toJson() => {
        'nama_variasi': namaVariasi,
        'sub_variasi': subVariasi.map((e) => e.toJson()).toList(),
      };
}

class Produk {
  String judulProduk;
  String deskripsi;
  String pilihKategori;
  double harga;
  String fotoGambar;
  List<Variasi> variasi;

  Produk({
    required this.judulProduk,
    required this.deskripsi,
    required this.pilihKategori,
    required this.harga,
    required this.fotoGambar,
    required this.variasi,
  });

  Map<String, dynamic> toJson() => {
        'judul_produk': judulProduk,
        'deskripsi_produk': deskripsi,
        'kategori_produk': pilihKategori,
        'harga': harga,
        'foto_produk': fotoGambar,
        'variasi': variasi.map((e) => e.toJson()).toList(),
      };
}
