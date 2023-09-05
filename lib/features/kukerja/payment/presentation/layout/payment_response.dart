import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/core/widgets/small_outline_button.dart';
import 'package:kukerja_web/features/kukerja/payment/data/models/payment_charge.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/snap_provider.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

import 'package:qlevar_router/qlevar_router.dart';

class PaymentStatus {
  static const pending = 'pending';
  static const capture = 'capture';
  static const settlement = 'settlement';
  static const deny = 'deny';
  static const cancel = 'cancel';
  static const expire = 'expire';
  static const failure = 'failure';
  static const authorize = 'authorize';
}

class PaymentResponse extends StatefulWidget {
  final ChargeNotificationModel? notification;
  final String? orderId;

  const PaymentResponse({
    Key? key,
    required this.notification,
    required this.orderId,
  }) : super(key: key);

  @override
  State<PaymentResponse> createState() => _PaymentResponseState();
}

class _PaymentResponseState extends State<PaymentResponse> {
  String? _responStatus;
  String? _paymentMethod;
  Uint8List? _memoryPdf;

  @override
  void initState() {
    super.initState();

    _initPaymentRespon();
    _initPaymentType();
  }

  _initPaymentRespon() {
    switch (widget.notification!.status) {
      case PaymentStatus.settlement:
      case PaymentStatus.capture:
        _responStatus = 'Transaksi Selesai';
        break;
      case PaymentStatus.pending:
        _responStatus = 'Transaksi Pending';
        break;
      case PaymentStatus.cancel:
        _responStatus = 'Transaksi Batal';
        break;
      case PaymentStatus.expire:
        _responStatus = 'Transaksi Kadaluarsa';
        break;
      case PaymentStatus.failure:
        _responStatus = 'Transaksi Gagal';
        break;
      case PaymentStatus.deny:
        _responStatus = 'Transaksi Ditolak';
        break;
      default:
        _responStatus = 'Transaksi Pending';
    }
  }

  _initPaymentType() {
    switch (widget.notification?.paymentType) {
      case 'credit_card':
        _paymentMethod = 'Kartu Kredit';
        break;
      case 'gopay':
        _paymentMethod = 'Gopay';
        break;
      case 'qris':
        _paymentMethod = 'QRIS';
        break;
      case 'shopeepay':
        _paymentMethod = 'ShopeePay';
        break;
      case 'bank_transfer':
        _paymentMethod = 'Bank Transfer';
        break;
      case 'echannel':
        _paymentMethod = 'Mandiri Bill';
        break;
      case 'bca_klikpay':
        _paymentMethod = 'BCA Klikpay';
        break;
      case 'bca_klikbca':
        _paymentMethod = 'KlikBCA';
        break;
      case 'cimb_clicks':
        _paymentMethod = 'CIMB Clicks';
        break;
      case 'danamon_online':
        _paymentMethod = 'Danamon Online Banking';
        break;
      case 'akulaku':
        _paymentMethod = 'Akulaku';
        break;
      case 'bri_epay':
        _paymentMethod = 'BRImo';
        break;
      case 'cstore':
        _paymentMethod = 'Convenience Store';
        break;
      case 'cash':
        _paymentMethod = 'Admin';
        break;
    }
  }

  Widget _buttonConfirm() {
    switch (widget.notification!.status) {
      case PaymentStatus.settlement:
        return SmallButton(
          onPressed: () async {
            if (widget.orderId != null) {
              await context
                  .read<SnapChargeProvider>()
                  .getTicketPdf(widget.orderId!)
                  .then((value) {
                Printing.sharePdf(
                  filename:
                      'Ticket ${widget.notification?.plan} at ${DateFormat.yMMMEd().format(DateTime.now().toLocal())}',
                  bytes: value,
                );
              });
            } else {
              print('no order id found!');
            }
          },
          text: 'Download Tiket',
        );
      default:
        return SmallButton(
          onPressed: () async {
            html.window.location.reload();
          },
          text: 'Cek Pembayaran',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final price = NumberFormat.decimalPattern();
    return _memoryPdf == null
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _responStatus!.contains('Selesai')
                    ? Image.asset(
                        'assets/images/astronot/payment_success.png',
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                      )
                    : Container(),
                Text(_responStatus ?? 'Undefined',
                    style: Theme.of(context).textTheme.headlineMedium),

                // Column(
                //   children: [
                //     const SizedBox(
                //       height: 20,
                //     ),
                //     Text(
                //       'Pembayaran berhasil!\nAnda dapat mengecek tiket di alamat email.',
                //       textAlign: TextAlign.center,
                //       style: Theme.of(context).textTheme.bodyMedium,
                //     ),
                //     const SizedBox(
                //       height: 40,
                //     ),
                //   ],
                // ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey.shade300,
                  )),
                  padding: const EdgeInsets.all(20),
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            width: 140,
                            child: Text(
                              'Nama Item',
                            ),
                          ),
                          const Text(
                            " : ",
                          ),
                          Expanded(
                            child: Text(
                              widget.notification?.plan ?? 'Undefined',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            width: 140,
                            child: Text(
                              "Nominal",
                            ),
                          ),
                          const Text(
                            " : ",
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Rp. ${price.format(widget.notification?.nominal ?? 0)}',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            width: 140,
                            child: Text(
                              'Metode Pembayaran',
                            ),
                          ),
                          const Text(
                            " : ",
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              _paymentMethod ??
                                  widget.notification?.paymentType ??
                                  'Undefined',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            width: 140,
                            child: Text(
                              'Waktu Transaksi',
                            ),
                          ),
                          const Text(
                            " : ",
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              widget.notification!.transactionTime != null
                                  ? widget.notification!.transactionTime!
                                      .substring(0, 16)
                                  : 'Undefined',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallOutlineButton(
                      onPressed: () {
                        QR.to('/');
                      },
                      text: 'Kembali',
                      borderColor: Colors.green,
                      primaryColor: Colors.green,
                    ),
                    const SizedBox(width: 30),
                    _buttonConfirm(),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }
}
