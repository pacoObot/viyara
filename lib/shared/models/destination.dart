/// Destination model mapped from Supabase database
class Destination {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final String price;
  final String rating;
  final String tag;
  final bool isFavorite;

  const Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.tag,
    this.isFavorite = false,
  });

  Destination copyWith({bool? isFavorite}) {
    return Destination(
      id: id,
      name: name,
      location: location,
      imageUrl: imageUrl,
      price: price,
      rating: rating,
      tag: tag,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      tag: json['tag'] as String,
      price: json['price'] as String,
      rating: json['rating'] as String,
      imageUrl: json['image_url'] as String,
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'tag': tag,
      'price': price,
      'rating': rating,
      'image_url': imageUrl,
      'is_favorite': isFavorite,
    };
  }

  /// Sample data for UI prototyping
  static const List<Destination> sampleDestinations = [
    Destination(
      id: '1',
      name: 'Santorini Moçambique',
      location: 'Vilanculos',
      imageUrl:
          'https://images.unsplash.com/photo-1540206351-d6465b3ac5c1?q=80&w=800&auto=format&fit=crop',
      price: '45.000',
      rating: '4.9',
      tag: 'Ultra Luxury',
    ),
    Destination(
      id: '2',
      name: 'Anantara Bazaruto',
      location: 'Ilha de Bazaruto',
      imageUrl:
          'https://images.unsplash.com/photo-1583037189850-1921ae7c6c22?q=80&w=800&auto=format&fit=crop',
      price: '32.500',
      rating: '4.8',
      tag: 'Exclusive',
    ),
    Destination(
      id: '3',
      name: 'Machangulo Beach',
      location: 'Santa Maria',
      imageUrl:
          'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?q=80&w=800&auto=format&fit=crop',
      price: '18.900',
      rating: '4.7',
      tag: 'Nature',
    ),
  ];
}
