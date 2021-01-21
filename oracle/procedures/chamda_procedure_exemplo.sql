

DECLARE
    P_RETURNCODE NUMBER;
    P_ERRO VARCHAR2(200);
    BEGIN
        P_NUM_PROTOCOLO := NULL;

        CALL_PROCEDURE_EXAMPLE(P_RETURNCODE => P_RETURNCODE,
                                              P_ERRO => P_ERRO,
                                              );
        /* Legacy output:
        DBMS_OUTPUT.PUT_LINE('P_RETURNCODE = ' || P_RETURNCODE);
        */
        :P_RETURNCODE := P_RETURNCODE;
        /* Legacy output:
        DBMS_OUTPUT.PUT_LINE('P_ERRO = ' || P_ERRO);
        */
        :P_ERRO := P_ERRO;
        --rollback;
END;
