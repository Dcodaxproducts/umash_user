import 'package:umash_user/utils/images.dart';

class PaymentMethod {
  final String image;
  final String subtitle;
  final String value;
  final bool color;
  PaymentMethod({
    required this.image,
    required this.subtitle,
    required this.value,
    this.color = false,
  });
}

List<PaymentMethod> paymentMethodList = [
  PaymentMethod(
    image: Images.cod,
    subtitle: 'cash_on_delivery_subtitle',
    value: 'cash_on_delivery',
    color: true,
  ),
  PaymentMethod(
    image: Images.wallet,
    subtitle: 'wallet_payment_subtitle',
    value: 'wallet_payment',
    color: true,
  ),
];
