import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kukerja_web/core/config/responsive.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/utils/activity_type_util.dart';
import 'package:kukerja_web/core/widgets/app_loading_widget.dart';
import 'package:kukerja_web/core/widgets/nav_bar.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';
import 'package:kukerja_web/env/kukerja_env.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/domain/usecases/post_activity_use_case.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/widgets/footer/footer.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/pricing_provider.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/widgets/show_buyer_form_detail.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/snap_provider.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import '../../data/models/payment_pricing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pod_player/pod_player.dart';

class TicketDetail extends StatefulWidget {
  static const route = '/detail';

  @Deprecated("used for GoRouter")
  final bool isOntap;

  const TicketDetail({Key? key, this.isOntap = false}) : super(key: key);

  @override
  State<TicketDetail> createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  Pricing? pricing;
  bool _isOnTap = false, _isLoading = false, _isPlay = false, _isClosed = false;
  double discount = 0;
  int _incrementOfferPrice = 0;
  int _incrementActualPrice = 0;
  final TextEditingController _totalItemController =
      TextEditingController(text: '1');
  PodPlayerController? _videoController;

  final String _id = QR.params["id"].toString();
  final String extra = QR.params["extra"].toString();

  @override
  void initState() {
    super.initState();

    _checkProviderInQueryParams();

    if (_isOnTap){
      _initValue();
    }
    _fetchDetail();
  }

  @override
  void dispose() {
    super.dispose();

    _videoController?.dispose();
  }

  void _checkProviderInQueryParams() {
    Pricing? localPricing = context.read<PricingProvider>().tempPricing;
    if(localPricing != null) {
      _isOnTap = true;
      pricing = localPricing;
    }
  }

  void _postActivity(type, state) {
    PostActivityUseCase.exec(ActivityRequest(
        type: type,
        detail: pricing!.id,
        extra: ActivityExtraRequest(state: state, screen: 'ticket detail')));
  }

  void _initValue() {
    _checkEvent();
    _postActivity(ActivityTypeUtil.webTicketDetail, 'view');
    _initVideo();
  }

  Future<void> _fetchDetail() async {
    if (pricing == null) {
      setState(() {
        _isLoading = true;
      });
      await context
          .read<PricingProvider>()
          .getPricingDetail(_id)
          .catchError((error) {
        _isLoading = false;
        throw error;
      }).then((value) {
        setState(() {
          pricing = value;
          _isLoading = false;
        });
        _initValue();
      });
    }
  }

  _showForm() {
    if (_totalItemController.text != '' &&
        int.parse(_totalItemController.text) >= 1) {
      showBuyerDetailForm(
        context,
        quantity: int.parse(_totalItemController.text),
        paymentMethod: () async {
          final response = await context
              .read<SnapChargeProvider>()
              .charge(Uri.base.queryParameters['id']!);

          if (response!.url != null) {
            KukerjaEnv.launchPaymentSnap(response.url!);
          }
        },
      );
    } else {
      print('Error no items count');
    }
  }

  Future<void> _initVideo() async {
    if (pricing?.eventDetail?.videoUrl != null) {
      if (pricing!.eventDetail!.videoUrl!.contains('youtu.be') ||
          pricing!.eventDetail!.videoUrl!.contains('youtube')) {
        _videoController = PodPlayerController(
          playVideoFrom: PlayVideoFrom.youtube(pricing!.eventDetail!.videoUrl!),
          podPlayerConfig: const PodPlayerConfig(autoPlay: false),
        );
      } else {
        _videoController = PodPlayerController(
          playVideoFrom: PlayVideoFrom.network(pricing!.eventDetail!.videoUrl!),
          podPlayerConfig: const PodPlayerConfig(autoPlay: false),
        );
      }

      await _videoController?.initialise();

      _videoController?.addListener(() {
        if (_videoController!.isVideoPlaying) {
          if (!_isPlay) {
            setState(() {
              _isPlay = true;
            });
            _postActivity(ActivityTypeUtil.webPlayTicketVideo, 'play');
          }
        }
      });
    }

    setState(() {});
  }

