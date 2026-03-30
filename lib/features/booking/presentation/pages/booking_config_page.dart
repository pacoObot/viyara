import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../shared/models/destination.dart';
import '../../../../shared/models/booking.dart';
import '../../../../shared/widgets/premium_button.dart';
import 'widgets/payment_page.dart';

class BookingConfigPage extends StatefulWidget {
  final Destination destination;

  const BookingConfigPage({super.key, required this.destination});

  @override
  State<BookingConfigPage> createState() => _BookingConfigPageState();
}

class _BookingConfigPageState extends State<BookingConfigPage> {
  int _adults = 2;
  int _children = 0;

  final List<BookingUpgrade> _upgrades = [
    const BookingUpgrade(name: 'Transfer de Helicóptero', icon: 'flight_takeoff', price: 15000),
    const BookingUpgrade(name: 'Chef Privado 24h', icon: 'restaurant_menu', price: 8500),
    const BookingUpgrade(name: 'Mergulho Exclusivo', icon: 'scuba_diving', price: 5000),
  ];

  final Set<int> _selectedUpgrades = {1}; // Pre-select Chef

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('CONFIGURAR RESERVA', style: AppTextStyles.micro),
            Text(widget.destination.name, style: AppTextStyles.body),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Selection
            Text('Quando viajas?', style: AppTextStyles.cardTitle),
            const SizedBox(height: 16),
            Container(
              decoration: AppDecorations.premiumCard,
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Check-in', style: AppTextStyles.small),
                        const SizedBox(height: 4),
                        Text('15 Nov', style: AppTextStyles.body.copyWith(fontSize: 18, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.blue50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_forward, color: AppColors.blue600),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Check-out', style: AppTextStyles.small),
                        const SizedBox(height: 4),
                        Text('22 Nov', style: AppTextStyles.body.copyWith(fontSize: 18, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Guests Selection
            Text('Quem vai?', style: AppTextStyles.cardTitle),
            const SizedBox(height: 16),
            Container(
              decoration: AppDecorations.premiumCard,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildGuestCounter('Adultos', '12+ anos', _adults, (val) => setState(() => _adults = val), 1),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider()),
                  _buildGuestCounter('Crianças', '2-12 anos', _children, (val) => setState(() => _children = val), 0),
                ],
              ),
            ),

            const SizedBox(height: 32),
            
            // Upgrades
            Text('Eleva a Experiência', style: AppTextStyles.cardTitle),
            const SizedBox(height: 16),
            ...List.generate(_upgrades.length, (idx) {
              final up = _upgrades[idx];
              final isSelected = _selectedUpgrades.contains(idx);
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.blue50 : AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: isSelected ? AppColors.blue400 : AppColors.slate200),
                ),
                child: SwitchListTile(
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      if (val) {
                        _selectedUpgrades.add(idx);
                      } else {
                        _selectedUpgrades.remove(idx);
                      }
                    });
                  },
                  title: Text(up.name, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w800)),
                  subtitle: Text('+ ${up.price} MT / estadia', style: AppTextStyles.small.copyWith(color: AppColors.blue600)),
                  activeThumbColor: AppColors.blue600,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
              );
            }),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 40,
              offset: Offset(0, -10),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Estimado', style: AppTextStyles.micro),
                  Text('87.500 MT', style: AppTextStyles.price),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: PremiumButton(
                    text: 'Rever e Pagar',
                    onPressed: () {
                      final b = Booking(
                        destinationId: widget.destination.id,
                        destinationName: widget.destination.name,
                        dateRange: '15 Nov - 22 Nov',
                        adults: _adults,
                        upgrades: _selectedUpgrades.map((i) => _upgrades[i]).toList(),
                        yarasUsed: 0,
                        totalPrice: 87500,
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentPage(booking: b)));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuestCounter(String title, String subtitle, int value, ValueChanged<int> onChanged, int min) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w800)),
            Text(subtitle, style: AppTextStyles.small),
          ],
        ),
        Row(
          children: [
            _CounterBtn(
              icon: Icons.remove,
              onPressed: value > min ? () => onChanged(value - 1) : null,
            ),
            SizedBox(
              width: 40,
              child: Center(
                child: Text('$value', style: AppTextStyles.body.copyWith(fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ),
            _CounterBtn(
              icon: Icons.add,
              onPressed: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }
}

class _CounterBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _CounterBtn({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: onPressed != null ? AppColors.blue50 : AppColors.slate100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: onPressed != null ? AppColors.blue600 : AppColors.slate300, size: 20),
      ),
    );
  }
}
