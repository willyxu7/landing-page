
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/payment/data/models/payment_pricing.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../activity/data/models/requests/activity_request.dart';
import '../provider/pricing_provider.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pricing = context.watch<Pricing>();
    double discount = 0;
    bool isClosed = false;

    String title() {
      switch (pricing.name) {
        case '1x Listing':
          return 'Akses Panggilan Kerja';
        case '1x request':
          return 'Buat Panggilan Kerja';
        case '1x offer accepted':
          return 'Buat Penawaran Kerja';
        case 'Simpel':
        case 'Standard':
        case 'Basic':
          return 'Buat Lowongan Kerja';
        default:
          return pricing.name!;
      }
    }

    final rpDots = NumberFormat.simpleCurrency(
        locale: 'id', name: 'Rp. ', decimalDigits: 0);

    discount =
        (pricing.actualPrice!.toDouble() - pricing.offerPrice!.toDouble()) /
            pricing.actualPrice!.toDouble() *
            100;
    SizeConfig().init(context);

    _goToDetail() {
      // context.goNamed(
      //   'ticket-detail',
      //   queryParams: {
      //     'id': pricing.id!,
      //   },
      //   extra: {
      //     'pricing': pricing,
      //   },
      // );
      context.read<PricingProvider>().tempPricing = pricing;

      QR.to("/tickets/detail/?id=${pricing.id}");

      PostActivityUseCase.exec(ActivityRequest(
        type: ActivityTypeUtil.webViewTicketList,
        detail: pricing.id!,
        extra: ActivityExtraRequest(
            state: 'tap', screen: 'tickets screen', widget: 'ticket item'),
      ));
    }

    if (pricing.eventDetail?.endSaleDate != null &&
        pricing.eventDetail!.endSaleDate!.isBefore(DateTime.now())) {
      isClosed = true;
    }

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(width: 1, color: Colors.grey)),
      child: ListTile(
        onTap: _goToDetail,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pricing.eventDetail?.imageUrl != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          pricing.eventDetail!.imageUrl!,
                          height: ResponsiveWidget.isSmallScreen(context)
                              ? 80
                              : 200,
                          width: SizeConfig.screenWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(
                              ResponsiveWidget.isSmallScreen(context) ? 3 : 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red.withOpacity(0.8)),
                          child: Text(
                            pricing.category ?? 'Undefined',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 8),
            Text(
              title(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              pricing.offerPrice == 0
                  ? 'Gratis'
                  : rpDots.format(pricing.offerPrice),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            discount.toInt() != 0
                ? Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.green[100]),
                            child: Text(
                              '${discount.toInt().toString()}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: Colors.green),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            pricing.actualPrice == 0
                                ? 'Gratis'
                                : rpDots.format(pricing.actualPrice),
                            style:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: Colors.black54,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  )
                : const SizedBox(),
            Text(
              !isClosed
                  ? pricing.eventDetail?.startEventDate != null
                      ? DateFormat.yMMMMEEEEd('id')
                          .format(pricing.eventDetail!.startEventDate!)
                      : 'Undefined'
                  : 'Closed',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: Wrap(
                direction: ResponsiveWidget.isSmallScreen(context) ||
                        ResponsiveWidget.isMediumScreen(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    pricing.eventDetail?.isOnlineEvent != null &&
                            pricing.eventDetail!.isOnlineEvent!
                        ? 'Online Event'
                        : 'Offline Event',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  SizedBox(
                      height: ResponsiveWidget.isSmallScreen(context) ||
                              ResponsiveWidget.isMediumScreen(context)
                          ? 10
                          : 0),
                  InkWell(
                    onTap: _goToDetail,
                    child: Text(
                      'Selengkapnya',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // bottom: Container(
        //   padding: EdgeInsets.symmetric(vertical: 15),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       KDivider(),
        //       SizedBox(height: 10),
        //       PurchaseFeaturesScreen(pricing: pricing),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
