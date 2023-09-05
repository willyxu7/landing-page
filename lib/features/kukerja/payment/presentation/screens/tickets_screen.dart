import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/nav_bar.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/payment/data/models/payment_pricing.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/layout/ticket_item.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/pricing_provider.dart';
import 'package:provider/provider.dart';

import '../../../activity/data/models/requests/activity_request.dart';

class TicketsScreen extends StatefulWidget {
  static const route = '/tickets';
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  _TicketsScreenState createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late Future<List<Pricing>?> _listPricingFuture;

  @override
  void initState() {
    super.initState();

    _listPricingFuture = context.read<PricingProvider>().getPricings();
    PostActivityUseCase.exec(ActivityRequest(
        type: ActivityTypeUtil.webViewTicketList,
        extra: ActivityExtraRequest(widget: 'tickets screen')));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: const NavBar(),
      drawer: const NavBarDrawer(),
      body: FutureBuilder(
        future: _listPricingFuture,
        builder: (context, AsyncSnapshot<List<Pricing>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 2 : 3,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: ResponsiveWidget.isSmallScreen(context)
                    ? 0.56
                    : ResponsiveWidget.isMediumScreen(context)
                        ? 0.6
                        : 1.2,
              ),
              padding: const EdgeInsets.all(20),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: snapshot.data![index], child: const TicketItem());
              },
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasData) {
            return Container();
          } else if (snapshot.hasError) {
            throw snapshot.error.toString();
            // return dataError(context);
          }
          return Container();
        },
      ),
    );
  }
}
