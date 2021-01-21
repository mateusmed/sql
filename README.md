
```
Building Blocks of PL/SQL Programs PL/SQL is a block-structured language. 
A PL/SQL block is defined by the keywords DECLARE, BEGIN, EXCEPTION, and END, 
which break up the block into three sections:
```


Procedures podem "retornar" mais de um valor por referencia
Functions podem retornar apenas um valor, esse valor pode ser uma estrutura de dados
como lista, ou table e etc.

fazer um "organizador" 
  |_ pegar o conteúdo do parametro
  |_ se for grande, isolar e criar uma "function"

exemplo: 

antes:
```
BEGIN
        --Esse é o meu comentario em minha procedure gigante e zuada
        FOR data IN (select * from mytableXpto 
                                where i = (select * from b 
                                                where x = y)))

            conteudo 1 1
            conteudo 2 2
       LOOP
END;
```

depois:

```
BEGIN
        --Esse é o meu comentario em minha procedure gigante e zuada
        FOR data IN (method)

            conteudo 1 1
            conteudo 2 2
       LOOP
END;


function method

    return select * from mytableXpto 
                                where i = (select * from b 
                                                where x = y))

```

