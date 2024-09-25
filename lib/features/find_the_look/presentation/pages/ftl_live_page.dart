import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/extensions/x_file_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/clippers/face_clipper.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../cubit/product_cart/product_cart_cubit.dart';
import '../widgets/ftl_all_products_list_widget.dart';
import '../widgets/ftl_makeup_widget.dart';
import '../widgets/ftl_small_products_list_widget.dart';

enum LiveType {
  importPhoto,
  importVideo,
  liveCamera,
}

class FTLLivePageParams {
  final XFile? file;

  const FTLLivePageParams({
    required this.file,
  });
}

class FTLLivePage extends StatelessWidget {
  final FTLLivePageParams? params;

  const FTLLivePage({
    super.key,
    this.params,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCartCubit(),
      child: _Body(
        params: params,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final FTLLivePageParams? params;

  const _Body({
    this.params,
  });

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  late LiveStep step;
  late LiveType type;

  bool _isShowSmallProductsList = false;
  bool _isShowAllProductsList = false;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    // default step
    step = LiveStep.photoSettings;
  }

  @override
  Widget build(BuildContext context) {
    Color? screenRecordBackrgoundColor;
    if (_isShowAllProductsList) {
      screenRecordBackrgoundColor = Colors.black;
    }

    return Scaffold(
      body: _buildBody
    );
  }

  Widget get _buildBody {
    /*
    * ubah step ke step berikutnya untuk melanjutkan e.g LiveStep.ScanningFace jika di perlukan
    * */
    switch (step) {
      case LiveStep.photoSettings:
        return Center(child: Text("Web View"),);
      case LiveStep.scanningFace:
        return const SizedBox.shrink();
      case LiveStep.scannedFace:
        if (_isShowSmallProductsList) {
          return BottomCopyrightWidget(
            child: FTLSmallProductsListWidget(
              onViewAll: _onViewAllProducts,
            ),
          );
        }

        if (_isShowAllProductsList) {
          return FTLAllProductsListWidget(
            onBack: () {
              setState(() {
                _isShowAllProductsList = false;
              });
            },
            onTryNow: _onTryNow,
          );
        }

        return BottomCopyrightWidget(
          child: Column(
            children: [
              ButtonWidget(
                text: 'FIND THE LOOK',
                width: context.width / 2,
                backgroundColor: Colors.black,
                onTap: _onFindTheLook,
              ),
            ],
          ),
        );
      case LiveStep.makeup:
        return BottomCopyrightWidget(
          child: FTLMakeupWidget(
            onViewAll: _onViewAllProducts,
          ),
        );
    }
  }

  void _onFindTheLook() {
    setState(() {
      _isShowSmallProductsList = true;
    });
  }

  void _onViewAllProducts() {
    setState(() {
      _isShowSmallProductsList = false;
      _isShowAllProductsList = true;
      step = LiveStep.scannedFace;
    });
  }

  void _onTryNow() {
    // reset all
    setState(() {
      _isShowSmallProductsList = false;
      _isShowAllProductsList = false;
      step = LiveStep.makeup;
    });
  }
}
