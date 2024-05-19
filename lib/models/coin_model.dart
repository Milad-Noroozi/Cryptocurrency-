// ignore_for_file: file_names

class Coin {
  final String id;
  final String name;
  final String symbol;
  final String image; // Can be a String URL or int depending on API response
  final num currentPrice;
  final num pricechange24h;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.pricechange24h,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      image: json['image'], // Might be String URL or int depending on API
      currentPrice: json['current_price'] as num,
      pricechange24h: json['price_change_24h'] as num,
    );
  }
}
