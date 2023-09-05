import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/data/repositories/city_repository_impl.dart';
import 'package:kukerja_web/core/widgets/app_loading_widget.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';
import 'package:kukerja_web/core/domain/usecases/city_usecase.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/providers/ask_for_worker_provider.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/widgets/ask_for_workers/ask_for_worker_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../core/widgets/nav_bar.dart';
import '../../../../../core/data/models/responses/city_response.dart';

class AskForWorkerScreen extends StatefulWidget {
  static const route = '/ask-for-workers';

  const AskForWorkerScreen({Key? key}) : super(key: key);

  @override
  State<AskForWorkerScreen> createState() => _AskForWorkerScreenState();
}

class _AskForWorkerScreenState extends State<AskForWorkerScreen> {
  bool _isLoading = true;
  final CityUseCase _cityUseCase = CityUseCase(CityRepositoryImpl());

  @override
  void initState() {
    _fetchApi();
    super.initState();
  }

  void _fetchApi() {
    _fetchCities();
    setState(() {
      _isLoading = false;
    });
  }

  void _fetchCities() async {
    List<CityResponse> cityResponses = await _cityUseCase.fetchCities();

    context.read<AskForWorkerProvider>().setCities(
        cityResponses.map((cityResponse) => cityResponse.name).toList());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return _isLoading
        ? const AppLoadingWidget()
        : Scaffold(
            appBar: const NavBar(),
            drawer: const NavBarDrawer(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Carikan Karyawan',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ),
                        AskForWorkerWidget()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
