select xmlelement
         ( "FkConstraints"
         , xmlagg
           ( xmlelement
             ( "FkConstraint"
             , xmlforest
               ( con.owner             as "Owner"
               , con.constraint_name   as "Name"
               , con.constraint_type   as "Type"
               , con.table_name        as "TableName"
               )
             , ( select xmlelement
                        ( "ConstraintColumns"
                        , xmlelement
                          ( "ConstraintColumn"
                          , xmlforest
                            ( cnlr.column_name as "ColumnName"
                            , cnlr.position as "Position"
                            )
                          )
                        )
                 from all_cons_columns cnlr
                 where cnlr.owner = con.owner
                 and   cnlr.constraint_name = con.constraint_name
               )
             , ( select xmlelement 
                        ( "RefConstraint"
                        , xmlforest
                          ( conp.owner           as "Owner"
                          , conp.constraint_name as "Name"
                          , conp.constraint_type   as "Type"
                          , conp.table_name        as "TableName"
                          )
                          , ( select xmlelement
                                     ( "ConstraintColumns"
                                     , xmlelement
                                       ( "ConstraintColumn"
                                       , xmlforest
                                         ( cnlp.column_name as "ColumnName"
                                         , cnlp.position as "Position"
                                         )
                                       )
                                     )
                              from all_cons_columns cnlp 
                              where cnlp.owner = conp.owner
                              and   cnlp.constraint_name = conp.constraint_name
                            )
                        )
                 from all_constraints conp 
                 where conp.owner = con.r_owner
                and    conp.constraint_name = con.r_constraint_name
               )
             )
           )
         )
from all_constraints con
where con.constraint_type = 'R'
and con.owner = 'ZMS'
and con.table_name = 'ZMS_TOETSRESULTATEN';
