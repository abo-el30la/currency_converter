import 'package:currency_converter/core/res/colors.dart';
import 'package:currency_converter/core/widgets/customs/loading_widget.dart';
import 'package:currency_converter/screens/converter/cubit/converter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConverterCubit()
        ..getBaseCurrenciesList()
        ..getCurrencyExchangeRate(),
      child: BlocConsumer<ConverterCubit, ConverterState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<ConverterCubit>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Converter'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: cubit.isGetCurrencyExchangeRateLoading
                  ? const Center(
                      child: LoadingWidget(),
                    )
                  : Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: cubit.amountController,
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                            suffixIcon: Container(
                              padding: EdgeInsets.all(16.r),
                              child: DropdownButton<String>(
                                value: cubit.baseCurrency,
                                onChanged: (String? newValue) {
                                  cubit.setBaseCurrency(newValue ?? 'USD');
                                },
                                items: mapCurrencyList(context),
                              ),
                            ),
                          ),
                        ),
                        32.verticalSpace,
                        IconButton(
                          onPressed: () {
                            cubit.swapCurrencies();
                          },
                          icon: Icon(
                            Icons.swap_horiz_sharp,
                            size: 48.r,
                            color: KAppColors.primaryColor,
                          ),
                        ),
                        32.verticalSpace,
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: cubit.targetAmountController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                            suffixIcon: Container(
                              padding: EdgeInsets.all(16.r),
                              child: DropdownButton<String>(
                                value: cubit.targetCurrency,
                                onChanged: (String? newValue) {
                                  cubit.setTargetCurrency(newValue ?? 'USD');
                                },
                                items: mapCurrencyList(context),
                              ),
                            ),
                          ),
                        ),
                        64.verticalSpace,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: KAppColors.primaryColor,
                          ),
                          onPressed: () {
                            cubit.convertCurrency();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 64.h),
                            child: Text(
                              'Convert',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> mapCurrencyList(BuildContext context) {
    final cubit = context.read<ConverterCubit>();
    final listCurrency = cubit.currenciesList.map((e) => e.code).toList();
    return listCurrency.map<DropdownMenuItem<String>>(
      (String? value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value ?? 'USD'),
        );
      },
    ).toList();
  }
}
