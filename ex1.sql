--DROP APAGA A TABELA 
DROP TABLE T_RHSTU_MEDICO_CONTATO;


--CRIANDO A TABELA COM AS COLUNAS 
CREATE TABLE T_RHSTU_MEDICO_CONTATO
(
CD_MEDICO NUMBER,
ID_CONTATO NUMBER(3),
TIPO_CONTATO VARCHAR2(10),
DS_CONTATO VARCHAR2(40)

);


--ALTERANDO A TABELA E ADICIONANDO CHAVE PRIMARIA 
ALTER TABLE T_RHSTU_MEDICO_CONTATO 
--ADICIONANDO UMA REGRA COM CHAVE PRIMARIA COMPOSTA(TEM RELAÇÃO 1->N)
ADD CONSTRAINT PK_RHSTU_MEDICO_CONTATO PRIMARY KEY (CD_MEDICO, ID_CONTATO);


--CRIANDO A FOREIGN KEY CHAVE ESTRANGEIRA 
ALTER TABLE T_RHSTU_MEDICO_CONTATO
ADD CONSTRAINTS FK_RHSTU_MEDICO_CONTATO_MEDICO FOREIGN KEY (CD_MEDICO)
REFERENCES T_RHSTU_MEDICO(CD_MEDICO);

--ALTERAR O NOME DA COLUNA
ALTER TABLE T_RHSTU_MEDICO_CONTATO RENAME COLUMN TIPO_CONTATO TO TP_CONTATO;

--ALTERANDO O TAMANHO DA COLUNA
ALTER TABLE T_RHSTU_MEDICO_CONTATO MODIFY (TP_CONTATO VARCHAR2(30));



-- CRIANDO UM COLUNA NOVA
ALTER TABLE T_RHSTU_MEDICO_CONTATO ADD ST_CONTATO CHAR(1);
--COLOCANDO UM LIMITROFE NO ATRIBUTO -REGRA DENTRO DA COLUNA
ALTER TABLE T_RHSTU_MEDICO_CONTATO
ADD CONSTRAINT CK_RHSTU_MEDICO_CONTATO_ST 
CHECK (ST_CONTATO IN ('A','I'));


--COLOCANDO UM NOT NULL NA COLUNA STATUS(CONTEÚDO OBRIGATÓRIO)
ALTER TABLE T_RHSTU_MEDICO_CONTATO
MODIFY (ST_CONTATO CONSTRAINT CK_RHSTU_MEDICO_CONTATO_ST_NN NOT NULL);

--COLOCANDO UM NOT NULL NA COLUNA DESCRIÇÃO(CONTEÚDO OBRIGATÓRIO)
ALTER TABLE T_RHSTU_MEDICO_CONTATO
MODIFY (DS_CONTATO CONSTRAINT CK_RHSTU_MEDICO_CONTATO_DS_NN NOT NULL);

--COLOCANDO UM NOT NULL NA COLUNA TIPO DE CONTATO(CONTEÚDO OBRIGATÓRIO)
ALTER TABLE T_RHSTU_MEDICO_CONTATO
MODIFY (TP_CONTATO CONSTRAINT CK_RHSTU_MEDICO_CONTATO_TP_NN NOT NULL);

--COLOCANDO UM LIMITROFE NO ATRIBUTO -REGRA DENTRO DA COLUNA
ALTER TABLE T_RHSTU_MEDICO_CONTATO
ADD CONSTRAINT CK_RHSTU_MEDICO_CONTATO_TP 
CHECK (TP_CONTATO IN ('TELEFONE FIXO', 'TELEFONE CELULAR', 'EMAIL', 'TELEFONE CONTATO'));

--AUTERAR O VALOR DA COLUNA CONTATO PARA VARCHAR(50)
ALTER TABLE T_RHSTU_MEDICO_CONTATO MODIFY TP_CONTATO VARCHAR2(50);


--CRIAR UMA NOVA COLUNA COM DT_CADASTRO DO TIPO DATE 
ALTER TABLE T_RHSTU_MEDICO_CONTATO ADD DT_CADASTRO DATE DEFAULT SYSDATE;

--A COLUNA DEVE SER OBRIGATÓRIA 
ALTER TABLE T_RHSTU_MEDICO_CONTATO
MODIFY (DT_CADASTRO CONSTRAINT CK_RHSTU_MEDICO_CONTATO_DT_NN NOT NULL);

--CRIAR UMA NOVA COLUNA COM CPF NA TABELA DO MEDICO COM UNIQUE 
ALTER TABLE T_RHSTU_MEDICO DROP COLUMN NR_CPF;
ALTER TABLE T_RHSTU_MEDICO ADD NR_CPF NUMBER(12);
ALTER TABLE T_RHSTU_MEDICO DROP CONSTRAINT UK_RHSTU_MEDICO;
ALTER TABLE T_RHSTU_MEDICO ADD CONSTRAINT UK_RHSTU_MEDICO UNIQUE (NR_CPF);

--COMENTARIO SOBRE A TABELA 
COMMENT ON TABLE T_RHSTU_MEDICO_CONTATO IS
'A  tabela do contato do médica é muito importante e será utilizada para localizar o médico 
quando for necessário aciona-lo de forma emergencial';


--COMENTARIO SOBRE A TABELA 
COMMENT ON TABLE T_RHSTU_MEDICO_CONTATO.DS_CONTATO IS
'descrição do contato é utilizado para identificar o nome da pessoa que irá localizar o médico quando necessário
Seu conteúdo é obrigatório e será armazenado no formato InitCap';

--ONDE ENCONTRAR OS COMENTÁRIOS 
SELECT * FROM USER_TAB_COMMENTS
WHERE TABLE_NAME = 'T_RHSTU_MEDICO_CONTATO';

SELECT * FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'T_RHSTU_MEDICO_CONTATO';

