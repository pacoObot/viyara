import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../shared/models/destination.dart';


class MapExplorerPage extends StatefulWidget {
  const MapExplorerPage({super.key});

  @override
  State<MapExplorerPage> createState() => _MapExplorerPageState();
}

class _MapExplorerPageState extends State<MapExplorerPage> {
  final MapController _mapController = MapController();
  final List<Destination> _destinations = Destination.sampleDestinations;
  Destination? _selectedDestination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('EXPLORAR NO MAPA', style: AppTextStyles.micro),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.viyaraBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(-21.5, 35.5), // Near Bazaruto, Mozambique
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.viyara.app',
                tileBuilder: (context, tileWidget, tile) {
                  return ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      -0.2126, -0.7152, -0.0722, 0, 255,
                      -0.2126, -0.7152, -0.0722, 0, 255,
                      -0.2126, -0.7152, -0.0722, 0, 255,
                      0, 0, 0, 1, 0,
                    ]), // Grayscale/Dark-ish map for premium feel
                    child: tileWidget,
                  );
                },
              ),
              MarkerLayer(
                markers: _destinations.map((dest) {
                  final bool isSelected = _selectedDestination?.id == dest.id;
                  return Marker(
                    point: const LatLng(-21.5, 35.5), // Mock coords, would come from DB
                    width: 60,
                    height: 60,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDestination = dest),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.viyaraBlue : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.viyaraBlue, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: isSelected ? Colors.white : AppColors.viyaraBlue,
                          size: 30,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          if (_selectedDestination != null)
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    setState(() => _selectedDestination = null);
                  }
                },
                child: Hero(
                  tag: 'map_dest_${_selectedDestination!.id}',
                  child: Container(
                    decoration: AppDecorations.premiumCard,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            _selectedDestination!.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedDestination!.name,
                                style: AppTextStyles.cardTitle,
                              ),
                              Text(
                                _selectedDestination!.location,
                                style: AppTextStyles.small,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${_selectedDestination!.price} MT',
                                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w900),
                                  ),
                                  const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.blue500),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
