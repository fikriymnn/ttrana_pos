class Product {
  int? id;
  String? judulProduk;
  String? deskripsiProduk;
  String? fotoProduk;
  int? harga;
  int? jumlahProduk;
  String? kategoriProduk;
  int? ratingProduk;
  String? createdAt;
  String? updatedAt;
  List<Variasis>? variasis;

  Product(
      {this.id,
      this.judulProduk,
      this.deskripsiProduk,
      this.fotoProduk,
      this.harga,
      this.jumlahProduk,
      this.kategoriProduk,
      this.ratingProduk,
      this.createdAt,
      this.updatedAt,
      this.variasis});

      Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judulProduk = json['judul_produk'];
    deskripsiProduk = json['deskripsi_produk'];
    fotoProduk = json['foto_produk'];
    harga = json['harga'];
    jumlahProduk = json['jumlahProduk'];
    kategoriProduk = json['kategori_produk'];
    ratingProduk = json['ratingProduk'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['variasis'] != null) {
      variasis = <Variasis>[];
      json['variasis'].forEach((v) {
        variasis!.add(new Variasis.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul_produk'] = this.judulProduk;
    data['deskripsi_produk'] = this.deskripsiProduk;
    data['foto_produk'] = this.fotoProduk;
    data['harga'] = this.harga;
    data['jumlahProduk'] = this.jumlahProduk;
    data['kategori_produk'] = this.kategoriProduk;
    data['ratingProduk'] = this.ratingProduk;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.variasis != null) {
      data['variasis'] = this.variasis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variasis {
  int? id;
  int? idProduk;
  String? fotoVariasi;
  String? namaVariasi;
  String? createdAt;
  String? updatedAt;
  List<Subvariasis>? subvariasis;

  Variasis(
      {this.id,
      this.idProduk,
      this.fotoVariasi,
      this.namaVariasi,
      this.createdAt,
      this.updatedAt,
      this.subvariasis});

  Variasis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduk = json['id_produk'];
    fotoVariasi = json['foto_variasi'];
    namaVariasi = json['nama_variasi'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['subvariasis'] != null) {
      subvariasis = <Subvariasis>[];
      json['subvariasis'].forEach((v) {
        subvariasis!.add(new Subvariasis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_produk'] = this.idProduk;
    data['foto_variasi'] = this.fotoVariasi;
    data['nama_variasi'] = this.namaVariasi;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.subvariasis != null) {
      data['subvariasis'] = this.subvariasis!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subvariasis {
  int? id;
  int? idProduk;
  int? idVariasi;
  String? fotoVariasi;
  String? namaSubVariasi;
  int? stok;
  String? usia;
  int? harga;
  String? createdAt;
  String? updatedAt;

  Subvariasis(
      {this.id,
      this.idProduk,
      this.idVariasi,
      this.fotoVariasi,
      this.namaSubVariasi,
      this.stok,
      this.usia,
      this.harga,
      this.createdAt,
      this.updatedAt});

  Subvariasis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduk = json['id_produk'];
    idVariasi = json['id_variasi'];
    fotoVariasi = json['foto_variasi'];
    namaSubVariasi = json['nama_sub_variasi'];
    stok = json['stok'];
    usia = json['usia'];
    harga = json['harga'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_produk'] = this.idProduk;
    data['id_variasi'] = this.idVariasi;
    data['foto_variasi'] = this.fotoVariasi;
    data['nama_sub_variasi'] = this.namaSubVariasi;
    data['stok'] = this.stok;
    data['usia'] = this.usia;
    data['harga'] = this.harga;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}



// class Product {
//   final int? id;
//   final String judulProduk;
//   final String deskripsiProduk;
//   final String? fotoProduk;
//   final int? harga;
//   final int? jumlah;
//   final String kategoriProduk;

//   Product({
//     this.id,
//     required this.judulProduk,
//     required this.deskripsiProduk,
//     this.fotoProduk,
//     this.harga,
//     this.jumlah,
//     required this.kategoriProduk,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'] as int?,
//       judulProduk: json['judul_produk'] ?? 'Tanpa Judul',
//       deskripsiProduk: json['deskripsi_produk'] ?? '',
//       fotoProduk: json['foto_produk'],
//       harga: json['harga'] ?? 0,
//       jumlah: json['jumlah'] ?? 1,
//       kategoriProduk: json['kategori_produk'] ?? 'Tanpa Kategori',
//     );
//   }
// }
