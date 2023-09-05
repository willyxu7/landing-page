import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/widgets/small_button.dart';
import 'package:kukerja_web/core/widgets/small_outline_button.dart';
import 'package:kukerja_web/env/kukerja_env.dart';
import 'package:kukerja_web/features/kukerja/payment/data/models/payment_charge.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/layout/payment_response.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/snap_provider.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class BillingResponseLayout extends StatefulWidget {
  final ChargeModel? notification;
  final String? code;

  const BillingResponseLayout({
    Key? key,
    required this.notification,
    required this.code,
  }) : super(key: key);

  @override
  State<BillingResponseLayout> createState() => _BillingResponseLayoutState();
}

class _BillingResponseLayoutState extends State<BillingResponseLayout> {
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
    switch (widget.notification!.itemDetails!.status) {
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
    switch (widget.notification?.itemDetails?.paymentType) {
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
    switch (widget.notification!.itemDetails!.status) {
      case PaymentStatus.settlement:
        return SmallButton(
          onPressed: () async {
            if (widget.code != null) {
              await context
                  .read<SnapChargeProvider>()
                  .getBillPdf(widget.code!)
                  .then((value) {
                Printing.sharePdf(
                  filename:
                      'Kukerja Invoice ${widget.notification?.employer?.name} at ${widget.notification?.itemDetails?.transactionTime}',
                  bytes: value,
                );
              });
            } else {
              print('no order id found!');
            }
          },
          text: 'Download Invoice',
        );
      default:
        return SmallButton(
          onPressed: () async {
            context
                .read<SnapChargeProvider>()
                .payBill(widget.code!)
                .then((value) {
              KukerjaEnv.launchPaymentSnap(value.url!);
            });
          },
          text: 'Invoice',
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
                    : Image.asset(
                        'assets/images/astronot/topup.png',
                        height: 210,
                        width: 210,
                        fit: BoxFit.contain,
                      ),
                Text(
                    _responStatus!.contains('Selesai')
                        ? _responStatus ?? 'Undefined'
                        : 'Invoice Detail',
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
                              'Nama Pelanggan',
                            ),
                          ),
                          const Text(
                            " : ",
                          ),
                          Expanded(
                            child: Text(
                              widget.notification?.employer?.name ??
                                  'Undefined',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            width: 140,
                            child: Text(
                              'Nama Layanan',
                            ),
                          ),
                          const Text(
                            " : ",
                          ),
                          Expanded(
                            child: Text(
                              widget.notification?.itemDetails?.plan != null
                                  ? widget.notification!.itemDetails!.plan!
                                          .toLowerCase()
                                          .contains('hired')
                                      ? 'Rekrutment Kukerja Elite'
                                      : widget.notification!.itemDetails!.plan!
                                  : '',
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
                              "Total Bayar",
                            ),
                          ),
                          const Text(
                            " : ",
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Rp. ${price.format(widget.notification?.itemDetails?.nominal ?? 0)}',
                            ),
                          ),
                        ],
                      ),
                      widget.notification?.orderId != null &&
                                  _paymentMethod != 'Admin' ||
                              _responStatus == 'Transaksi Selesai'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                        widget.notification?.itemDetails
                                                    ?.transactionTime !=
                                                null
                                            ? widget.notification!.itemDetails!
                                                .transactionTime!
                                                .substring(0, 16)
                                            : 'Undefined',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.notification?.orderId != null &&
                                  _responStatus != 'Transaksi Selesai'
                              ? Flexible(
                                  child: SmallOutlineButton(
                                    onPressed: () {
                                      html.window.location.reload();
                                    },
                                    text: 'Sudah Bayar',
                                    borderColor: Colors.green,
                                    primaryColor: Colors.green,
                                  ),
                                )
                              : Container(),
                          widget.notification?.orderId != null &&
                                  _responStatus != 'Transaksi Selesai'
                              ? const SizedBox(width: 30)
                              : Container(),
                          Flexible(child: _buttonConfirm()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
