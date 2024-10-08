import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';

class PFAttributesAnalysisWidget extends StatelessWidget {
  const PFAttributesAnalysisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: SizeConfig.horizontalPadding,
      ),
      child: Column(
        children: [
          const _BodyItemWidget(
            title: "Face",
            iconPath: IconPath.face,
            leftChildren: [
              _DetailBodyItem(
                title: "Face Shape",
                value: "Heart",
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Skin Tone",
                value: "Dark latte",
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          const _BodyItemWidget(
            title: "Eyes",
            iconPath: IconPath.eye,
            leftChildren: [
              _DetailBodyItem(
                title: "Eye Shape",
                value: "Almond",
              ),
              _DetailBodyItem(
                title: "Eye Angle",
                value: "Heart",
              ),
              _DetailBodyItem(
                title: "Eyelid",
                value: "Droopy",
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Eye Size",
                value: "Bid",
              ),
              _DetailBodyItem(
                title: "Eye Distance",
                value: "Wide-Set",
              ),
              _DetailBodyItem(
                title: "Eye Color",
                value: "Green",
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Brows",
            iconPath: IconPath.brow,
            leftChildren: const [
              _DetailBodyItem(
                title: "Eyebrow Shape",
                value: "Rounded",
              ),
              _DetailBodyItem(
                title: "Eyebrow Distance",
                value: "Average",
              ),
            ],
            rightChildren: [
              const _DetailBodyItem(
                title: "Thickness",
                value: "Average",
              ),
              _DetailBodyItem(
                title: "Eyebrow color",
                valueWidget: Container(
                  height: 28,
                  color: const Color(0xFF473209),
                ),
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Lips",
            iconPath: IconPath.lip,
            leftChildren: const [
              _DetailBodyItem(
                title: "Lip shape",
                value: "Full",
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Lip color",
                valueWidget: Container(
                  height: 28,
                  color: const Color(0xFF473209),
                ),
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          const _BodyItemWidget(
            title: "Cheekbones",
            iconPath: IconPath.cheekbones,
            leftChildren: [
              _DetailBodyItem(
                title: "Cheekbones",
                value: "Flat cheekbones",
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          const _BodyItemWidget(
            title: "Nose",
            iconPath: IconPath.nose,
            leftChildren: [
              _DetailBodyItem(
                title: "Nose Shape",
                value: "Broad",
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Hair",
            iconPath: IconPath.hair,
            leftChildren: [
              _DetailBodyItem(
                title: "Face Shape",
                valueWidget: Container(
                  height: 28,
                  color: const Color(0xFF473209),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodyItemWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final List<Widget> leftChildren;
  final List<Widget> rightChildren;

  const _BodyItemWidget({
    required this.iconPath,
    required this.title,
    this.leftChildren = const [],
    this.rightChildren = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.4,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: leftChildren.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return leftChildren[index];
                },
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.4,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: rightChildren.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return rightChildren[index];
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DetailBodyItem extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;

  const _DetailBodyItem({
    required this.title,
    this.value,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        if (valueWidget != null) ...[
          const SizedBox(
            height: 4,
          ),
          valueWidget!,
        ],
        if (value != null) ...[
          const SizedBox(
            height: 4,
          ),
          Text(
            "• $value",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }
}
