/// Booking model (from comfigurcao.html / tela-pagamento.html)
class Booking {
  final int destinationId;
  final String destinationName;
  final String dateRange;
  final int adults;
  final List<BookingUpgrade> upgrades;
  final int yarasUsed;
  final double totalPrice;

  const Booking({
    required this.destinationId,
    required this.destinationName,
    required this.dateRange,
    required this.adults,
    required this.upgrades,
    required this.yarasUsed,
    required this.totalPrice,
  });
}

class BookingUpgrade {
  final String name;
  final String icon;
  final double price;
  final bool isIncluded;
  final bool isEnabled;

  const BookingUpgrade({
    required this.name,
    required this.icon,
    required this.price,
    this.isIncluded = false,
    this.isEnabled = true,
  });
}
