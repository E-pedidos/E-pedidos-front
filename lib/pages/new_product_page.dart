// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:e_pedidos_front/models/food_category_model.dart';
import 'package:e_pedidos_front/repositorys/food_category_repository.dart';
import 'package:e_pedidos_front/repositorys/item_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart' as picker;

import '../shared/utils/image_utils.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  CategoryRpository categoryRpository = CategoryRpository();
  ItemRepository itemRepository = ItemRepository();
  CroppedFile? image;
  TextEditingController controllerName = TextEditingController(text: '');
  TextEditingController controllerDescription = TextEditingController(text: '');
  TextEditingController controllerValue = TextEditingController(text: '');
  TextEditingController controllerProductionValue = TextEditingController(text: '');
  TextEditingController controllerIdFoodCategory = TextEditingController(text: '');
  String? dropdownValue = '';
  List<FoodCategory> foodCategorys = [];

  @override
  void initState() {
    super.initState();
    getFoodCategorys();
  }

  cropImage(picker.XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Foto de Perfil',
            toolbarColor: Colors.orange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Foto de Perfil',
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        image = croppedFile;
      });
    }
  }

  void selectImage() async {
    picker.XFile? img = await pickImage(picker.ImageSource.gallery);

    if (img != null) {
      setState(() {
        cropImage(img);
      });
    }
    return;
  }

  getFoodCategorys() async {
    var res = await categoryRpository.getFoodCategory();
    setState(() {
      foodCategorys = res;
      if (foodCategorys.isNotEmpty) {
        dropdownValue = foodCategorys[0].id ?? '';
        controllerIdFoodCategory.text = dropdownValue!;
      }
    });
  }

  registerItem() async {
    var res = await itemRepository.registerItem(
      name: controllerName.text, 
      description: controllerDescription.text, 
      valor: double.parse(controllerValue.text), 
      productCost: double.parse(controllerProductionValue.text), 
      foodCategoryId: controllerIdFoodCategory.text, 
      photo: image!
    );

    if(res.statusCode == 201){
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            padding: EdgeInsets.all(30),
            content: Text('Item cadastrado'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).popAndPushNamed('/newproduct');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            padding: EdgeInsets.all(30),
            content: Text('Erro ao cadastradar item!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: CustomLayout(
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Novo Produto',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const Text('Adicione o novo produto do seu cardápio',
                  style: TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(61, 61, 61, 1),
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 17,
              ),
              Expanded(
                child: ListView(
                  children: [
                    const Text(
                      'Imagem',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: double.tryParse('151'),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: const Color.fromRGBO(54, 148, 178, 1),
                              width: 2.0)),
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: image != null
                                  ? Image.file(
                                      File(image!.path),
                                      fit: BoxFit.fill,
                                    )
                                  : const Center(child: Text('Selecione uma imagem')),
                                  ),
                          Positioned(
                            bottom: 0,
                            left: MediaQuery.of(context).size.width * 0.7,
                            right: 0,
                            child: CustomIconButton(
                              icon: Icons.add_a_photo,
                              backgroundColor:
                                  const Color.fromRGBO(54, 148, 178, 1),
                              iconColor: Colors.white,
                              onTap: selectImage,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    const Text(
                      'Nome',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      controller: controllerName,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Descrição',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      controller: controllerDescription,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Valor ',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controllerValue,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Valor de produção',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controllerProductionValue,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Categoria',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        underline: Container(
                          height: 2,
                          color: const Color.fromARGB(0, 54, 147, 178),
                        ),
                        onChanged: (String? newValue) async {
                          setState(() {
                            dropdownValue = newValue!;
                            controllerIdFoodCategory.text = dropdownValue!;
                          });
                        },
                        items: foodCategorys.map((FoodCategory filial) {
                          return DropdownMenuItem<String>(
                            value: filial.id.toString(),
                            child: Text(filial.name.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomButton(
                      onPressed: registerItem,
                      text: 'Concluir',
                      backgroundColor: const Color.fromRGBO(100, 255, 106, 1),
                      textColor: const Color.fromRGBO(23, 160, 53, 1),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
