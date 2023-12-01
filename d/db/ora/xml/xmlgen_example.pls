-- xmlgen_example.pls
--
-- 2020-10-23

declare
  ctx    dbms_xmlgen.ctxHandle;
  xml    CLOB;
begin
  ctx:=dbms_xmlgen.newContext(q'[
    select
      client_no,
      client_name,
      cursor(
        select * 
        from
          fm_client_contact cc
        where
          cc.client_no = c.client_no
          and cc.route = 'POSTAL') as address
    from
      fm_client c
    where
      c.client_no=:client_no]');

  dbms_xmlgen.setBindValue( ctx, 'CLIENT_NO', 'OE0001');
  dbms_xmlgen.setRowSetTag( ctx, 'DATA');
  dbms_xmlgen.setRowTag(    ctx, 'CLIENT');
  dbms_xmlgen.setPrettyPrinting(ctx, true);
  xml := dbms_xmlgen.getXML(ctx);
  dbms_xmlgen.closeContext(ctx);
  dbms_output.put_line(xml);
end ;
/

declare
  client_no   fm_client.client_no%type;
  client_name fm_client.client_name%type;
  contact     SYS_REFCURSOR;
  c           SYS_REFCURSOR;
  cnt         fm_client_contact%rowtype ;
begin
  open c for q'[
    select
      client_no,
      client_name,
      cursor(
        select * 
        from
          fm_client_contact cc
        where
          cc.client_no=c.client_no
          and cc.route='POSTAL') as address
    from
      fm_client c
    where
      c.client_no=:client_no]' using 'OE0001';
  loop
    FETCH c INTO client_no, client_name, contact;
    EXIT WHEN c%NOTFOUND;
    dbms_output.put_line(client_no);
    loop
      FETCH contact INTO cnt;
      EXIT WHEN contact%NOTFOUND;
      dbms_output.put_line(cnt.address);
    end loop;
    close contact;
  end loop;
  close c;
end;
/
