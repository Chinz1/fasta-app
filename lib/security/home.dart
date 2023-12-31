import 'package:fasta/colors/colors.dart';
import 'package:fasta/global_widgets/scaffolds/custom_scaffold.dart';
import 'package:fasta/security/change_email.dart';
import 'package:fasta/security/change_password.dart';
import 'package:fasta/security/change_phoneNumber_view.dart';
import 'package:fasta/security/widgets/security_options.dart';
import 'package:fasta/theming/size_config.dart';
import 'package:fasta/typography/text_styles.dart';
import 'package:flutter/material.dart';

class SecurityView extends StatefulWidget {
  static const String route = '/SecurityView';
  const SecurityView({Key? key}) : super(key: key);

  @override
  State<SecurityView> createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      type: AppBarType.empty,
      customAppBar: AppBar(
          backgroundColor: FastaColors.primary2,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: FastaColors.primary,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 56.h,
          ),
          Text(
            'Security',
            style: FastaTextStyle.headline6,
          ),
          SizedBox(
            height: 49.h,
          ),

           GestureDetector(
            onTap: () {
             Navigator.pushNamed(context, ChangeEmailView.route); 
            },
            child: const SecurityOptions(name: 'Change Email')),

            GestureDetector(
              onTap: () {
             Navigator.pushNamed(context, ChangePhoneNumberView.route); 
            },
              child: const SecurityOptions(name: 'Change PhoneNumber')),

          GestureDetector(
              onTap: () {
                 Navigator.pushNamed(context, ChangePassword.route); 
              },
              child: const SecurityOptions(name: 'Change Pin')),
          const SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}
