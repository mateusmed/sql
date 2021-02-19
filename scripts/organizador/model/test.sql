BEGIN

       FOR C_GRA IN ( { SELECT 1 from dual; } )
       LOOP

          {SELECT 2 from dual}

       END LOOP;

END