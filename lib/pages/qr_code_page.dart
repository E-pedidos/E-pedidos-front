import 'dart:convert';
import 'dart:typed_data';

import 'package:e_pedidos_front/repositorys/filial_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:share_extend/share_extend.dart';
import 'package:path_provider/path_provider.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  FilialRepository filialRepository = FilialRepository();
  var qrCodeData;

   void generateQrCode() async {
    var qrCodeBase64 = await filialRepository.getQrCodeByFilial();
    setState(() {
      qrCodeData = qrCodeBase64.body;
      print(qrCodeData);
    });
  }

  /* _createPdf(BuildContext context, ){

  } */

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 if (qrCodeData != null)
                Image.memory(
                base64Decode(
                    qrCodeData!.split(',').last,
                  ),
                  width: 200,
                  height: 200,
                ),
              ElevatedButton(
                onPressed: () {
                  generateQrCode();
                },
                child: Text('Buscar QR Code'),
              ),
              ],
            ),
          ),
        )
      );
  }
} 