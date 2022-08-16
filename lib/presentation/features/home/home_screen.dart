import 'package:fino/presentation/common/resources/colors/app_colors.dart';
import 'package:fino/presentation/common/ui/app_try_again_error.dart';
import 'package:fino/presentation/common/ui/loading/app_loading_overlay.dart';
import 'package:fino/presentation/features/home/home_cubit.dart';
import 'package:fino/presentation/features/home/home_state.dart';
import 'package:fino/presentation/features/home/ui/main_screen_top_panel.dart';
import 'package:fino/service_locator/app_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final _screenBloc = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ));
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _screenBloc,
      builder: (context, state) {
        return Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.black,
                  if (state.balance > 0) ...{AppColors.green},
                  if (state.balance == 0) ...{AppColors.background},
                  if (state.balance < 0) ...{AppColors.red},
                ],
              ),
            ),
            child: Stack(
              children: [
                MainScreenTopPanel(
                  backgroundColor: Colors.transparent,
                  onUserPressed: () {
                    // TODO: Implement method
                  },
                  onFilterPressed: () {
                    // TODO: Implement method
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 150),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.balance.toString()}₴",
                            style: const TextStyle(color: AppColors.background, fontSize: 36),
                          ),
                          Text(
                            "+${state.totalIncome.toString()}₴",
                            style: const TextStyle(color: AppColors.green, fontSize: 24),
                          ),
                          Text(
                            "${state.totalCost.toString()}₴",
                            style: const TextStyle(color: AppColors.red, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: state.transactions
                            .map(
                              (e) => Card(
                                child: ListTile(
                                  leading: Text(
                                    e.value.toString(),
                                    style: TextStyle(color: e.value < 0 ? AppColors.red : AppColors.green),
                                  ),
                                  title: Text(e.comment),
                                  subtitle: Text(Jiffy(e.date).format('dd.MM.yyy')),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                if (state.isLoading) ...{
                  const AppLoadingOverlay(),
                } else if (state.loadingException != null) ...{
                  AppTryAgainError(
                    message: state.loadingException.toString(),
                    onTryAgain: _screenBloc.loadTransactions,
                  ),
                },
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.foreground,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
