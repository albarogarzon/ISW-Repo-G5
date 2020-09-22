import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:isw_implementacion_us_08_g5/components/ListoButton.dart';
import 'package:isw_implementacion_us_08_g5/providers/ProductInformation.dart';
import 'package:isw_implementacion_us_08_g5/resources/Strings.dart';
import 'package:isw_implementacion_us_08_g5/validators/ProductInformationValidator.dart';
import 'package:provider/provider.dart';

class QueBuscamosScreen extends StatefulWidget {
  QueBuscamosScreen({Key key}) : super(key: key);

  @override
  _QueBuscamosScreenState createState() => _QueBuscamosScreenState();
}

class _QueBuscamosScreenState extends State<QueBuscamosScreen> {
  TextEditingController _descripcionController;
  ProductInformation _productInformation;
  ProductInformationValidator _validator;

  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    _validator =
        Provider.of<ProductInformationValidator>(context, listen: false);
    _productInformation =
        Provider.of<ProductInformation>(context, listen: false);
    _descripcionController =
        TextEditingController(text: _productInformation.getDescripcion);
    _image = _productInformation.getImage;

    _validator.setStateWithoutNotify = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.QUE_BUSCAMOS),
          backgroundColor: Color(0xffA42B36)),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Selector<ProductInformationValidator, bool>(
                    selector: (_, validator) => validator.getDescripcionState,
                    builder: (_, descripcionState, __) => TextField(
                      controller: _descripcionController,
                      decoration: InputDecoration(
                          labelText: 'Ingresá una descripción',
                          errorText: descripcionState
                              ? null
                              : "Debe ingresar una descripción del producto"),
                    ),
                  ),
                  _buildTitle(),
                  _divider,
                  GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: <Widget>[
                      GestureDetector(
                        onTap: getImage,
                        child: Container(
                          color: Colors.black12,
                          child: _image == null ||
                                  checkFileSize(_image.path, context) == false
                              ? Icon(Icons.add)
                              : Image.file(_image),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListoButton(
              onPressed: _listo,
            ),
          ],
        ),
      ),
    );
  }

  _listo() {
    String descripcion = _descripcionController.text;
    if (_validator.validateInformation(descripcion)) {
      _productInformation.saveData(descripcion, _image);
      Navigator.pop(context);
    } else {
      return;
    }
  }

  checkFileSize(path, contexto) {
    print("Entro a check.PATH: ${path}");
    var fileSizeLimit = 5000000;
    File f = new File(path);
    var s = f.lengthSync();
    print(s); // returns in bytes
    var fileSizeInKB = s / 1024;
    // Convert the KB to MegaBytes (1 MB = 1024 KBytes)
    var fileSizeInMB = fileSizeInKB / 1024;
    if (s > fileSizeLimit) {
      print("File size greater than the limit$s");

      return false;
    } else {
      print("File can be selected$s");
      return true;
    }
  }

  Future getImage() async {
    List<File> pickedFile = await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: ['jpg'],
    );
    setState(() {
      _image = File(pickedFile[0].path);
    });
  }

  _buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Text(
        "Subí una foto",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  final Divider _divider = Divider(
    color: Colors.grey,
  );
}
