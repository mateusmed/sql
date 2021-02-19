
-- query trás informações da tabela e seu relacionamento de primeiro nível
select  a.owner,
        a.constraint_name as column_name,
        b.table_name as reference_table
        from  dba_constraints a, dba_constraints b
where   a.table_name = 'table_name'
and     a.r_constraint_name = b.constraint_name