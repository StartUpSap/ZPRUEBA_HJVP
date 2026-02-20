CLASS zcl_data_gen_rap_lgl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DATA_GEN_RAP_LGL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

      DELETE FROM ztravel_lgl.
      DELETE FROM ztravel_lgld.

      insert ztravel_lgl FROM (
            SELECT FROM ztravel_lgld
                   fields uuid(  ) as travel_uuid,
                          travelid,
                          agencyid,
                          customerid,
                          begindate,
                          enddate,
                          bookingfee,
                          totalprice,
                          currencycode,
                          description,
                          case overallstatus
                            when 'B' then 'A'
                            when 'P' then 'O'
                            when 'N' then 'O'
                            else 'X'
                            end as overall_status,

                          localcreatedby     as local_created_by,
                          localcreatedat     as local_created_at,
                          locallastchangedby as local_last_changed_by,
                          lastchangedat as local_last_changed_at
                          where travelid between 1 and 3000 ).
       if sy-subrc eq 0.
          out->write( |Travel......{ sy-dbcnt } rows inserted.| ).
       endif.

  ENDMETHOD.
ENDCLASS.
