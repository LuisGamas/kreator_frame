// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

// 🌎 Project imports:
import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

class LicenseDetailScreen extends StatelessWidget {
  final LicenseEntity licenseEntity;

  const LicenseDetailScreen({super.key, required this.licenseEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CustomSliverAppBarScreens(
            tileText: licenseEntity.name
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final license = licenseEntity.licenses[index];
              return _CustomLicenseBody(
                title: license,
              );
            },
            childCount: licenseEntity.licenses.length
            )
          ),
        ],
      )
    );
  }
}

class _CustomLicenseBody extends StatelessWidget {
  final String title;

  const _CustomLicenseBody({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      splashColor: colors.secondaryContainer,
      textColor: colors.onSurface,
      title: MarkdownBody(
        data: title,
      ),
      titleTextStyle: textStyles.titleMedium,
      subtitleTextStyle: textStyles.bodySmall,
      subtitle: const Divider(
        height: 50,
      ),
    );
  }
}
