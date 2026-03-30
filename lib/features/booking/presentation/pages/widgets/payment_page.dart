import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_decorations.dart';
import '../../../../../shared/models/booking.dart';
import '../../../../../shared/widgets/premium_button.dart';

class PaymentPage extends StatefulWidget {
  final Booking booking;

  const PaymentPage({super.key, required this.booking});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _yarasToUse = 0;
  final int _yarasBalance = 1250; // Mock profile balance
  
  double get _discount => _yarasToUse * 0.10; // 0.10 MT per Yara
  double get _finalPrice => widget.booking.totalPrice - _discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('PAGAMENTO', style: AppTextStyles.micro),
            Text(widget.booking.destinationName, style: AppTextStyles.body),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumo Reserva
            Container(
              decoration: AppDecorations.premiumCard,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Resumo da Reserva', style: AppTextStyles.cardTitle),
                  const SizedBox(height: 16),
                  _buildSummaryRow('Datas', widget.booking.dateRange),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Hóspedes', '${widget.booking.adults} Adultos'),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider()),
                  Text('Upgrades Incluídos:', style: AppTextStyles.small),
                  const SizedBox(height: 8),
                  ...widget.booking.upgrades.map((u) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppColors.success, size: 16),
                        const SizedBox(width: 8),
                        Text(u.name, style: AppTextStyles.body),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Yaras Slider
            Container(
              decoration: AppDecorations.cofreGradient,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('USAR YARAS', style: AppTextStyles.micro.copyWith(color: AppColors.blue200)),
                      Text('Saldo: $_yarasBalance', style: AppTextStyles.micro.copyWith(color: AppColors.blue200)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('-$_yarasToUse', style: AppTextStyles.yarasBalance.copyWith(fontSize: 32)),
                      const SizedBox(width: 8),
                      Text('Yaras aplicadas', style: AppTextStyles.body.copyWith(color: AppColors.blue200)),
                    ],
                  ),
                  Text('Equivale a -${_discount.toStringAsFixed(0)} MT', style: AppTextStyles.small.copyWith(color: Colors.white)),
                  const SizedBox(height: 16),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.goldMid,
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.white,
                      overlayColor: AppColors.goldMid.withValues(alpha: 0.2),
                    ),
                    child: Slider(
                      value: _yarasToUse.toDouble(),
                      min: 0,
                      max: _yarasBalance.toDouble(),
                      divisions: 100,
                      onChanged: (val) {
                        setState(() {
                          _yarasToUse = val.toInt();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: AppTextStyles.body.copyWith(color: AppColors.slate500)),
                  Text('${widget.booking.totalPrice.toStringAsFixed(0)} MT', style: AppTextStyles.body),
                ],
              ),
              if (_yarasToUse > 0) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Desconto Yaras', style: AppTextStyles.body.copyWith(color: AppColors.success)),
                    Text('-${_discount.toStringAsFixed(0)} MT', style: AppTextStyles.body.copyWith(color: AppColors.success)),
                  ],
                ),
              ],
              const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Total a Pagar', style: AppTextStyles.cardTitle),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(_finalPrice.toStringAsFixed(0), style: AppTextStyles.priceLarge),
                      Text(' MT', style: AppTextStyles.body),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              PremiumButton(
                text: 'Pagar com M-Pesa',
                backgroundColor: AppColors.mpesaRed, // Needs to be added to AppColors
                icon: Icons.phone_android,
                onPressed: () {
                  // Navigate to success
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.body.copyWith(color: AppColors.slate500)),
        Text(value, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w800)),
      ],
    );
  }
}
