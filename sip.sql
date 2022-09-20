-- Gerado por Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   em:        2022-06-22 11:49:18 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g

CREATE TABLE t_sip_bairro (
    cd_bairro  NUMBER(4) NOT NULL,
    cd_cidade  NUMBER(3) NOT NULL,
    nm_bairro  VARCHAR2(50) NOT NULL
);

ALTER TABLE t_sip_bairro ADD CONSTRAINT pk_sip_bairro PRIMARY KEY ( cd_bairro );

CREATE TABLE t_sip_cidade (
    cd_cidade  NUMBER(3) NOT NULL,
    cd_estado  NUMBER(2) NOT NULL,
    nm_cidade  VARCHAR2(50) NOT NULL
);

ALTER TABLE t_sip_cidade ADD CONSTRAINT pk_sip_cidade PRIMARY KEY ( cd_cidade );

CREATE TABLE t_sip_dependente (
    nr_matricula   NUMBER(5) NOT NULL,
    cd_dependente  NUMBER(3) NOT NULL,
    nm_dependente  VARCHAR2(60) NOT NULL,
    dt_nascimento  DATE NOT NULL
);

ALTER TABLE t_sip_dependente ADD CONSTRAINT pk_sip_dependente PRIMARY KEY ( cd_dependente,
                                                                            nr_matricula );

CREATE TABLE t_sip_depto (
    cd_depto  NUMBER(2) NOT NULL,
    nm_depto  VARCHAR2(30) NOT NULL,
    sg_depto  CHAR(3) NOT NULL
);

ALTER TABLE t_sip_depto ADD CONSTRAINT pk_sip_departamento PRIMARY KEY ( cd_depto );

ALTER TABLE t_sip_depto ADD CONSTRAINT un_sip_depto_nome UNIQUE ( nm_depto );

CREATE TABLE t_sip_endereco (
    cd_end_correio  NUMBER NOT NULL,
    cd_bairro       NUMBER(4) NOT NULL,
    nr_cep          NUMBER(10) NOT NULL,
    ds_logradouro   VARCHAR2(10) NOT NULL
);

ALTER TABLE t_sip_endereco ADD CONSTRAINT pk_sip_endereco_correio PRIMARY KEY ( cd_end_correio );

CREATE TABLE t_sip_estado (
    cd_estado  NUMBER(2) NOT NULL,
    nm_estado  VARCHAR2(20) NOT NULL,
    sg_estado  CHAR(2) NOT NULL
);

ALTER TABLE t_sip_estado ADD CONSTRAINT pk_sip_estado PRIMARY KEY ( cd_estado );

CREATE TABLE t_sip_funcionario (
    nr_matricula    NUMBER(5) NOT NULL,
    cd_depto        NUMBER(2) NOT NULL,
    nm_funcionario  VARCHAR2(60) NOT NULL,
    dt_nascimento   DATE NOT NULL,
    dt_admissao     DATE NOT NULL,
    vl_salario      NUMBER(7, 2) NOT NULL
);

ALTER TABLE t_sip_funcionario ADD CONSTRAINT pk_sip_funcionario PRIMARY KEY ( nr_matricula );

CREATE TABLE t_sip_funcionario_endereco (
    cd_end_func          NUMBER(8) NOT NULL,
    nr_matricula         NUMBER(5) NOT NULL,
    cd_end_correio       NUMBER NOT NULL,
    cd_tipo_endereco     NUMBER(4) NOT NULL,
    ds_complemento       VARCHAR2(10) NOT NULL,
    nr_logradouro        NUMBER(5) NOT NULL,
    ds_ponto_referencia  VARCHAR2(200)
);

ALTER TABLE t_sip_funcionario_endereco ADD CONSTRAINT pk_sip_funcionario_endereco PRIMARY KEY ( cd_end_func );

CREATE TABLE t_sip_implantacao (
    cd_projeto      NUMBER(5) NOT NULL,
    cd_implantacao  NUMBER(3) NOT NULL,
    nr_matricula    NUMBER(5) NOT NULL,
    dt_entrada      DATE NOT NULL,
    dt_saida        DATE
);

ALTER TABLE t_sip_implantacao ADD CONSTRAINT pk_sip_implantacao PRIMARY KEY ( cd_implantacao,
                                                                              cd_projeto );

CREATE TABLE t_sip_projeto (
    cd_projeto  NUMBER(5) NOT NULL,
    nm_projeto  VARCHAR2(40) NOT NULL,
    dt_inciio   DATE NOT NULL,
    dt_termino  DATE
);

ALTER TABLE t_sip_projeto ADD CONSTRAINT pk_sip_projeto PRIMARY KEY ( cd_projeto );

ALTER TABLE t_sip_projeto ADD CONSTRAINT un_sip_projeto_nome UNIQUE ( nm_projeto );

CREATE TABLE t_sip_tipo_endereco (
    cd_tipo_endereco  NUMBER(4) NOT NULL,
    nm_tipo_endereco  VARCHAR2(20) NOT NULL
);

ALTER TABLE t_sip_tipo_endereco ADD CONSTRAINT pk_sip_tipo_endereco PRIMARY KEY ( cd_tipo_endereco );

ALTER TABLE t_sip_endereco
    ADD CONSTRAINT fk_sip_bairro_endereco FOREIGN KEY ( cd_bairro )
        REFERENCES t_sip_bairro ( cd_bairro );

ALTER TABLE t_sip_bairro
    ADD CONSTRAINT fk_sip_cidade_bairro FOREIGN KEY ( cd_cidade )
        REFERENCES t_sip_cidade ( cd_cidade );

ALTER TABLE t_sip_dependente
    ADD CONSTRAINT fk_sip_dependente_func FOREIGN KEY ( nr_matricula )
        REFERENCES t_sip_funcionario ( nr_matricula );

ALTER TABLE t_sip_funcionario_endereco
    ADD CONSTRAINT fk_sip_end_correio_func FOREIGN KEY ( cd_end_correio )
        REFERENCES t_sip_endereco ( cd_end_correio );

ALTER TABLE t_sip_cidade
    ADD CONSTRAINT fk_sip_estado_cidade FOREIGN KEY ( cd_estado )
        REFERENCES t_sip_estado ( cd_estado );

ALTER TABLE t_sip_funcionario
    ADD CONSTRAINT fk_sip_func_depto FOREIGN KEY ( cd_depto )
        REFERENCES t_sip_depto ( cd_depto );

ALTER TABLE t_sip_funcionario_endereco
    ADD CONSTRAINT fk_sip_funcionario_end FOREIGN KEY ( nr_matricula )
        REFERENCES t_sip_funcionario ( nr_matricula );

ALTER TABLE t_sip_implantacao
    ADD CONSTRAINT fk_sip_implantacao_func FOREIGN KEY ( nr_matricula )
        REFERENCES t_sip_funcionario ( nr_matricula );

ALTER TABLE t_sip_implantacao
    ADD CONSTRAINT fk_sip_implantacao_projeto FOREIGN KEY ( cd_projeto )
        REFERENCES t_sip_projeto ( cd_projeto );

ALTER TABLE t_sip_funcionario_endereco
    ADD CONSTRAINT fk_sip_tipo_endereco FOREIGN KEY ( cd_tipo_endereco )
        REFERENCES t_sip_tipo_endereco ( cd_tipo_endereco );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             23
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
