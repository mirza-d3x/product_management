import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:techwarelab/domain/entities/products/products.dart';
import 'package:techwarelab/domain/use_cases/file_storage/file_upload_use_cases.dart';
import 'package:techwarelab/domain/use_cases/products/add_product_use_cases.dart';
import 'package:techwarelab/utils/common_methodes.dart';
import 'package:techwarelab/utils/console_log.dart';

part 'add_products_event.dart';
part 'add_products_state.dart';

class AddProductsBloc extends Bloc<AddProductsEvent, AddProductsState> {
  final AddProductUseCase _addProductUseCase;
  final UploadFileUseCase _uploadFileUseCase;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  File? imageFile;

  AddProductsBloc(this._addProductUseCase, this._uploadFileUseCase)
      : super(AddProductsInitial(imagePath: "", isLoading: false)) {
    on<AddProductEvent>(_onAddProduct);
    on<AddImageEvent>(_onAddImage);
  }

  void _onAddImage(AddImageEvent event, Emitter<AddProductsState> emit) async {
    try {
      imageFile = await imagePicker();
      consoleLog("Image picked" + "data: ${imageFile!.path}");
      emit(AddProductsInitial(imagePath: imageFile!.path, isLoading: false));
    } catch (error, stackTrace) {
      consoleLog("Erorr while adding image",
          error: error, stackTrace: stackTrace);
    }
  }

  void _onAddProduct(
      AddProductEvent event, Emitter<AddProductsState> emit) async {
    if (validateFields()) {
      try {
        emit(AddProductsInitial(imagePath: imageFile!.path, isLoading: true));
        final uploadedImage = await uploadImage();
        await _addProductUseCase(
          Product(
            name: nameController.text,
            description: nameController.text,
            price: double.parse(priceController.text),
            imageUrl: uploadedImage,
          ),
        );
        resetValues();
        emit(AddProductsInitial(imagePath: "", isLoading: false));
      } catch (error, stackTrace) {
        consoleLog("Error while adding products: ",
            error: error, stackTrace: stackTrace);
      }
    }
  }

  void resetValues() {
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    imageFile = null;
  }

  bool validateFields() {
    return (formKey.currentState!.validate() && imageFile != null);
  }

  Future<String> uploadImage() async {
    try {
      final String fileName = imageFile!.path.split('/').last;
      final String imageUrl = await _uploadFileUseCase(
          destinationPath: 'product_image/$fileName', file: imageFile!);
      return imageUrl;
    } catch (error, stackTrace) {
      consoleLog("Error while uploading image: ",
          error: error, stackTrace: stackTrace);
    }
    return "";
  }

  @override
  Future<void> close() async {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    if (imageFile != null) {
      imageFile!.delete();
    }
    return super.close();
  }
}
