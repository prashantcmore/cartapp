import 'package:cartapp/screens/UserProductsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Product.dart';
import '../providers/Products_provider.dart';
import '../widgets/AppDrawer.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = 'edit Screen';

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrl = FocusNode();
  final _imagaeUrlController = TextEditingController();
  var _form = GlobalKey<FormState>();
  var _editedproduct = Product(id: '', title: '', price: 0, description: '', imageUrl: '');
  var _initValues = {
    'title': '',
    'description': '',
    'imageUrl': '',
    "price": '',
  };

  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrl.dispose();
    _imagaeUrlController.dispose();
    _imageUrl.removeListener(_updateImageUrl);
    super.dispose();
  }

  var _init = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrl.addListener(_updateImageUrl);
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   if (_init) {
  //     final productId = ModalRoute.of(context)!.settings.arguments as String;
  //     if (productId != null) {
  //       _editedproduct = Provider.of<Products>(context, listen: false).findById(productId);
  //       _initValues = {
  //         'title': _editedproduct.title,
  //         'description': _editedproduct.description,
  //         'price': _editedproduct.price.toString(),
  //         'imageUrl': '',
  //       };
  //       _imagaeUrlController.text = _editedproduct.imageUrl;
  //     }
  //   }
  //   _init = false;
  //   super.didChangeDependencies();
  // }

  void _updateImageUrl() {
    if (!_imageUrl.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    _form.currentState!.validate();
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    // if (_editedproduct.id != null) {
    //   await Provider.of<Products>(context, listen: false).updateProduct(_editedproduct.id, _editedproduct);
    // } else {
    try {
      await Provider.of<Products>(context, listen: false).addProducts(_editedproduct);
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("An error occured"),
          content: const Text("Something Wnet Wrong"),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: const InputDecoration(hintText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (value) {
                        _editedproduct = Product(
                          title: value.toString(),
                          imageUrl: _editedproduct.imageUrl,
                          price: _editedproduct.price,
                          description: _editedproduct.description,
                          id: _editedproduct.id,
                          isFavourite: _editedproduct.isFavourite,
                        );
                      },
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'please enter the value';
                        }
                      }),
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: const InputDecoration(hintText: 'Price'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (value) {
                        _editedproduct = Product(
                            price: double.parse(value!),
                            description: _editedproduct.description,
                            title: _editedproduct.title,
                            id: _editedproduct.id,
                            imageUrl: _editedproduct.imageUrl);
                      },
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'please enter the value';
                        }
                      }),
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: const InputDecoration(hintText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocus,
                      onSaved: (value) {
                        _editedproduct = Product(
                            price: _editedproduct.price,
                            description: value.toString(),
                            title: _editedproduct.title,
                            id: _editedproduct.id,
                            imageUrl: _editedproduct.imageUrl);
                      },
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'please enter the value';
                        }
                        if (value.length < 15) {
                          return 'please enter at least 10 word';
                        }
                      }),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(right: 10, top: 8),
                          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
                          child: _imagaeUrlController.text.isEmpty
                              ? const Text('Enter the Url')
                              : FittedBox(
                                  child: Image.network(
                                    _imagaeUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(hintText: 'Image Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imagaeUrlController,
                            onFieldSubmitted: ((_) => _saveForm()),
                            onSaved: (value) {
                              _editedproduct = Product(
                                  price: _editedproduct.price,
                                  description: _editedproduct.description,
                                  title: _editedproduct.title,
                                  id: _editedproduct.id,
                                  imageUrl: value!,
                                  isFavourite: _editedproduct.isFavourite);
                            },
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'please enter the value';
                              }
                              if (value.contains('.png')) {
                                return 'please enter the valid url';
                              }
                            }),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
