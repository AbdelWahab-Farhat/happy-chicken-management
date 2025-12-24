import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happy_chicken_restaurant/controllers/confirmation_order_cubit/confirmation_order_cubit.dart';
import 'package:happy_chicken_restaurant/controllers/print_invoice/print_invoice_cubit.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/utils/enums/enum_order_status.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:happy_chicken_restaurant/views/root/root_view.dart';

import '../../../utils/ui_widgets.dart';
import '../../../widgets/custom_button.dart';

class OrderDetailCardActionButtons extends StatelessWidget {
  final OrderModel? orderModel;
  const OrderDetailCardActionButtons({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ConfirmationOrderCubit>();

    return BlocConsumer<PrintInvoiceCubit, PrintInvoiceState>(
      listener: (context, state) {
        if (state is PrintInvoiceFailure) {
          showCustomSnackBar(context, state.message);
        } else if (state is PrintInvoiceSuccess) {
          showCustomSnackBar(context, "تم طباعة الفاتورة");
          context.pushAndRemoveUntil(RootView(initialIndex: 1));
        }
      },
      builder: (context, printState) {
        bool isPrinting = printState is PrintInvoiceLoading;

        return Stack(
          children: [
            BlocConsumer<ConfirmationOrderCubit, ConfirmationOrderState>(
              listener: (context, state) {
                if (state is ConfirmationOrderFailure) {
                  showCustomSnackBar(context, state.message);
                } else if (state is ConfirmationOrderSuccess &&
                    cubit.orderStatusAfterConfirmation ==
                        EnumOrderStatus.confirmed) {
                  showCustomSnackBar(context, state.message);
                  showCustomDialog(
                    context: context,
                    title: "عملية طباعة",
                    description: "طباعة الفاتورة تحت رقم  ${orderModel?.id.toStringAsFixed(0) ?? 0}",
                    image: "",
                    confirmButtonTitle: "طباعة الفاتورة",
                    onConfirm: () {
                      if (orderModel == null) return;
                      context.read<PrintInvoiceCubit>().printInvoice(orderModel!);
                    },
                    otherOptionButtonTitle: "الرجوع إلي الطلبات",
                    onOtherOption: ()=>context.pushAndRemoveUntil(RootView(initialIndex: 1)),
                  );
                } else if (state is ConfirmationOrderSuccess &&
                    cubit.orderStatusAfterConfirmation ==
                        EnumOrderStatus.cancelled) {
                  showCustomSnackBar(context, "تم رفض الطلب");
                  context.pushAndRemoveUntil(RootView(initialIndex: 1));
                }
              },
              builder: (context, state) {
                String confirmTitle = "قبول الطلب";
                String cancelTitle = "رفض الطلب";
                bool isLoading = state is ConfirmationOrderLoading;

                if (isLoading) {
                  confirmTitle = "جاري التجميل ...";
                  cancelTitle = "جاري التجميل ...";
                }

                return AbsorbPointer(
                  absorbing: isPrinting, // Disable interactions if printing
                  child: Row(
                    spacing: 16.w,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: confirmTitle,
                          backgroundColor: Colors.green,
                          onPressed: isLoading
                              ? null
                              : () {
                            cubit.orderStatusAfterConfirmation =
                                EnumOrderStatus.confirmed;
                            return cubit.confirmationOrder(
                                orderModel?.id.toString() ?? "00", EnumOrderStatus.confirmed);
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          title: cancelTitle,
                          backgroundColor: Colors.red,
                          onPressed: isLoading
                              ? null
                              : () {
                            cubit.orderStatusAfterConfirmation =
                                EnumOrderStatus.cancelled;
                            return cubit.confirmationOrder(
                                orderModel?.id.toString() ?? "00", EnumOrderStatus.cancelled);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (isPrinting)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
