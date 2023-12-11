// ignore_for_file: use_build_context_synchronously
import 'package:e_pedidos_front/repositorys/item_repository.dart';
import 'package:e_pedidos_front/shared/utils/crop_image_utils.dart';
import 'package:e_pedidos_front/shared/utils/image_utils.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CustomCardMenu extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String idItem;
  final String image;
  final String priceCus;
  final bool isTrending;

  const CustomCardMenu(
      {super.key,
      required this.name,
      required this.description,
      required this.price,
      required this.idItem,
      required this.image,
      required this.priceCus,
      required this.isTrending});

  @override
  State<CustomCardMenu> createState() => _CustomCardMenuState();
}

class _CustomCardMenuState extends State<CustomCardMenu> {
  ItemRepository itemRepository = ItemRepository();
  bool? isChecked;
  CroppedFile? imageCrop;
  
  @override
  void initState() {
    super.initState();
    setState(() {
      isChecked = widget.isTrending;
    });
  }

  cropImage(XFile image) async{
      CropImageUtil cropImageUtil = CropImageUtil();

      var img = await cropImageUtil.cropImage(image);
      setState(() {
        imageCrop = img;
      });
  }

  void selectImage() async {
    XFile? img = await pickImage(ImageSource.gallery);

    if (img != null) {
      setState(() {
        cropImage(img);
      });
    }
    return;
  }

  void _showEditDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedName = widget.name;
        String editedDescription = widget.description;
        String editedPrice = widget.price;
        String editedPriceCus = widget.priceCus;
        String editedImage = widget.image;

        return AlertDialog(
          title: const Text('Editar campos'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      editedImage,
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                    Positioned(
                      left: 0,
                      right: 20,
                      bottom: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomIconButton(
                              icon: Icons.edit,
                              backgroundColor:
                                  const Color.fromRGBO(54, 148, 178, 1),
                              iconColor: Colors.white,
                              onTap: () {
                                selectImage();
                              }),
                        ],
                      ),
                    )
                  ],
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome'),
                  onChanged: (value) {
                    editedName = value;
                  },
                  initialValue: editedName,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Descrição'),
                  onChanged: (value) {
                    editedDescription = value;
                  },
                  initialValue: editedDescription,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Valor'),
                  onChanged: (value) {
                    editedPrice = value;
                  },
                  initialValue: editedPrice,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Preço de Custo'),
                  onChanged: (value) {
                    editedPriceCus = value;
                  },
                  initialValue: editedPriceCus,
                ),
                CustomButton(
                    text: 'Salvar',
                    textColor: const Color.fromRGBO(23, 160, 53, 1),
                    backgroundColor: const Color.fromRGBO(100, 255, 106, 1),
                    onPressed: () async {
                      var res = await itemRepository.updateItem(
                          widget.idItem,
                          editedName,
                          editedDescription,
                          double.parse(editedPrice),
                          double.parse(editedPriceCus));

                      if (res.statusCode == 202) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            padding: EdgeInsets.all(30),
                            content: Text('Item editado'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.popUntil(
                            context, ModalRoute.withName('/menu'));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            padding: EdgeInsets.all(30),
                            content: Text('erro ao editar!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  handleDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza que deseja excluir?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () async {
                var res = await itemRepository.deleteItem(widget.idItem);

                if (res.statusCode == 204) {
                  Navigator.popUntil(context, ModalRoute.withName('/menu'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      padding: EdgeInsets.all(30),
                      content: Text('Deletado com sucesso!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      padding: EdgeInsets.all(30),
                      content: Text('erro '),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 19),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(54, 148, 178, 1),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'R\$ ${widget.price}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(23, 160, 53, 1)),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  widget.image != null
                      ? Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        )
                      : Image.asset('lib/assets/menu1.png'),
                  Positioned(
                    left: 55,
                    right: 0,
                    top: -15,
                    child: Checkbox(
                        activeColor: Colors.amber,
                        value: isChecked,
                        onChanged: (value) async {
                          setState(() {
                            isChecked = value;
                          });
                          var res = await itemRepository
                              .updateIsTrending(widget.idItem);

                          if (res.statusCode == 202 && isChecked == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: const EdgeInsets.all(30),
                                content: Text('${widget.name} é Destaque!'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else if (res.statusCode == 202 &&
                              isChecked == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: const EdgeInsets.all(30),
                                content: Text('${widget.name} não é Destaque!'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                padding: EdgeInsets.all(30),
                                content: Text('Ocorreu um erro!'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }),
                  ),
                  Positioned(
                    left: 0,
                    right: 15,
                    bottom: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomIconButton(
                            icon: Icons.remove,
                            backgroundColor:
                                const Color.fromRGBO(255, 148, 148, 1),
                            iconColor: const Color.fromRGBO(255, 0, 0, 1),
                            onTap: handleDelete),
                        const SizedBox(
                          width: 4,
                        ),
                        CustomIconButton(
                            icon: Icons.edit,
                            backgroundColor:
                                const Color.fromRGBO(54, 148, 178, 1),
                            iconColor: Colors.white,
                            onTap: () {
                              _showEditDialog(context);
                            }),
                      ],
                    ),
                  )
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }
}
