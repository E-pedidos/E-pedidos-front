import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:e_pedidos_front/repositorys/filial_repository.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:printing/printing.dart';
import 'package:share_extend/share_extend.dart';
import 'package:path_provider/path_provider.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  FilialRepository filialRepository = FilialRepository();
  SharedPreferencesUtils prefs = SharedPreferencesUtils();
  var qrCodeData;
  String name = '';
  String image = '';

  @override
  void initState() {
    super.initState();
    _generateQrCode();
  }
  


  void _generateQrCode() async {
    var qrCodeBase64 = await filialRepository.getByQrCode();
    var user = await prefs.getUserData();
    var avatar = await prefs.getUrlAvatar();

    Map<String, dynamic> dataUser = user;
    

    setState(() {
      qrCodeData = qrCodeBase64.body;
      name = dataUser['name'];
      image = avatar ?? '';
    });
  }

  _createPdf(BuildContext context) async {
    final pdfLib.Document pdf = pdfLib.Document();
    final imageLogo = await networkImage(image);
    String svgRaw = ''''
          <svg width="64" height="92" viewBox="0 0 64 92" fill="none" xmlns="http://www.w3.org/2000/svg">
          <g filter="url(#filter0_d_0_1)">
          <rect x="4" width="56" height="84" rx="5" fill="black"/>
          <rect x="5.5" y="1.5" width="53" height="81" rx="3.5" stroke="black" stroke-width="3"/>
          </g>
          <rect x="24" y="1.33203" width="14.6667" height="1.33333" rx="0.666667" fill="#D9D9D9"/>
          <circle cx="31.9997" cy="27.9987" r="22.6667" fill="#FF0000"/>
          <circle cx="31.9997" cy="39.9987" r="22.6667" fill="#FF8212"/>
          <circle cx="31.9997" cy="58.6667" r="22.6667" fill="#3694B2"/>
          <path d="M29.3282 28.8921C29.3744 29.1679 30.2571 34.4382 30.2571 36.4512C30.2571 39.5206 28.6532 41.7097 26.2821 42.5901L27.0263 56.5639C27.0667 57.3679 27.0263 82.6341 25.1744 83.9999L21.9494 82.6341C21.159 82.6341 20.5244 57.3738 20.5648 56.5639L21.309 42.5901C18.9321 41.7097 17.334 39.5148 17.334 36.4512C17.334 34.4323 18.2167 29.1679 18.2628 28.8921C18.4474 27.7007 20.8763 27.6831 21.0263 28.9566V37.2435C21.1013 37.443 21.8974 37.4313 21.9494 37.2435C22.0301 35.7587 22.4051 29.074 22.4109 28.9214C22.6013 27.7007 24.9898 27.7007 25.1744 28.9214C25.1859 29.0799 25.5551 35.7587 25.6359 37.2435C25.6878 37.4313 26.4898 37.443 26.559 37.2435V28.9566C26.709 27.6889 29.1436 27.7007 29.3282 28.8921ZM36.2051 45.6595L35.3398 56.5228C35.2705 57.3444 34.5321 82.6341 35.3398 82.6341H39.9494C41.334 82.6341 41.334 57.4207 41.334 56.6402V29.4085C41.334 28.6338 40.7167 28 39.9494 28C35.1898 28 27.1763 38.476 36.2051 45.6595Z" fill="black"/>
          <defs>
          <filter id="filter0_d_0_1" x="0" y="0" width="64" height="92" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
          <feFlood flood-opacity="0" result="BackgroundImageFix"/>
          <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
          <feOffset dy="4"/>
          <feGaussianBlur stdDeviation="2"/>
          <feComposite in2="hardAlpha" operator="out"/>
          <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/>
          <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_0_1"/>
          <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_0_1" result="shape"/>
          </filter>
          </defs>
          </svg>
          ''';

    pdf.addPage(pdfLib.MultiPage(build: (pdfLib.Context context) =>[
        pdfLib.Container(
          color: PdfColors.amber,
          child: pdfLib.Padding(
            padding: const pdfLib.EdgeInsets.all(20),
            child: pdfLib.Column(
              children: [
                pdfLib.Text(
                  'Acesse o cardápio digital',
                  style: pdfLib.TextStyle(
                    fontWeight: pdfLib.FontWeight.bold,
                    fontSize: 25,
                    color: PdfColors.white
                  )
                ),
                pdfLib.SizedBox(height: 25),
                pdfLib.Image(imageLogo, height: 90, width: 90),
                pdfLib.Text(name),
                pdfLib.SizedBox(height: 25),
                pdfLib.Container(
                  decoration: pdfLib.BoxDecoration(
                    border: pdfLib.Border.all( color: PdfColors.black, width: 2, ),
                    borderRadius: pdfLib.BorderRadius.circular(10)
                  ),
                  child: pdfLib.Image(pdfLib.MemoryImage(
                    base64Decode(
                      qrCodeData!.split(',').last
                    )),
                    height: 200,
                    width: 200
                    )
                ),
                pdfLib.SizedBox(height: 50),
                pdfLib.Row(
                  mainAxisAlignment: pdfLib.MainAxisAlignment.center,
                  children:[
                     pdfLib.SvgImage(
                        svg: svgRaw,
                        width: 30,
                        height: 30,
                      ),
                      pdfLib.SizedBox(height: 15),
                      pdfLib.Text('cardápio gerado no app E-pedidos')
                  ] 
                )
              ])
            )
          )
    ]));

    final String dir = (await getApplicationDocumentsDirectory()).path;

    final String path = '$dir/qrcode$name.pdf';

    final File file = File(path);
    file.writeAsBytesSync(await pdf.save());

    ShareExtend.share(path, 'file', sharePanelTitle: 'Enviar Pdf');
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      child: Scaffold(
        body: GestureDetector(
                  onDoubleTap: (){
                    _createPdf(context);
                  },
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
                      child: Container(
                        color: const Color.fromRGBO(255, 193, 7, 1),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                  const Text(
                                    'Acesse o cardápio digital',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      color: Colors.white
                                    ),
                                  ),
                                  const SizedBox(height: 25,),
                                  image != '' 
                                  ? Image.network(
                                      image,
                                      width: 90,
                                      height: 90,
                                    )
                                  : const SizedBox(),
                                  Text(
                                    name.toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      color: Colors.white
                                    ),
                                  ),
                                  const SizedBox(height: 25,),
                                  qrCodeData != null ?
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black, 
                                        width: 2, 
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.memory(
                                      base64Decode(
                                        qrCodeData!.split(',').last,
                                      ),
                                      width: 200,
                                      height: 200,
                                    ),
                                  )
                                    :
                                  const Text('Algo deu errado!!'),
                                  const SizedBox(height: 50,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'lib/assets/logo.svg',
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(width: 10,),
                                      const Text('cardápio gerado no app E-pedidos')
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      )
                    ),
                ),
        )
      );
  }
} 