  _checkEvent() {
    if (pricing?.eventDetail?.endSaleDate != null &&
        pricing!.eventDetail!.endSaleDate!.isBefore(DateTime.now())) {
      _isClosed = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final rpDots = NumberFormat.simpleCurrency(
        locale: 'id', name: 'Rp. ', decimalDigits: 0);

    if (pricing != null && discount == 0 ||
        pricing != null && _incrementOfferPrice == 0 ||
        pricing != null && _incrementActualPrice == 0) {
      discount =
          (pricing!.actualPrice!.toDouble() - pricing!.offerPrice!.toDouble()) /
              pricing!.actualPrice!.toDouble() *
              100;
      _incrementOfferPrice = pricing!.offerPrice!;
      _incrementActualPrice = pricing!.actualPrice!;
    }

    return _isLoading && pricing == null
        ? const AppLoadingWidget()
        : Scaffold(
            appBar: const NavBar(),
            drawer: const NavBarDrawer(),
            backgroundColor: Colors.white,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              padding: const EdgeInsets.all(20),
              width: SizeConfig.screenWidth,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12),
              ),
              child: Wrap(
                direction: Axis.vertical,
                runAlignment: WrapAlignment.spaceBetween,
                children: [
                  !ResponsiveWidget.isSmallScreen(context)
                      ? InkWell(
                          onTap: () async {
                            await Share.shareWithResult(
                              pricing!.name!,
                              subject: pricing!.eventDetail!.description!,
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.share_outlined,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Share',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(rpDots.format(_incrementOfferPrice),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          discount.toInt() != 0
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
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
                                          pricing?.actualPrice == 0
                                              ? 'Gratis'
                                              : rpDots.format(
                                                  _incrementActualPrice),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.copyWith(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ButtonTheme(
                            height: 50,
                            minWidth: 150,
                            buttonColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            child: RaisedButton(
                              onPressed: !_isClosed
                                  ? () {
                                      _showForm();

                                      PostActivityUseCase.exec(ActivityRequest(
                                          type: ActivityTypeUtil.webBuyTicket,
                                          detail: pricing!.id,
                                          extra: ActivityExtraRequest(
                                              state: 'tap',
                                              widget: 'floating button',
                                              screen: 'ticket detail')));
                                    }
                                  : null,
                              child: Text(
                                'Beli',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.black54)),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    int decrement =
                                        int.parse(_totalItemController.text);
                                    if (decrement > 1) {
                                      decrement--;
                                      setState(() {
                                        _incrementOfferPrice =
                                            _incrementOfferPrice -
                                                pricing!.offerPrice!;
                                        _incrementActualPrice =
                                            _incrementActualPrice -
                                                pricing!.actualPrice!;
                                      });
                                    }
                                    _totalItemController.text =
                                        decrement.toString();
                                  },
                                  child: const Icon(Icons.remove,
                                      size: 20, color: Colors.black54),
                                ),
                                Container(
                                  width: 40,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    controller: _totalItemController,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration.collapsed(
                                      hintText: '',
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    maxLines: 1,
                                    onChanged: (value) {
                                      int increment = int.parse(value);
                                      setState(() {
                                        _incrementOfferPrice =
                                            pricing!.offerPrice! * increment;
                                        _incrementActualPrice =
                                            pricing!.actualPrice! * increment;
                                      });
                                    },
                                  ),
                                ),
                                InkWell(
                                  child: const Icon(Icons.add,
                                      size: 20, color: Colors.black54),
                                  onTap: () {
                                    int increment =
                                        int.parse(_totalItemController.text);
                                    increment++;
                                    setState(() {
                                      _incrementOfferPrice =
                                          pricing!.offerPrice! * increment;
                                      _incrementActualPrice =
                                          pricing!.actualPrice! * increment;
                                    });
                                    _totalItemController.text =
                                        increment.toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  Stack(
                    children: [
                      pricing!.eventDetail!.imageUrl != null
                          ? Container(
                              height: 500,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    pricing!.eventDetail!.imageUrl!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: ClipRRect(
                                // make sure we apply clip it properly
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
                        child: Column(
                          children: [
                            Wrap(
                              direction: ResponsiveWidget.isSmallScreen(
                                          context) ||
                                      ResponsiveWidget.isMediumScreen(context)
                                  ? Axis.vertical
                                  : Axis.horizontal,
                              children: [
                                pricing!.eventDetail!.imageUrl != null
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                        ),
                                        child: Image.network(
                                          pricing!.eventDetail!.imageUrl!,
                                          height:
                                              ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ? 155
                                                  : 300,
                                          // width: ResponsiveWidget.isSmallScreen(
                                          //             context) ||
                                          //         ResponsiveWidget.isMediumScreen(
                                          //             context)
                                          //     ? SizeConfig.screenWidth * 0.9
                                          //     : SizeConfig.screenWidth * 0.6,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                    ),
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  height:
                                      ResponsiveWidget.isSmallScreen(context) ||
                                              ResponsiveWidget.isMediumScreen(
                                                  context)
                                          ? 320
                                          : 300,
                                  width:
                                      ResponsiveWidget.isSmallScreen(context) ||
                                              ResponsiveWidget.isMediumScreen(
                                                  context)
                                          ? SizeConfig.screenWidth * 0.9
                                          : SizeConfig.screenWidth * 0.388,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pricing?.name ?? 'Undefined',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 15),
                                      Text('Waktu Event',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption),
                                      SizedBox(
                                        width: ResponsiveWidget.isSmallScreen(
                                                    context) ||
                                                ResponsiveWidget.isMediumScreen(
                                                    context)
                                            ? SizeConfig.screenWidth * 0.9
                                            : SizeConfig.screenWidth * 0.3,
                                        child: !_isClosed
                                            ? Wrap(
                                                children: [
                                                  Text(
                                                    pricing?.eventDetail
                                                                ?.startEventDate !=
                                                            null
                                                        ? DateFormat
                                                                .yMMMMEEEEd()
                                                            .format(pricing!
                                                                .eventDetail!
                                                                .startEventDate!)
                                                        : 'Undefined',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2,
                                                  ),
                                                  Text(
                                                    ' - ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2,
                                                  ),
                                                  Text(
                                                    pricing?.eventDetail!
                                                                .endEventDate !=
                                                            null
                                                        ? DateFormat
                                                                .yMMMMEEEEd()
                                                            .format(pricing!
                                                                .eventDetail!
                                                                .endEventDate!)
                                                        : 'Undefined',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2,
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                'Closed',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    ?.copyWith(
                                                      color:
                                                          Colors.red.shade300,
                                                    ),
                                              ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text('Lokasi',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption),
                                      Text(
                                          pricing?.eventDetail?.location ??
                                              'Undefined',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2),
                                      const SizedBox(height: 10),
                                      Text(
                                        pricing?.eventDetail?.city ??
                                            'Undefined',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                      const Spacer(),
                                      Text(
                                          pricing?.offerPrice == 0
                                              ? 'Gratis'
                                              : rpDots
                                                  .format(pricing?.offerPrice),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.copyWith(color: Colors.green)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pricing?.eventDetail?.description ??
                                        'Undefined',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    pricing?.eventDetail?.note ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                  const SizedBox(height: 30),
                                  _videoController != null &&
                                          _videoController!.isInitialised
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              // height: 600,
                                              child: PodVideoPlayer(
                                                  videoThumbnail:
                                                      DecorationImage(
                                                    image: NetworkImage(
                                                      pricing!.eventDetail!
                                                          .imageUrl!,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  controller:
                                                      _videoController!),
                                            ),
                                            const SizedBox(height: 50),
                                          ],
                                        )
                                      : const SizedBox(),
                                  Center(
                                    child: ButtonTheme(
                                      height: 50,
                                      minWidth: 150,
                                      buttonColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: RaisedButton(
                                        onPressed: !_isClosed
                                            ? () {
                                                _showForm();

                                                PostActivityUseCase.exec(ActivityRequest(
                                                    type: ActivityTypeUtil
                                                        .webBuyTicket,
                                                    detail: pricing!.id,
                                                    extra: ActivityExtraRequest(
                                                        state: 'tap',
                                                        widget:
                                                            'bottom of description',
                                                        screen:
                                                            'ticket detail')));
                                              }
                                            : null,
                                        child: Text(
                                          'Beli',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Footer()
                ],
              ),
            ),
          );
  }
}
