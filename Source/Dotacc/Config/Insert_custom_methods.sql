--------------------------------------------------------
--  File created - Thursday-October-09-2014   
--------------------------------------------------------
REM DELETING XXX_CUSTOM_METHODS
delete XXX_CUSTOM_METHODS;
REM INSERTING into XXX_CUSTOM_METHODS
SET DEFINE OFF;
Insert into XXX_CUSTOM_METHODS (TABLE_OWNER,TABLE_NAME,TYPE_NAME,METHOD_NAME,METHOD_COMMENT,METHOD_SPEC, METHOD_DECL) values ('DOE_OWNER','DOE_ARRANGEMENTS','DOE_ARRANGEMENTS_TYPE','calc_total_amount','-- Calculate total costs','procedure calc_total_amount', 'procedure calc_total_amount 
  is
    l_total_amount number:=0;
  begin
    l_total_amount := ARRANGEMENT_LINES.sum_amount;
    self.total_costs := l_total_amount;
  end calc_total_amount;');
Insert into XXX_CUSTOM_METHODS (TABLE_OWNER,TABLE_NAME,TYPE_NAME,METHOD_NAME,METHOD_COMMENT,METHOD_SPEC, METHOD_DECL) values ('DOE_OWNER','DOE_ARRANGEMENT_LINES','DOE_ARRANGEMENT_LINES_COLL','sum_amount', '-- Summarize amount in Arrangement Lines','function sum_amount 
  return number', 'function sum_amount 
  return number
  is
    l_result number := 0;
  begin
    if self.ARRANGEMENT_LINES is not null and self.ARRANGEMENT_LINES.count > 0 then
      for l_idx in self.ARRANGEMENT_LINES.first..self.ARRANGEMENT_LINES.last
        loop
          l_result := l_result + self.ARRANGEMENT_LINES(l_idx).amount;
        end loop;
    end if;
    return l_result;
  end sum_amount;');

commit