import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';


class TrikalSandhyaMantra extends StatefulWidget {
  const TrikalSandhyaMantra({super.key});

  @override
  State<TrikalSandhyaMantra> createState() => _TrikalSandhyaMantraState();
}

class _TrikalSandhyaMantraState extends State<TrikalSandhyaMantra> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetUtils.backgroundImages,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: CircleAvatar(
                        backgroundColor: ColorUtils.white,
                        radius: 18.r,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            size: 20.w,
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
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                  child: Container(
                    color: Colors.white,
                    width: Get.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomText(StringUtils.trikalSandhya,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp),
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
                            title: StringUtils.mantra24,
                            fontSize: 15.sp,
                          ),
                          SizedBox(height: 15.w),
                          commonRowWidget(
                              number: '1',
                              firstTitle: 'गुरूप्रार्थना',
                              secondTitle: ' : ॐ श्रीगुरूभ्यो नमः हरिः ॐ ॥'),
                          const Divider(),
                          // SizedBox(height: 15.w),
                          commonRowWidget(
                              number: '2', secondTitle: ' चन्दन / भस्म धारणम्'),
                          const Divider(),
                          commonRowWidget(
                              number: '3',
                              firstTitle: 'आचमनम् ',
                              secondTitle: '(Drink Water)',
                              fontWeight: FontWeight.w500),
                          Row(
                            children: [
                              SizedBox(width: 60.w),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(
                                      'ॐ अच्युताय नमः।\nॐ अनन्ताय नमः|\nॐ गोविन्दाय नमः।',
                                      color: ColorUtils.black,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '4',
                              firstTitle: 'मार्जनम् ',
                              secondTitle: '(Sprinkling Water on Head)',
                              fontWeight: FontWeight.w500),
                          Row(
                            children: [
                              SizedBox(width: 60.w),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(
                                      'ॐ अपवित्रः पवित्रो वा सर्वावस्थां गतोपि वा ।\nयः स्मरेत् पुण्डरीकाक्षं स बाह्याभ्यन्तरः शुचिः ॥',
                                      color: ColorUtils.black,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '5', firstTitle: 'प्राणायमः '),
                          Row(
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomText('प्रणवस्य परब्रह्म ऋषिः',
                                          color: ColorUtils.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                      CustomText('(Touch the Head)',
                                          color: ColorUtils.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 9.sp),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText('देवी गायत्री छन्दः',
                                          color: ColorUtils.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                      CustomText('(Touch the Nose)',
                                          color: ColorUtils.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 9.sp),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomText('परमात्म देवता',
                                          color: ColorUtils.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                      CustomText('(Touch the Heart)',
                                          color: ColorUtils.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 9.sp),
                                    ],
                                  ),
                                  CustomText('प्राणायामे विनियोगः (5 Round)',
                                      color: ColorUtils.orange,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp),
                                  CustomText(
                                      'ॐ भुः ॐ भुवः ॐ स्वः  ॐ महः ॐ जनः ॐ तपः ॐ सत्यं\nॐ तत्सवितुर् वरेण्यं भर्गो देवस्य धीमहि धियो यो नः प्रचोदयात्\nॐ आपो ज्योतिः रसोमृतं ब्रह्म भूर्भुवः स्वर् ॐ',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: ColorUtils.black)
                                ],
                              )
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '6',
                              firstTitle: 'सङ्कल्पः ',
                              secondTitle:
                                  '(Hands with sandwiched palms on right knee)',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            children: [
                              SizedBox(width: 40.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonRowWidget(secondTitle: 'ममोपात्त समस्त दुरितक्षयद्वारा श्रीपरमेश्वर प्रीत्यर्थं', fontSize: 12.sp, fontWeight: FontWeight.w500, verticalPadding: 0),
                                  SizedBox(height: 5.h,),
                                  commonRowWidget(firstTitle: 'सुबह :' '', secondTitle: 'प्रातः सन्ध्यां समिदाधानम् च', fontWeight: FontWeight.w500, verticalPadding: 0),
                                  SizedBox(height: 5.h,),
                                  commonRowWidget(firstTitle: 'दोपहर : :', secondTitle: 'माध्याह्निकं', fontWeight: FontWeight.w500, verticalPadding: 0),
                                  SizedBox(height: 5.h,),

                                  commonRowWidget(firstTitle: 'शाम :', secondTitle: 'सायं सन्ध्यां समिदाधानम् च करिष्ये', fontWeight: FontWeight.w500, verticalPadding: 0)
                                ],
                              )
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '7',
                              firstTitle: 'मार्जनम् ',
                              secondTitle: '(Sprinkling Water on Head) ',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            children: [
                              SizedBox(width: 40.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ आयो हिष्ठा मयोभुवः ता न ऊर्जे दधातन ।\nमहेरणाय चक्षसे ॥',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      verticalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'योवः शिवतमो रसः तस्य भाजयतेह नः ।\nउशतीरिव मातर: ॥',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      verticalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'तस्मा अरङ्गमाम वः यस्य क्षयाय जिन्वथ ।\nआपो जनयथा च नः ॥',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      verticalPadding: 0),
                                ],
                              )
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '8',
                              firstTitle: 'अपः प्राशनम् ',
                              secondTitle: ' (Water in right hand)',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                children: [
                                  CustomText(
                                    'सुबह :   ',
                                    color: ColorUtils.orange,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'सूर्यश्च मा मन्युश्च मन्युपतयश्च मन्युकृतेभ्यः\nपापेभ्यों रक्षन्ताम् । यदात्र्या पापमकार्षम् ।।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'मनसा वाचा हस्ताभ्याम् । पद्भयाम् उदरेण शिश्ना ।\nरात्रिस्तदवलुम्पतु । यत्किञ्च दुरितम् मयि ।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'रात्रिस्तदवलुम्पतु । यात्किञ्च दुरितम् मयि ।\nइदमहं मासमृत योनौ । सूर्ये ज्योतिषि जुहोमि स्वाहा ||',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
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
                                  CustomText(
                                    'दोपहर : ',
                                    color: ColorUtils.orange,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'आपः पुनन्तु पृथिवीं पृथिवी पूता पुनातुमाम् ।\nपुनन्तु ब्रह्मणस्पतिः ब्रह्म पूता पूनातु माम् ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'यदुच्छिष्टम् अभोज्यं यद्वा दुश्चरितं मम ।\nसर्वं पुनन्तु माम् अपोसतां च प्रतिग्रहं स्वाहा ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
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
                                  CustomText(
                                    'शाम :   ',
                                    color: ColorUtils.orange,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'अग्निश्च मा मन्युश्च मन्युपतयश्च मन्युकृतेभ्यः\nपापेभ्यो रक्षन्ताम् । यदह्नया पापमकार्षम् ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'मनसा वाचा हस्ताभ्याम् । पद्रयाम् उदरेण शिश्ना ।\nअहस्तदवलुम्पतु । यत्किञ्च दुरितम् मयि ।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'इदमहं माममृत योनौ । \nसत्ये ज्योतिषि जुहोमि स्वाहा ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              )
                            ],
                          ),
                          commonRowWidget(
                              number: '9',
                              firstTitle: 'पुनर्मार्जनम् ',
                              secondTitle: ' (Sprinkling water on Head)',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            children: [
                              SizedBox(width: 40.w),
                              commonRowWidget(
                                  secondTitle:
                                      'दधिक्रावण्णो अकारिशम् । जिरणो रश्वस्य वाजिनः । \nसुरभिनो मुखाकरत् प्रन आयो शितारिशत ।',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '10',
                              firstTitle: 'अर्ध्य प्रदानम्  ',
                              secondTitle: ' (3 time Gayatri Mantra)',
                              thirdTitle: '(Water Oblations)',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ भूर्भुवस्वः तत् सवितुर्वरेण्यं\nभर्गोदेवस्य धीमहि धियो यो नः प्रचोदयात् ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  SizedBox(height: 5.h),
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ आदित्यादि नवग्रह देवतान् तर्पयामि\nॐ केशवादि सर्व देवतान् तर्पयामि',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ अत्रि आदि सप्तऋशयान् तर्पयामि',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '11',
                              firstTitle: 'गायत्री आवाहनम ',
                              secondTitle: '(avahan mudra)',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'आयातु वरदा देवी अक्षरं ब्रह्मसम्मितम् ।\nगायत्री छन्दसां माता इदं ब्रह्म जुषस्व नः ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'ओजोसि। सहोसि। बलमसि । भ्राजोसि । देवानां धामं नामासि ।\nविश्वमसि। विश्वायुः। सर्वमसि । सर्वायुः । अभिभुवर ॐ ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  SizedBox(height: 5.h),
                                  commonRowWidget(
                                      secondTitle:
                                          'गायत्री आवाहयामि\nसावित्रीं आवाहयामि ',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle: 'सरस्वतीं आवाहयामि',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '12',
                              firstTitle: 'गायत्री जप:',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 60.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        'गायत्र्या',
                                        color: ColorUtils.black,
                                      ),
                                      CustomText(
                                        'विश्वामित्रः ऋषिः',
                                        color: ColorUtils.black,
                                      ),
                                      CustomText(
                                        'गायत्री छन्दः',
                                        color: ColorUtils.black,
                                      ),
                                      CustomText(
                                        'सविता देवता',
                                        color: ColorUtils.black,
                                      ),
                                      CustomText(
                                        'गायत्री जपे विनियोगः',
                                        color: ColorUtils.black,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        '',
                                        color: ColorUtils.black,
                                      ),
                                      CustomText(
                                        '(Touch the Head)',
                                        color: ColorUtils.black,
                                      ),
                                      CustomText(
                                        '(Touch the Nose)',
                                        color: ColorUtils.black,
                                      ),
                                      CustomText(
                                        '(Touch the Heart)',
                                        color: ColorUtils.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 15.w, right: 15.w),
                                child: CustomText(
                                  '(Meditate for Few Minutes, Start the gayatri japa and after that Meditate for some time)',
                                  color: ColorUtils.black,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const Divider(),
                          commonRowWidget(
                              number: '13',
                              firstTitle: 'दिग्देवता नमस्कारः',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          commonRowWidget(
                              secondTitle:
                                  '(Stand up, bow towards the four direction)',
                              verticalPadding: 0,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              horizontalPadding: 50),
                          SizedBox(height: 10.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle: 'सन्ध्यायै नमः  - East',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle: 'सावित्रे नमः  - South',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle: 'गायत्रै नमः  - West',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle: 'सरस्वत्यै नमः  - North',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'सर्वाभ्यो देवताभ्यो नमः  - East',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'कामोकार्षीत मन्युकार्षीत नमो नमः   - East',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '14',
                              firstTitle: 'प्रार्थनम्',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'उत्तमे शिखरे देवी भूम्याम् पर्वत मूर्धनी ।\nब्राह्मनेभ्यो हि अनुज्ञानम् गञ्च देवी यथा सुखम्',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'आकाशात् पतितं तोयं यथा गच्छति सागरम् ।\nसर्वादेवनमस्कारः केशवं प्रतिगच्छति ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '15',
                              firstTitle: 'अग्न्याधानं ',
                              secondTitle: '(Light the Fire)',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle: 'ॐ भूर्भुवस्वः ।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '16',
                              firstTitle: ' जलप्रषेचनं  ',
                              secondTitle: '(Pour Water in Following Directions)',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ अदितेनुमन्यस्व ।।\nॐ अनुमतेनुमन्यस्व ||',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ सरस्वतेनुमन्यस्व ।\nॐ देवः सवितः प्रसुवः ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                              SizedBox(width: 50.w,),
                              LocalAssets(imagePath: AssetUtils.directionImage,),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '17',
                              firstTitle: ' समिदाधानम्   ',
                              secondTitle: '(Offer Samidha)',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ भूरग्नये प्राणाय स्वाः |\nॐ भुवर्वायवे र्अपानाय स्वाः ।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ स्वरादित्याय व्यानाय स्वाः ।\nॐ भूर्भुवसुवः प्रजापतये स्वाः ।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '18',
                              firstTitle: 'समिदाधानम  ',
                              secondTitle: '(3/7/11 Times)',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ भूर्भुवस्वः तत् सवितुर्वरेन्यम्\nभर्गोदेवस्य धीमहि धियो यो नः प्रचोदयात् स्वाः ।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle: '(1 Times)',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  commonRowWidget(
                                      secondTitle:
                                          'अग्ने नय सुपथा राये अस्मान विश्वानि देव वयुनानि विद्वान ।\nयुयोध्यस्म ज्जुहुराणमेनो भूयिष्ठाम ते नम उक्तिम् विधेम स्वाः।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '19',
                              firstTitle: 'जलप्रषेचनं',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ अदितेन्वमंस्ताः ॥ (pronounce as : अदितेन्वमग्गुस्ताः)',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ अनुमतेन्वमंस्ताः ॥ (pronounce as : अनुमतेन्वमग्गुस्ताः)',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ सरस्वतेन्वमंस्ताः ||(pronounce as  : सरस्वतेन्वमग्गुस्ताः)',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle: 'ॐ देव सवितः प्रासावीः ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '20',
                              firstTitle: 'प्रार्थना',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ मयि मेधां मयि प्रजां मय्यग्निस्तेजो दधातु । \nॐ मयि मेधां मयि प्रजां मयीन्द्र इन्द्रियं दधातु ।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ मयि मेधां मयि प्रजां मयि सूर्यो भ्राजो दधातु ।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  SizedBox(height: 10.h),
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ यत्ते अग्नेेे तेजस्तेनाहं तेजस्वी भूयासम् ।\nॐ यत्ते अग्रे वर्चस्तेनाहं वर्चस्वी भूयासम् ।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ यत्ते अग्ने हरस्तेनाहं हरस्वी भूयासम् ।\nॐ स्वस्ति श्रद्धां मेधां यशः प्रज्ञां विद्यां बुद्धिं श्रियं बलम',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'आयुष्यं तेज आरोग्यं देहि मे हव्यवाहन ||',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '21',
                              firstTitle: ' गोत्र प्रवरम्',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'शिव  ',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: ColorUtils.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '(काश्यप)',
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: ColorUtils.black,

                                          ),
                                        ),
                                        TextSpan(
                                          text: ' गोत्रोत्पन्नः ',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorUtils.black,

                                          ),
                                        ),
                                        TextSpan(
                                          text: '(SANDIP)',
                                          style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: ColorUtils.black,

                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' शर्मणः/\nदेवि अहं भो अभिवादये',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorUtils.black,

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '22',
                              firstTitle: 'भस्म धारन',
                              secondTitle: '(Apply Ashes)',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ मानस्तोके तनये मान आयुषि मानो गोषु मानो अश्वेषु रीरिषः।',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'वीरान मानो रूद्रभामितो वर्धीहविष्मन्तो नमसा विधेम ते ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'मेधावी भूयासम\t  On fore head(third eye)',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'तेजस्वी भूयासम् \t  On Chest (Heart region)',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'वर्चस्वी भूयासम् \t  Right Shoulder',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'ब्रह्मवर्चस्वी भूयासम\t Left Shoulder',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'आयुष्यमान् भूयासम्\t Navel Region',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'अन्नादो भूयासम्\t On Throat',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'स्वस्ति भूयासम्\t Top of the head',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '23',
                              firstTitle: 'प्रायश्चित्तः',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 60.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Positioned(
                                        bottom: 2.h,
                                        right: 130.w,
                                        child: Row(
                                          children: [
                                            CustomText(
                                              '@noon',
                                                fontSize: 12.sp,
                                                color: ColorUtils.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:EdgeInsets.only(top: 10.h),
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'मन्त्रहीनं क्रियाहीनं भक्तिहीनं हुताशन/ ',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: ColorUtils.black,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'जनार्दन',
                                                style: TextStyle(
                                                  decoration: TextDecoration.underline,
                                                  color: ColorUtils.black,

                                                ),
                                              ),
                                              TextSpan(
                                                text: ' | \nयद् हुतं ',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: ColorUtils.black,

                                                ),
                                              ),
                                              TextSpan(
                                                text: 'कृतं',
                                                style: TextStyle(
                                                  decoration: TextDecoration.underline,
                                                  color: ColorUtils.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' तु मया देव परिपूर्णं तदस्तु ते ।।\n',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: ColorUtils.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 44.h,
                                        child: Row(
                                          children: [
                                            CustomText(
                                              '@noon',
                                              fontSize: 12.sp,
                                              color: ColorUtils.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // commonRowWidget(
                                  //     secondTitle: 'मन्त्रहीनं क्रियाहीनं भक्तिहीनं हुताशन/ जनार्दन |\nयद् हुतं कृतं तु मया देव परिपूर्णं तदस्तु ते ।।',
                                  //     verticalPadding: 0,
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 12.sp,
                                  //     horizontalPadding: 0,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          commonRowWidget(
                              number: '24',
                              firstTitle: 'समर्पण',
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 60.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  commonRowWidget(
                                      secondTitle:
                                          '(Surrendering all our actions thought & their results,\noffering water)',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  commonRowWidget(
                                      secondTitle:
                                          'कायेन वाचा मनसेन्द्रियैर्वा बुध्यात्मना वा प्रकृतेः स्वाभावात् ।\nकरोमि यद्यत् सकलं परस्मै नारायणायेति समर्पयामि ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle:
                                          'ॐ तत् सत् ब्रह्मार्पणमस्तु ।\nसर्वं समर्पयामि ||',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                  commonRowWidget(
                                      secondTitle: 'श्रीगुरुचरणकमलेभ्यो नमः ॥',
                                      verticalPadding: 0,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      horizontalPadding: 0),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  commonRowWidget(
      {String? number,
      String? firstTitle,
      String? secondTitle,
      String? thirdTitle,
      FontWeight? fontWeight,
      double? fontSize,
      double? verticalPadding,
      double? horizontalPadding}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 20.w,
          vertical: verticalPadding ?? 5.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          number == null
              ? const SizedBox()
              : CustomBtn(
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
                  title: number,
                  fontSize: 15.sp,
                ),
          number == null ? const SizedBox() : SizedBox(width: 15.w),
          firstTitle == null
              ? Container(color: Colors.red, child: const SizedBox())
              : CustomText(firstTitle,
                  color: ColorUtils.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp),
          CustomText(secondTitle ?? '',
              color: ColorUtils.black,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontSize: fontSize ?? 13.sp,
              maxLines: 2),
          CustomText(thirdTitle ?? '',
              color: ColorUtils.black,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontSize: fontSize ?? 13.sp,
              maxLines: 2),
        ],
      ),
    );
  }
}
