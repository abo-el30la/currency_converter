import 'package:currency_converter/core/res/colors.dart';
import 'package:currency_converter/screens/converter/cubit/converter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConverterCubit(),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: cubit.amountController,
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                            ),
                          suffixIcon:  Container(
                            padding: EdgeInsets.all(16.r),
                            child: DropdownButton<String>(
                              value: 'USD',
                              onChanged: (String? newValue) {},
                              items: <String>['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          ),

                        ),
                      ),
                      16.horizontalSpace,

                    ],
                  ),
                  16.verticalSpace,
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.swap_horiz_sharp,
                      size: 48.r,
                      color: KAppColors.primaryColor,
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
}
