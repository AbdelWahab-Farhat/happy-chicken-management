import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:happy_chicken_restaurant/models/order_model.dart';
import 'package:happy_chicken_restaurant/models/user_model.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_printer.dart';

class PrintInvoice {
  PrintInvoice();

  Future<Either<String, List<String>>> printInvoices(UserModel userModel, List<OrderModel> orders) async {
    List<String> errors = [];
    List<String> printedOrderIds = [];

    for (var orderModel in orders) {
      final result = await printInvoice(userModel, orderModel);

      result.fold((error) => errors.add(error),
            (success) async {
          printedOrderIds.add(orderModel.id.toString());
          await SunmiPrinter.lineWrap(3);
        },
      );
    }

    await SunmiPrinter.cutPaper();

    return errors.isEmpty
        ? Right(printedOrderIds)
        : Left(errors.join("\n"));
  }

  Future<Either<String, void>> printInvoice(
      UserModel userModel, OrderModel orderModel) async {
    try {
      // Print Header
      await SunmiPrinter.printText(
        'Happy Chicken Restaurant',
        style: SunmiTextStyle(
          bold: true,
          align: SunmiPrintAlign.CENTER,
          fontSize: 30,
        ),
      );

      // Branch Info
      await SunmiPrinter.printText("${userModel.address}العنوان : ",
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));
      await SunmiPrinter.printText("${userModel.phone}الهاتف : ",
          style: SunmiTextStyle(align: SunmiPrintAlign.CENTER));

      await SunmiPrinter.lineWrap(1);

      await SunmiPrinter.printText(
        '--------------------------------',
        style: SunmiTextStyle(align: SunmiPrintAlign.CENTER),
      );

      // Invoice Header
      await SunmiPrinter.printText(
        'الكمية  الصنف         السعر         الإجمالي',
        style: SunmiTextStyle(align: SunmiPrintAlign.RIGHT, bold: true),
      );
      await SunmiPrinter.printText(
        '--------------------------------',
        style: SunmiTextStyle(align: SunmiPrintAlign.CENTER),
      );

      // Print Items
      for (var product in orderModel.relationships.products) {

        await SunmiPrinter.printText(
          '${product.quantity}    ${product.name}    ${product.unitPrice.toStringAsFixed(2)}    ${product.totalPrice.toStringAsFixed(2)}',
        );
      }

      await SunmiPrinter.printText(
        '--------------------------------',
        style: SunmiTextStyle(align: SunmiPrintAlign.CENTER),
      );
      await SunmiPrinter.lineWrap(1);

      // Payment Info
      await SunmiPrinter.printText(
          'طريقة الاستلام:                  ${orderModel.attributes.orderType}');
      await SunmiPrinter.printText(
          'إجمالي الطلب:                LYD ${orderModel.attributes.totalPrice}');

      await SunmiPrinter.lineWrap(1);

      // Thank You Message and Date
      await SunmiPrinter.printText(
        'شكرًا لكم!',
        style: SunmiTextStyle(align: SunmiPrintAlign.CENTER, bold: true),
      );
      await SunmiPrinter.printText(
        orderModel.attributes.createdAt.format(),
        style: SunmiTextStyle(align: SunmiPrintAlign.CENTER),
      );

      return const Right(null);
    } catch (e) {
      log(e.toString());
      return Left('Failed to print receipt: $e');
    }
  }
}
