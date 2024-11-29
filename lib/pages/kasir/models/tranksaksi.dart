class ProdukTransaksi {
  final int idProduk;
  final int idSubVariasi;
  final int jumlah;
  final double harga; // Menambahkan harga produk

  ProdukTransaksi({
    required this.idProduk,
    required this.idSubVariasi,
    required this.jumlah,
    required this.harga, // Menambahkan harga produk
  });

  Map<String, dynamic> toJson() {
    return {
      'id_produk': idProduk,
      'id_subvariasi': idSubVariasi,
      'jumlah': jumlah,
      'harga': harga, // Menyertakan harga dalam data produk
    };
  }
}

class TransaksiRequest {
  final List<ProdukTransaksi> produk;
  final String metodeTransaksi;
  final String metodePembayaran;

  TransaksiRequest({
    required this.produk,
    required this.metodeTransaksi,
    required this.metodePembayaran,
  });

  Map<String, dynamic> toJson() {
    return {
      'produk': produk.map((e) => e.toJson()).toList(),
      'metode_transaksi': metodeTransaksi,
      'metode_pembayaran': metodePembayaran,
      'total_amount': calculateTotalAmount(), // Menghitung total amount
    };
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    for (var item in produk) {
      totalAmount += item.harga *
          item.jumlah; // Menghitung total berdasarkan harga dan jumlah
    }
    return totalAmount + 2500; // Menambahkan biaya layanan
  }
}
