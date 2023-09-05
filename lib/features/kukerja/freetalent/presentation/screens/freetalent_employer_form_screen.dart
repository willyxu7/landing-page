import 'package:flutter/material.dart';
import 'package:kukerja_web/core/config/size_config.dart';
import 'package:kukerja_web/core/data/repositories/city_repository_impl.dart';
import 'package:kukerja_web/core/domain/entities/job_role.dart';
import 'package:kukerja_web/core/domain/usecases/job_role_use_case.dart';
import 'package:kukerja_web/core/providers/job_role_provider.dart';
import 'package:kukerja_web/core/widgets/app_loading_widget.dart';
import 'package:kukerja_web/core/widgets/nav_bar.dart';
import 'package:kukerja_web/core/widgets/nav_bar_drawer.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/widgets/freetalent_employer/freetalent_employer_form_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../core/data/models/responses/city_response.dart';
import '../../../../../core/data/repositories/job_role_repository_impl.dart';
import '../../../../../core/domain/usecases/city_usecase.dart';
import '../../../../../core/providers/city_provider.dart';

class FreetalentEmployerFormScreen extends StatefulWidget {
  static const String route = '/create';

  const FreetalentEmployerFormScreen({Key? key}) : super(key: key);

  @override
  State<FreetalentEmployerFormScreen> createState() =>
      _FreetalentEmployerFormScreenState();
}

class _FreetalentEmployerFormScreenState
    extends State<FreetalentEmployerFormScreen> {
  final CityUseCase _cityUseCase = CityUseCase(CityRepositoryImpl());
  final JobRoleUseCase _jobRoleUseCase =
      JobRoleUseCase(JobRoleRepositoryImpl());

  @override
  void initState() {
    _fetchCities();
    _fetchJobRoles();
    super.initState();
  }

  void _fetchCities() async {
    List<CityResponse> cityResponses = await _cityUseCase.fetchCities();

    context.read<CityProvider>().cities =
        cityResponses.map((cityResponse) => cityResponse.name).toList();
  }

  void _fetchJobRoles() async {
    List<JobRole> jobRoles = await _jobRoleUseCase.fetchAll();

    context.read<JobRoleProvider>().jobRoles = jobRoles;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return context.watch<JobRoleProvider>().isLoading
        ? const AppLoadingWidget()
        : const Scaffold(
            appBar: NavBar(),
            drawer: NavBarDrawer(),
            body: FreetalentEmployerFormWidget(),
          );
  }
}
