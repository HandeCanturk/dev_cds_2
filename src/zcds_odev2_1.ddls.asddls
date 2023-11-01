@AbapCatalog.sqlViewName: 'ZHANDE_SVIEW_1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zcds_odev2_1'
define view zcds_odev2_1 
  as select from    vbrp
    inner join      vbrk on vbrk.vbeln = vbrp.vbeln
    inner join      mara on mara.matnr = vbrp.matnr
    left outer join vbak on vbak.vbeln = vbrp.aubel
    left outer join kna1 on kna1.kunnr = vbak.kunnr
    left outer join makt on  makt.matnr = mara.matnr
                         and makt.spras = $session.system_language
{
  key vbrp.vbeln,
  key vbrp.posnr,
      vbrp.aubel,
      vbrp.aupos,
      vbak.kunnr,
      concat_with_space(kna1.name1, kna1.name2, 1)           as kunnrAd,
      currency_conversion(amount => vbrp.netwr,
                          source_currency => vbrk.waerk,
                          target_currency => cast('EUR' as abap.cuky),
                          exchange_rate_date => vbrk.fkdat ) as conversion_netwr,
      left(kna1.kunnr, 3)                                    as left_kunnr,
      length(mara.matnr)                                     as length_matnr,
      case vbrk.fkart
        when 'FAS' then 'Peşinat Talebi İptali'
        when 'FAZ' then 'Peşinat Talebi'
        else 'Fatura' end                                    as faturalama_turu,
      vbrk.fkdat,
      vbrk.inco2_l

}


