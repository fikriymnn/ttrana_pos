class Product {
  final int id;
  final String judulProduk;
  final String deskripsiProduk;
  final String? fotoProduk;
  final int harga;
  final int jumlah;
  final String kategoriProduk;

  Product({
    required this.id,
    required this.judulProduk,
    required this.deskripsiProduk,
    this.fotoProduk,
    required this.harga,
    required this.jumlah,
    required this.kategoriProduk,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      judulProduk: json['judul_produk'],
      deskripsiProduk: json['deskripsi_produk'],
      fotoProduk: json['foto_produk'],
      harga: json['harga'],
      jumlah: json['jumlah'],
      kategoriProduk: json['kategori_produk'],
    );
  }
}
