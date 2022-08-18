import 'package:fino/presentation/common/resources/assets/app_assets.dart';
import 'package:fino/presentation/common/resources/colors/app_colors.dart';
import 'package:fino/presentation/common/ui/app_try_again_error.dart';
import 'package:fino/presentation/common/ui/loading/app_loading_overlay.dart';
import 'package:fino/presentation/features/home/home_cubit.dart';
import 'package:fino/presentation/features/home/home_state.dart';
import 'package:fino/presentation/features/home/transactions_list/home_transactions_draggable_sheet.dart';
import 'package:fino/presentation/features/home/ui/home_screen_top_panel.dart';
import 'package:fino/service_locator/app_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: Make Indicators disapear on _transactionsListSheet expand
// TODO: Make HomeScreenTopPannel's elements change colors to black on _transactionsListSheet expand
// TODO: Play with charts
// TODO: Make bottom nav bar rounded
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final _screenBloc = getIt<HomeCubit>();

  double _backgroundColorOpacity = 0;
  late final _transactionsListSheet = HomeTransactionsDraggableSheet(
    onSheetHeightChanged: (heightFraction) {
      setState(() => _backgroundColorOpacity = heightFraction);
    },
  );

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
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HomeScreenTopPanel(
                        backgroundColor: Colors.transparent,
                        onUserPressed: _openUserProfileScreen,
                        onFilterPressed: _showFilterPopUp,
                      ),
                      const SizedBox(height: 40),
                      _Indicators(
                        totalIncome: state.totalIncome,
                        balance: state.balance,
                        totalCost: state.totalCost,
                      ),
                      const SizedBox(height: 40),
                      Expanded(child: _transactionsListSheet),
                      // // TODO: --- ListView ----
                      // Expanded(
                      //   child: ListView(
                      //     shrinkWrap: true,
                      //     children: state.transactions
                      //         .map(
                      //           (e) => Card(
                      //             child: ListTile(
                      //               leading: Text(
                      //                 e.value.toString(),
                      //                 style: TextStyle(color: e.value < 0 ? AppColors.red : AppColors.green),
                      //               ),
                      //               title: Text(e.comment),
                      //               subtitle: Text(Jiffy(e.date).format('dd.MM.yyy')),
                      //             ),
                      //           ),
                      //         )
                      //         .toList(),
                      //   ),
                      // ),
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
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton.extended(
                  onPressed: _addNegativeTransaction,
                  tooltip: 'Decrement',
                  backgroundColor: AppColors.background,
                  foregroundColor: Colors.purple,
                  label: const Text("Lend"),
                ),
                FloatingActionButton.extended(
                  onPressed: _addNegativeTransaction,
                  tooltip: 'Decrement',
                  backgroundColor: AppColors.background,
                  foregroundColor: Colors.red,
                  label: const Text("Spend"),
                ),
                FloatingActionButton.extended(
                  onPressed: _addPositiveTransaction,
                  tooltip: 'Increment',
                  backgroundColor: AppColors.background,
                  foregroundColor: Colors.lightGreen,
                  label: const Text("Earn"),
                ),
                FloatingActionButton.extended(
                  onPressed: _addPositiveTransaction,
                  tooltip: 'Increment',
                  backgroundColor: AppColors.background,
                  foregroundColor: Colors.lightBlue,
                  label: const Text("Borrow"),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  void _openUserProfileScreen() {
    // TODO: Implement method
  }

  void _showFilterPopUp() {
    // TODO: Implement method
  }

  void _addPositiveTransaction() {
    // TODO: Implement method
  }

  void _addNegativeTransaction() {}
}

class _Indicators extends StatelessWidget {
  final double totalIncome;
  final double balance;
  final double totalCost;

  const _Indicators({
    required this.totalIncome,
    required this.balance,
    required this.totalCost,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Image.asset(AppAssets.icChevronLeft)),
        Expanded(
          flex: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    //TODO: Change to totalPlannedIncome
                    "+${totalIncome.toString()}₴",
                    // TODO: Add to AppColors
                    style: const TextStyle(color: Colors.teal, fontSize: 18),
                  ),
                ),
                Text(
                  "+${totalIncome.toString()}₴",
                  style: const TextStyle(color: AppColors.green, fontSize: 24),
                ),
                Column(
                  children: [
                    Text(
                      "${balance.toString()}₴",
                      style: const TextStyle(color: AppColors.background, fontSize: 36),
                    ),
                    Text(
                      "${balance.toString()}₴",
                      style: const TextStyle(color: Colors.orange, fontSize: 36),
                    ),
                  ],
                ),
                Text(
                  "${totalCost.toString()}₴",
                  style: const TextStyle(color: AppColors.red, fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  // TODO: Change to totalPlannedCost
                  child: Text(
                    "${totalCost.toString()}₴",
                    style: const TextStyle(color: Colors.deepOrangeAccent, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: Image.asset(AppAssets.icChevronRight)),
      ],
    );
  }
}
