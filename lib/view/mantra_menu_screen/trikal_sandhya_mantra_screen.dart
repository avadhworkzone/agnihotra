import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';

class TrikalSandhyaMantra extends StatefulWidget {
  const TrikalSandhyaMantra({super.key});

  @override
  State<TrikalSandhyaMantra> createState() => _TrikalSandhyaMantraState();
}

class _TrikalSandhyaMantraState extends State<TrikalSandhyaMantra> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                image:AssetImage(
                  AssetUtils.backgroundImages,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
         Column(
           children: [
             Padding(
               padding:EdgeInsets.only(top: 50.h),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Padding(
                     padding:EdgeInsets.only(left: 12.w),
                     child: CircleAvatar(
                       backgroundColor: ColorUtils.white,
                       radius: 18.r,
                       child: IconButton(
                         onPressed: () {
                           Get.off(SunriseSunetScreen());
                         },
                         icon:  Icon(size: 20.w,
                           AssetUtils.backArrowIcon,
                           color: ColorUtils.orange,
                         ),
                       ),
                     ),
                   ),
                   CustomText(
                     StringUtils.trikalMantraTxt,
                     fontWeight: FontWeight.w500,
                     fontSize: 18.sp,
                   ),
                   SizedBox(width: 12.w)
                 ],
               ),
             ),
             Expanded(
               child: Container(
                 color: Colors.white,
                 width: Get.width,
                 margin: EdgeInsets.symmetric(horizontal: 13.w,vertical: 20.w),
                 // padding: EdgeInsets.symmetric(vertical: 20.w,horizontal: 20.w),
                 child:  SingleChildScrollView(
                   child: Column(
                     children: [
                       CustomText(StringUtils.trikalSandhya,color: ColorUtils.black,fontWeight: FontWeight.w600,fontSize: 13.sp),
                       CustomBtn(
                         height: 35.h,
                         width: 110.w,
                         radius: 30,
                         gradient: const LinearGradient(
                           colors: [
                             ColorUtils.gridentColor1,
                             ColorUtils.gridentColor2,
                           ],
                           begin: AlignmentDirectional.topEnd,
                           end: AlignmentDirectional.bottomEnd,
                         ),
                         onTap: () {},
                         title:StringUtils.mantra24,
                         fontSize: 15.sp,
                       ),
                       SizedBox(height: 15.w),
                       commonRowWidget(number: '1',firstTitle: 'गुरूप्रार्थना',secondTitle: ' : ॐ श्रीगुरूभ्यो नमः हरिः ॐ ॥'),
                       const Divider(),
                       // SizedBox(height: 15.w),
                       commonRowWidget(number: '2',secondTitle: ' चन्दन / भस्म धारणम'),
                       const Divider(),
                       commonRowWidget(number: '3',firstTitle: 'आचमनम् ',secondTitle: '(Drink Water)',fontWeight: FontWeight.w500),
                       Row(
                        children: [
                          SizedBox(width: 60.w),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText('ॐ अच्युताय नमः।\nॐ अनन्ताय नमः|\nॐ गोविन्दाय नमः।',color: ColorUtils.black,fontWeight: FontWeight.w500))
                        ],
                      ),
                       const Divider(),
                       commonRowWidget(number: '4',firstTitle: 'मार्जनम् ',secondTitle: '(Sprinkling Water on Head)',fontWeight: FontWeight.w500),
                       Row(
                         children: [
                           SizedBox(width: 60.w),
                           const Align(
                               alignment: Alignment.centerLeft,
                               child: CustomText('ॐ अपवित्रः पवित्रो वा सर्वावस्थां गतोपि वा ।\nयः स्मरेत् पुण्डरीकाक्षं स बाह्याभ्यन्तरः शुचिः ॥',color: ColorUtils.black,fontWeight: FontWeight.w500))
                         ],
                       ),
                       const Divider(),
                       commonRowWidget(number: '5',firstTitle: 'प्राणायमः '),
                       Row(
                         children: [
                           SizedBox(width: 60.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [
                                  CustomText('प्रणवस्य परब्रह्म ऋषिः',color: ColorUtils.black,fontWeight: FontWeight.w500,fontSize: 12.sp),
                                  CustomText('(Touch the Head)',color: ColorUtils.black,fontWeight: FontWeight.w500,fontSize: 9.sp),
                                 ],
                                ),
                                Row(
                                  children: [
                                  CustomText('देवी गायत्री छन्दः',color: ColorUtils.black,fontWeight: FontWeight.w500,fontSize: 12.sp),
                                  CustomText('(Touch the Nose)',color: ColorUtils.black,fontWeight: FontWeight.w500,fontSize: 9.sp),
                                 ],
                                ),
                                Row(
                                  children: [
                                  CustomText('परमात्म देवता',color: ColorUtils.black,fontWeight: FontWeight.w500,fontSize: 12.sp),
                                  CustomText('(Touch the Heart)',color: ColorUtils.black,fontWeight: FontWeight.w500,fontSize: 9.sp),
                                 ],
                                ),
                                CustomText('प्राणायामे विनियोगः (5 Round)',color: ColorUtils.orange,fontWeight: FontWeight.w600,fontSize: 13.sp),
                                 CustomText('भूः भुवः ॐ स्वः ॐ महः ॐ जनः ॐ तपः ॐ सत्यं\nॐ तत्सवितुर्वरेण्यं भर्गो देवस्य धीमहि धियो यो नः प्रचोदयात्\nॐ आपो ज्योतिः रसोमृतं ब्रह्म भूर्भुवः स्वर् ॐ',fontWeight: FontWeight.w500,fontSize: 12.sp,color: ColorUtils.black)
                              ],
                            )
                         ],
                       ),
                       const Divider(),
                       commonRowWidget(number: '6',firstTitle: 'सङ्कल्पः ',secondTitle: '(Hands with sandwiched palms on right knee)',fontWeight: FontWeight.w500,fontSize: 9.sp),
                       Row(children: [
                         SizedBox(width: 40.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                           children: [
                             commonRowWidget(secondTitle: 'ममोपात्त समस्त दुरितक्षयद्वारा श्रीपरमेश्वर प्रीत्यर्थं',fontSize: 12.sp,fontWeight: FontWeight.w500,verticalPadding:0),

                             commonRowWidget(firstTitle: 'सुबह :\n''',secondTitle: ' प्रातः सन्ध्यां समिदाधानम् च\n माध्याह्निकं',fontWeight: FontWeight.w500,verticalPadding:0),
                             commonRowWidget(firstTitle: 'शाम :',secondTitle: ' सायं सन्ध्यां समिदाधानम् चकरिष्ये',fontWeight: FontWeight.w500,verticalPadding:0)
                           ],
                          )
                         ],
                       ),
                       const Divider(),
                       commonRowWidget(number: '7',firstTitle: 'मार्जनम् ',secondTitle: ' (Hands with sandwiched palms on right knee)',fontWeight: FontWeight.w500,fontSize: 9.sp),
                      Row(children: [
                        SizedBox(width: 40.w),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                         commonRowWidget(secondTitle: 'ॐ आपोहिष्ठा मयोभुवः ता न ऊर्जे दधातन ।\nमहेरणाय चक्षसे ॥',fontSize: 12.sp,fontWeight: FontWeight.w500,verticalPadding:0),
                         commonRowWidget(secondTitle: 'योवः शिवतमो रसः तस्यii भाजयतेह नः ।\nउशतीरिव मातर: ॥',fontSize: 12.sp,fontWeight: FontWeight.w500,verticalPadding:0),
                         commonRowWidget(secondTitle: 'तस्मा अरङ्गमाम वः यस्य क्षयाय जिन्वथ ।\nआपो जनयथा च नः ॥',fontSize: 12.sp,fontWeight: FontWeight.w500,verticalPadding:0),],)
                       ],
                      ),
                       const Divider(),
                       commonRowWidget(number: '8',firstTitle: 'अपः प्राशनम् ',secondTitle: ' (Water in right hand)',fontWeight: FontWeight.w500,fontSize: 9.sp),
                       Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 60.w),
                         Column(
                          children: [
                          CustomText('सुबह :   ',color: ColorUtils.orange,fontWeight: FontWeight.w500,fontSize: 12.sp,)
                         ],
                        ),
                          Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             commonRowWidget(secondTitle: 'सूर्यश्च मा मन्युश्च मन्युपतयश्च मन्युकृतेभ्यः\nपापेभ्यों रक्षन्ताम् । यदात्र्या पापमकार्षम् ।।',verticalPadding: 0,fontWeight: FontWeight.w500,fontSize: 12.sp,horizontalPadding:0),
                             commonRowWidget(secondTitle: 'मनसा वाचा हस्ताभ्याम् । पद्भयाम् उदरेण शिश्ना ।\nरात्रिस्तदवलुम्पतु । यत्किञ्च दुरितम् मयि ।',verticalPadding: 0,fontWeight: FontWeight.w500,fontSize: 12.sp,horizontalPadding:0),
                             commonRowWidget(secondTitle: 'रात्रिस्तदवलुम्पतु । यत्किञ्च दुरितम् मयि ।\nइदमहं मासमृत योनौ । सूर्ये ज्योतिषि जुहोमि स्वाहा ||',verticalPadding: 0,fontWeight: FontWeight.w500,fontSize: 12.sp,horizontalPadding:0),
                         ],
                        )
                       ],
                      ),
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(width: 60.w),
                           Column(
                             children: [
                               CustomText('दोपहर : ',color: ColorUtils.orange,fontWeight: FontWeight.w500,fontSize: 12.sp,)
                             ],
                           ),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               commonRowWidget(secondTitle: 'आपः पुनन्तु पृथिवीं पृथिवी पूता पुनातुमाम् ।\nपुनन्तु ब्रह्मणस्पतिः ब्रह्म पूता पूनातु माम् ॥',verticalPadding: 0,fontWeight: FontWeight.w500,fontSize: 12.sp,horizontalPadding:0),
                               commonRowWidget(secondTitle: 'यदुच्छिष्टम् अभोज्यं यद्वा दुश्चरितं मम ।\nसर्वं पुनन्तु माम् अपोसतां च प्रतिग्रहं स्वाहा ॥',verticalPadding: 0,fontWeight: FontWeight.w500,fontSize: 12.sp,horizontalPadding:0),
                             ],
                           )
                         ],
                       ),
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(width: 60.w),
                           Column(
                             children: [
                               CustomText('शाम :   ',color: ColorUtils.orange,fontWeight: FontWeight.w500,fontSize: 12.sp,)
                             ],
                           ),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               commonRowWidget(secondTitle: 'अग्निश्च मा मन्युश्च मन्युपतयश्च मन्युकृतेभ्यः\nपापेभ्यो रक्षन्ताम् । यदह्नया पापमकार्षम् ॥',verticalPadding: 0,fontWeight: FontWeight.w500,fontSize: 12.sp,horizontalPadding:0),
                               commonRowWidget(secondTitle: 'मनसा वाचा हस्ताभ्याम् । पद्रयाम् उदरेण शिश्ना ।\nअहस्तदवलुम्पतु । यत्किञ्च दुरितम् मयि ।',verticalPadding: 0,fontWeight: FontWeight.w500,fontSize: 12.sp,horizontalPadding:0),
                               commonRowWidget(secondTitle: 'इदमहं माममृत योनौ ।\nसत्ये ज्योतिषि जुहोमि स्वाहा ॥',verticalPadding: 0,fontWeight: FontWeight.w500,fontSize: 12.sp,horizontalPadding:0),
                             ],
                           )
                         ],
                       ),
                       commonRowWidget(number: '9',firstTitle: 'पुनर्मार्जनम् ',secondTitle: ' (Sprinkling water on Head)',fontWeight: FontWeight.w500,fontSize: 9.sp),
                       Row(children: [
                         SizedBox(width: 40.w),
                         commonRowWidget(secondTitle: 'दधिक्रावण्णो अकारिशम् । जिरणो रश्वस्य वाजिनः । \nसुरभिनो मुखाकरत् प्रन आयो शितारिशत ।',fontWeight: FontWeight.w500,fontSize: 12.sp),
                       ],),
                       const Divider(),
                       commonRowWidget(number: '10',firstTitle: 'पुनर्मार्जनम् ',secondTitle: ' (Sprinkling water on Head)',fontWeight: FontWeight.w500,fontSize: 9.sp),
                     ],
                   ),
                 ),
               ),
             )
           ],
          )
        ],
      ),
    );
  }

  commonRowWidget({String? number,String? firstTitle,String? secondTitle,FontWeight? fontWeight,double? fontSize,double? verticalPadding,double? horizontalPadding}){
   return Padding(
     padding : EdgeInsets.symmetric(horizontal: horizontalPadding??20.w,vertical: verticalPadding??5.w),
     child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          number==null?const SizedBox(): CustomBtn(
            height: 25.h,
            width: 25.w,
            radius: 30,
            gradient: const LinearGradient(
              colors: [
                ColorUtils.gridentColor1,
                ColorUtils.gridentColor2,
              ],
              begin: AlignmentDirectional.topEnd,
              end: AlignmentDirectional.bottomEnd,
            ),
            onTap: () {},
            title:number,
            fontSize: 15.sp,
          ),
          number==null?const SizedBox(): SizedBox(width: 15.w),
          firstTitle==null?Container(
              color: Colors.red,
              child: const SizedBox()): CustomText(firstTitle,color: ColorUtils.orange,fontWeight: FontWeight.w600,fontSize: 13.sp),
          CustomText(secondTitle??'',color: ColorUtils.black,fontWeight: fontWeight??FontWeight.w600,
            fontSize: fontSize??13.sp,maxLines: 2),
        ],
      ),
   );
  }
}
