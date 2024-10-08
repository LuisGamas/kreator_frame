import 'package:flutter/material.dart';
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';
import 'package:tex_markdown/tex_markdown.dart';

class LicenseDetailScreen extends StatelessWidget {
  final LicenseEntity licenseEntity;

  const LicenseDetailScreen({super.key, required this.licenseEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          // * App Bar
          CustomSliverAppBarScreens(
            tileText: licenseEntity.name
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // License Deatil
                TexMarkdown(
                  licenseEntity.license,
                )
              ])
            ),
          ),
        ],
      )
    );
  }
}