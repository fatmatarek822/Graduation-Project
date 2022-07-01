/*
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:realestateapp/layout/layout_screen.dart';
import 'package:realestateapp/models/BundleModel.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home/home_screen.dart';
import 'package:realestateapp/modules/home_furniture/furniture_screen.dart';
import 'package:realestateapp/modules/map/map_screen.dart';
import 'package:realestateapp/modules/new_post/userLocation.dart';
import 'package:realestateapp/shared/components/components.dart';

import '../../shared/components/constant.dart';

class NewHomeFurniture extends StatefulWidget {
  @override
  State<NewHomeFurniture> createState() => _NewHomeFurnitureState();
}

class _NewHomeFurnitureState extends State<NewHomeFurniture> {
  bool isnogiate = false;
  var formKey = GlobalKey<FormState>();

  var NameFurnitureController = TextEditingController();

  var DescriptionController = TextEditingController();

  var PriceController = TextEditingController();

  var PlaceController = TextEditingController();

  var datecontroller = TextEditingController();

  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getpermission(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreateFurnitureSuccessState) {
          showToast(
              text: 'furniture created successfuly',
              state: ToastStates.SUCCESS);
          AppCubit.get(context).getFurnitures();
          navigateTo(context, FurnitureScreen());
        }
      },
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        phonecontroller.text = userModel!.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text('Add post for Furniture',),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is AppCreateFurnitureLoadingState)
                      const LinearProgressIndicator(),
                    if (state is AppCreateFurnitureLoadingState)
                      const SizedBox(
                        height: 10,
                      ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${AppCubit.get(context).userModel!.image}',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${AppCubit.get(context).userModel!.name}',
                                    ),
                                    const Icon(
                                      Icons.check_circle,
                                      size: 14,
                                      color: Colors.blue,
                                    ),
                                  ]),
                              Text(
                                'now',
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: NameFurnitureController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Name of Advertisment'
                                    .tr()
                                    .toString();
                              }
                            },
                            label: 'Name'.tr().toString(),
                            prefix: Icons.drive_file_rename_outline,
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          DropdownButtonFormField(
                            items: AppCubit.get(context).AdsFurniture.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              AppCubit.get(context).furniturelist(newValue);
                              // do other stuff with _category
                            },
                            value: AppCubit.get(context).currentfurnitureValue,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'select type of furniture'
                                  .tr()
                                  .toString(),
                            ),
                          ),


                          const SizedBox(
                            height: 10,
                          ),

                          TextField(
                            controller: DescriptionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,

                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.description),
                                hintText: 'describtion'.tr().toString(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),


                          const SizedBox(
                            height: 10,
                          ),

                          DropdownButtonFormField(
                            items: AppCubit.get(context).TypesOfSellingFurniture.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              AppCubit.get(context).typesofsellingfurniturelist(newValue);
                              // do other stuff with _category
                            },
                            value: AppCubit.get(context).CurrentTypesofSellingFurnitureValue,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Exchange or Selling'
                                  .tr()
                                  .toString(),
                            ),
                          ),

                          /*
                          defaultFormField(
                            controller: DescriptionController,
                            type: TextInputType.multiline,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Description';
                              }
                            },
                            label: 'Description',
                            prefix: Icons.description,
                          ),
                          */
                          const SizedBox(
                            height: 8.0,
                          ),
                          /*
                          DropdownButtonFormField(
                            items:
                            AppCubit.get(context).drobdownlist.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              AppCubit.get(context).dropdownlist(newValue);
                              // do other stuff with _category
                            },
                            value: AppCubit.get(context).currentvalue,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText:
                              'select your catergory '.tr().toString(),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                           */
                          Text('negotaiate'.tr().toString()),
                          Checkbox(
                              value: isnogiate,
                              onChanged: (value) {
                                setState(() {
                                  isnogiate = true;
                                });
                              }),
                          const SizedBox(
                            height: 10,
                          ),

                          defaultFormField(
                            controller: PriceController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Price'.tr().toString();
                              }
                            },
                            label: 'Price'.tr().toString(),
                            prefix: Icons.price_change_outlined,
                          ),

                          const SizedBox(
                            height: 8.0,
                          ),

                          // defaultFormField(
                          //   controller: PlaceController,
                          //   onChange: (location) {},
                          //   ontap: () {
                          //     navigateTo(context, MapScreen());
                          //     AppCubit.get(context).getlatAndlang();
                          //   },
                          //   type: TextInputType.text,
                          //   validate: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please Enter place'.tr().toString();
                          //     }
                          //   },
                          //   label: 'select the location'.tr().toString(),
                          //   prefix: Icons.place,
                          // ),

                          defaultFormField(
                            controller: PlaceController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Location'.tr().toString();
                              }
                            },
                            label: 'Place'.tr().toString(),
                            prefix: Icons.location_on_outlined,
                          ),


                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            controller: phonecontroller,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'phone number is reqierd '
                                    .tr()
                                    .toString();
                              }
                            },
                            label: 'phone '.tr().toString(),
                            prefix: Icons.price_change_outlined,
                          ),

                          const SizedBox(
                            height: 10.0,
                          ),
                          TextButton(
                            onPressed: () {
                              AppCubit.get(context).getImages();
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.photo_library_outlined),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Add Photo'.tr().toString(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 300,
                            child: GridView.builder(
                                itemCount:
                                AppCubit.get(context).addImages.length,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return Image.file(
                                    File(AppCubit.get(context)
                                        .addImages[index]
                                        .path),
                                    fit: BoxFit.cover,
                                  );
                                }),
                          ),
                        ],
                      ),
                      //   ],
                    ),
                    // ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (state is PostImagePickedSuccessState) {
                            AppCubit.get(context).uploadFurnitureandimage(
                                Furniture: AppCubit.get(context).furnitureModel.toString(),
                                isnegotiate: false,
                                type: AppCubit.get(context).AdsFurniture.toString(),
                                namefurniture: NameFurnitureController.text,
                                description: DescriptionController.text,
                                price: PriceController.text.toString(),
                                date: DateTime.now().toString());
                          }
                        }
                      },
                      child: Text(
                        'Add Furniture',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

 */