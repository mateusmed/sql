
/*
	Encoding: ISO 8859-1
	Objetivo: Organizar itens dentro grupo 'X' para o contexto Y
*/


DECLARE

	-- ==========================================================================================
	-- DECLARAÇÕES

    type ARRAY_T is varray(7) of varchar2(40);
    type LIST_OF_LIST IS TABLE OF ARRAY_T;

    my_path_id NUMBER;

    contexto NUMBER;

    my_path ARRAY_T := ARRAY_T();

    list_ordem ARRAY_T := ARRAY_T();

   -- ==========================================================================================

    PROCEDURE organizar_dentro_do_grupo_responsavel(list_ordem ARRAY_T,
                                                    id_contexto NUMBER,
                                                    id_grupo_responsavel NUMBER) IS

        update_sql clob := 'update x set y = {posicao} where n = ''{nm_grupo_usuario}''
                                                                        and i = {id_contexto}
                                                                        and i = {id_grupo_responsavel}';

        exec_update clob;
    BEGIN

      for i in 1..list_ordem.count loop

            exec_update := REPLACE(update_sql, '{posicao}', i);
            exec_update := REPLACE(exec_update, '{nm_grupo_usuario}', list_ordem(i));
            exec_update := REPLACE(exec_update, '{id_contexto}', id_contexto);
            exec_update := REPLACE(exec_update, '{id_grupo_responsavel}', id_grupo_responsavel);

          EXECUTE IMMEDIATE exec_update;

          dbms_output.put_line('' || exec_update);

      end loop;

    END;


 	-- ==========================================================================================

 	FUNCTION get_path_id(path_tree ARRAY_T, contexto NUMBER, projection varchar2) RETURN x.i%TYPE is

         type USER_GROUP_LIST is table of x.i%TYPE;
         id_procurado_list USER_GROUP_LIST;

         line_sql clob := '(select i from c where i = {id_contexto}
                                                    and n = ''{nm_grupo_usuario}''
                                                    and i = {id_grupo_responsavel})';

         last_line_sql clob := '(select i from v where i = {id_contexto}
                                                    and i = ''{nm_grupo_usuario}'')';

         final_sql clob := '(select {projection} from v where i = {id_contexto}
                                                    and i = ''{nm_grupo_usuario}''
                                                    and i = {id_grupo_responsavel})';
    BEGIN

        IF path_tree.count = 1 THEN

              final_sql := REPLACE(last_line_sql, '{id_contexto}', contexto);
              final_sql := REPLACE(final_sql, '{nm_grupo_usuario}', path_tree(1));
              final_sql := REPLACE(final_sql, '{projection}', projection);

         ELSE

            for k in 1..path_tree.count loop

                    IF k = 1 THEN

                          final_sql := REPLACE(final_sql, '{id_contexto}', contexto);
                          final_sql := REPLACE(final_sql, '{nm_grupo_usuario}', path_tree(k));

                    END IF;

                    IF k = path_tree.count THEN

                          final_sql := REPLACE(final_sql, '{id_grupo_responsavel}', last_line_sql);
                          final_sql := REPLACE(final_sql, '{id_contexto}',  contexto);
                          final_sql := REPLACE(final_sql, '{nm_grupo_usuario}', path_tree(k));

                    END IF;

                    IF k != 1 and k!= path_tree.count THEN

                          final_sql := REPLACE(final_sql, '{id_grupo_responsavel}', line_sql);
                          final_sql := REPLACE(final_sql, '{id_contexto}', contexto);
                          final_sql := REPLACE(final_sql, '{nm_grupo_usuario}', path_tree(k));

                    END IF;

            end loop;

            final_sql := REPLACE(final_sql, '{projection}', projection);

        END IF;

        final_sql := REPLACE(final_sql, '{projection}', projection);

        dbms_output.put_line('===================================');
        dbms_output.put_line('final: ' || final_sql);
        dbms_output.put_line('===================================');

        EXECUTE IMMEDIATE final_sql  bulk collect INTO id_procurado_list;

        IF id_procurado_list.count > 1 or id_procurado_list.count = 0 THEN
          RAISE_APPLICATION_ERROR(-20001, '[ERROR] path invalido não encontrado');
        END IF;

        dbms_output.put_line('===================================');
        dbms_output.put_line('encontrado: ' || id_procurado_list(1));
        dbms_output.put_line('===================================');

        RETURN id_procurado_list(1);

    END get_path_id;

    -- ==========================================================================================


BEGIN

  select i into contexto from t where t = 1;

  my_path_id := get_path_id(my_path, contexto, 'id_grupo_usuario');
  organizar_dentro_do_grupo_responsavel(list_ordem, contexto, my_path_id);

END;




