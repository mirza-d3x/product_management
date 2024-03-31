import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techwarelab/app/features/add_products/bloc/add_products_bloc.dart';
import 'package:techwarelab/app/widgets/custom_textfield.dart';

class AddProductsScreen extends StatelessWidget {
  const AddProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<AddProductsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
        centerTitle: true,
      ),
      body: BlocConsumer<AddProductsBloc, AddProductsState>(
        listener: (context, state) {
          if (state is AddProductsInitial) {
            if (!state.isLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Product Added Successfully"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return BlocBuilder<AddProductsBloc, AddProductsState>(
            builder: (context, state) {
              if (state is AddProductsInitial) {
                return Container(
                  height: size.height,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: bloc.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextField(
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            label: 'Product Name',
                            hint: 'Enter your Product Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Product Name';
                              }
                              return null;
                            },
                            controller: bloc.nameController,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            obscureText: false,
                            keyboardType: TextInputType.multiline,
                            label: 'Product Description',
                            hint: 'Enter your Product Description',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Product Description';
                              }
                              return null;
                            },
                            controller: bloc.descriptionController,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            label: 'Product Price',
                            hint: 'Enter your Product Price',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Product Price';
                              }
                              return null;
                            },
                            controller: bloc.priceController,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: size.height * .3,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: state.imagePath.isEmpty
                                ? IconButton(
                                    onPressed: () {
                                      bloc.add(AddImageEvent());
                                    },
                                    icon: const Icon(
                                      Icons.file_upload_outlined,
                                      size: 40,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      bloc.add(AddImageEvent());
                                    },
                                    child: Image.file(
                                      File(state.imagePath),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              if (!state.isLoading) {
                                bloc.add(AddProductEvent());
                              }
                            },
                            child: state.isLoading
                                ? const CircularProgressIndicator()
                                : const Text('Add Product'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
