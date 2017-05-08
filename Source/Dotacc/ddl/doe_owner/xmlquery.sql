select xmlelement("emp:employees"
  , xmlattributes( 'http://xmlnls.darwin-it.nl/doe/xsd/v1/employee' as "xmlns"
                 , 'http://xmlnls.darwin-it.nl/doe/xsd/v1/employee' as "xmlns:emp"
                 , 'http://xmlnls.darwin-it.nl/doe/xsd/v1/address' as "xmlns:ads")
  , xmlagg
  ( xmlelement
    ( "emp:employee"
    , xmlforest
      ( emp.title as "emp:title"
      , emp.firstname as "emp:firstName"
      , emp.last_name as "emp:lastName"
      , emp.gender as "emp:gender"
      , emp.birth_date as "emp:birthDate"
      )
    , ( select xmlelement( "emp:addresses"
        , xmlagg(
             xmlelement("ads:address"
             , xmlattributes( ate.code as "type"
                            , ate.description as "description")
             , xmlforest
               ( ads.adress_line1 as "ads:addressLine1"
               , ads.adress_line2 as "ads:addressLine2"
               , ads.adress_line3 as "ads:addressLine3"
               , ads.postal_code as "ads:postalCode"
               , ads.city as "ads:city"
               , ads.country as "ads:country"
               )
             )
          )
        )
        from doe_party_addresses pae
        join doe_addresses ads on ads.id = pae.ads_id
        join doe_address_types ate on ate.id= pae.ate_id
        where pae.emp_id = emp.id
        )
      )
    )
  )  xml
from doe_employees emp;