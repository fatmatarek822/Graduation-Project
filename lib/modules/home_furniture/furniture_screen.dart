/*
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realestateapp/models/furniture_model.dart';
import 'package:realestateapp/modules/cubit/cubit.dart';
import 'package:realestateapp/modules/cubit/states.dart';
import 'package:realestateapp/modules/home_furniture/furniture_details.dart';
import 'package:realestateapp/modules/home_furniture/new_furniture.dart';
import 'package:realestateapp/shared/components/components.dart';
import 'package:realestateapp/shared/components/constant.dart';

class FurnitureScreen extends StatelessWidget {
    FurnitureScreen({Key? key}) : super(key: key);
  PageController AdsImages = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () {
                navigateTo(context, NewHomeFurniture());
              },
              child: const Icon(Icons.add),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ConditionalBuilder(
                  condition: AppCubit.get(context).furnitureModel.length > 0 &&
                      AppCubit.get(context).userModel != null,
                  builder: (context) => Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                            onTap: (() {
                              navigateTo(
                                  context,
                                  FurnitureDetails(
                                      model: AppCubit.get(context)
                                          .furnitureModel[index]
                                        )
                              );
                            }),
                            child: BuildFurniture(
                                AppCubit.get(context).furnitureModel[index],
                                context,
                                index)),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: AppCubit.get(context).furnitureModel.length,
                      ),
                    ],
                  ),
                  fallback: (context) =>
                  AppCubit.get(context).furnitureModel.length == 0
                      ? Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          image: NetworkImage(
                              'https://correspondentsoftheworld.com/images/elements/clear/undraw_Content_structure_re_ebkv_clear.png'),
                          height: 300,
                          width: 380,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          ' you have no furnitureModel  '.tr().toString(),
                          style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),

          ),
        );
      });
  }


  Widget BuildFurniture(
      FurnitureModel furnituremodel,
      context,
      index,
      ) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: appPadding, vertical: appPadding / 2),
          child: Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 400.0,
                        height: 200.0,
                        child: PageView.builder(
                          controller: AdsImages,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Image(
                            image: NetworkImage('${furnituremodel.furnitureImage![index]}'),
                            width: 400.0,
                            height: 100.0,
                          ),
                          itemCount: furnituremodel.furnitureImage!.length,
                        ),
                      ),
                    ),
                    Positioned(
                      right: appPadding / 2,
                      top: appPadding / 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15)),
                        /*
                        child: IconButton(
                          icon: AppCubit.get(context).favorites.length == 0
                              ? const Icon(
                            Icons.favorite_rounded,
                          )
                              : const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            AppCubit.get(context).favorites.length == 0
                                ? AppCubit.get(context).addtofav(
                              AppCubit.get(context).furnitureModel[index],
                            )
                                : showToast(
                                text: 'aleardy added',
                                state: ToastStates.WARNING);
                          },
                        ),

                         */
                      ),
                    )
                  ],
                ),

                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.wysiwyg_outlined),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                            '${furnituremodel.namefurniture}'
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.category_outlined),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                            '${furnituremodel.furniture}'
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.price_change_outlined),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                            '${furnituremodel.price}'
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                            '${furnituremodel.place}'
                        ),
                      ],
                    ),
                  ],
                )

                /*
                Row(
                  children: [
                    Text(
                      '${model.namefurniture}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Expanded(
                    //   child: Text(
                    //     '${model.description}',
                    //     overflow: TextOverflow.ellipsis,
                    //     style: TextStyle(
                    //         fontSize: 15, color: black.withOpacity(0.4)),
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${model.namefurniture} bedrooms / ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${model.namefurniture} bathrooms / ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${model.namefurniture} sqft',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.price_check_rounded),
                    Text(
                      '${model.price} Eg',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )

                 */
              ],
            ),
          ),
        ),
      ),
    );
  }

}


 */