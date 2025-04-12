import 'package:e_litha/utils/app-color.dart';
import 'package:e_litha/utils/app-component.dart';
import 'package:flutter/material.dart';

class AnnualSummaryScreen extends StatelessWidget {
  const AnnualSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.btnTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ixj;air m,dm,',
          style: TextStyle(
            fontSize: 25,
            fontFamily: AppComponents.accentFont,
            color: AppColor.btnTextColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: AppColor.borderLightColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.btnTextColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'ixj;air m;%h',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: AppComponents.accentFont,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Y%Su;a Yd,s jdyk Yl kDm j¾I m%udKfhka 1947 jekafkka u;= úIaKq úxY;shg wh;a úYaj foaj hq. mxpdìofhys isõjk wkqj;air fNao kduOdß n%yau foajd;dêm;s úYajdjdiq kï ixj;air jkdys ók rú 30 Nd. jQ nla ui wj mE<úh ;sÒh ,;a rù Èk uOHu WohdÈ meh 52 úkdä 57g fyj;a jHjydr j¾Ifhka 2025 jekafkys wfma%,a ui 14 jk i÷od mQ¾j Nd. 03-21g Yks ysñ l=ïN ,.akh rúysñ isxy rdYH¾Oh nqO ysñ ñ:qk fo¾ldKfhka Yks ysñ ulr kjdxYlfhka yd pkao% ysñ lgl oajd oYdxYlfhka yd .=re ysñ Okq ;%sxYdxYlfhkao id kelf;a m<uq mdofhka o jc% fhda.fhkao fl!,j lrKfhkao rú fydardfõ i÷ mxpu ld,fhkao Yks iQlaIaufhkao iïNj ysre ók rdYsfhka fïI rdYshg ixl%uKh ùfuka isoaO fjkq ,efí-',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppComponents.accentFont,
                            color: AppColor.btnSubTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //next section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: AppColor.borderLightColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.btnTextColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'l%s-j-2025 ixj;air m,dm,',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: AppComponents.accentFont,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'fuh jkdys úIaKq úxY;shg wh;a úYaj foaj hq. mxpdìofhys isõ jeks wkqj;air fNao kduOdß n%yau foaj;dêm;s úYajdjdiq kï ixj;airh fõ- Yks .%yhd rdcdêm;s fjhs- .=re .%yhd jDIN ñ:qk yd lgl /fiyso Yks .%yhd l=ïN ók foi/yso rdyq .%yhd ók l=ïN fo/fiyso fla;= .%yhd lkHd isxy fo/fiyso hqf¾kia .%yhd fïI /fiyso kemapQka .%yhd ók /fiyso maÆfgda .%yhd ulr /fiyso yeisfrk w;r fiiq .%yhskaf.a .uka ú,dih yd isÿjk iQ¾h iy pkao%.K wkqj n,k l,ays uyckhd w;r f,v frda. nyq, jYfhka me;sr hhs¡ foaY.=Ksl úm¾hdi ksid l=Kdgqo oeä kshÕo we;s fjhs m%NQjrfhl=f.a urKhlao we;s fjhs hqo yuqodfõ lDDrlï iy wudkqIsl l%shd jd¾;d fjhs¡ l,dlrejkag wm,odhl ld,mßÉfþohls-',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppComponents.accentFont,
                            color: AppColor.btnSubTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'wm rg iïnkaOfhka n,kl,ays miq.sh jirg jvd wd¾:slfha ÈhqKqjla olakg ,efí kj foaYSh ksIamdok ìysjk w;r tu.ska kj l¾udka;Yd,do ìysfjhs ixpdrl l¾udka;hg Yqnm, jirls ixpdr l¾udka;hg iïNkaOj jev lrk ck;djg YqN m,odhlhs-',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppComponents.accentFont,
                            color: AppColor.btnSubTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'foaYmd,k l%shdldß;ajfha úYd, fjkila we;s jk jirls ue;sjrKhlao we;sjk jirls uyck ksfhdað;hskaf.a mlaI udre lsÍï iq,Nj isÿfõ tu.s rfÜ foaYmd,k wia:djr Ndjhlao we;sfõ-',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppComponents.accentFont,
                            color: AppColor.btnSubTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'wOHdmk lghq;=j, wvmK ùuo .=rejrekaf.a jevj¾ck yuqfõ YsIH wOHdmkfha wvmK ùïo we;sfjhs tkuq;a kj úIh ks¾foaY rch úiska ia:dmkh lrhs-',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppComponents.accentFont,
                            color: AppColor.btnSubTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'jevlrk ck;djg Yqnm, jirls jegqma jeäùïo ú/lshdjo wvqjk jirls tkuq;a NdKavj, ñ, iS>%fhka by, hdfuka uyck wmjdoo rch flfrys fhduq fjhs-',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppComponents.accentFont,
                            color: AppColor.btnSubTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'foaYSh l¾udka;fha úYd, ÈhqKqjla we;s fjhs tfukau f,dal fj<|fmdf,ys foaYSh NdKavj,g úYd, b,a¨ulao we;s fjhs weÕ¨ï l¾udka; ìysjk w;r tuÕska /lshd wjia:d nyq, fjhs ixpdrl l¾udka;hgo YqNM,odhlhs kj ixpdrl ksfla;k ìysjk w;r úYd, ixpdrl msßia furgg meñfKa-',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppComponents.accentFont,
                            color: AppColor.btnSubTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'foaYSh Kh m%;sjHqy.; lsÍu ksid rch wu;r nÿ ck;djg mkjk w;r úfoaYSh wdkhko úYd, jYfhka iSud lsÍuo we;s fjhs ¥IK jxpd jeä jk w;r ñkSuereï uxfld,a,lEï jeäùula olakg ,efí fi!LHh wxYfhao fnfy;a o%jHj, fukau jev j¾ck ksid o wvmK ùï olakg ,efí-',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppComponents.accentFont,
                            color: AppColor.btnSubTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'wd.u oyu ms<sn|j ck;djf.a jeä keUqrejla we;s fõ rch kj kS;s iïmdokh lrhs-',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppComponents.accentFont,
                            color: AppColor.btnSubTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'iqN w¨;a wjqreoaola fõjd-',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppComponents.accentFont,
                            color: AppColor.btnSubTextColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
