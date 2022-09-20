-- Gerado por Oracle SQL Developer Data Modeler 21.4.2.059.0838
--   em:        2022-09-18 15:37:02 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_rhstu_bairro (
    id_bairro      NUMBER(8) NOT NULL,
    id_cidade      NUMBER(8) NOT NULL,
    nm_bairro      VARCHAR2(45) NOT NULL,
    nm_zona_bairro VARCHAR2(20) NOT NULL
);

ALTER TABLE t_rhstu_bairro
    ADD CONSTRAINT uk_rhstu_bairro_zona CHECK ( nm_zona_bairro IN ( 'CENTRO', 'ZONA LESTE', 'ZONA NORTE', 'ZONA OESTE', 'ZONA SUL' ) );

COMMENT ON COLUMN t_rhstu_bairro.id_bairro IS
    'Esta coluna irá receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_bairro.nm_bairro IS
    'Esta coluna irá receber o nome do Bairro  pertencente Cidade do Estado Brasileiro. O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_bairro.nm_zona_bairro IS
    'Esta coluna irá receber a localização da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.';

ALTER TABLE t_rhstu_bairro ADD CONSTRAINT pk__rhstu_bairro PRIMARY KEY ( id_bairro );

CREATE TABLE t_rhstu_cidade (
    id_cidade NUMBER(8) NOT NULL,
    id_estado NUMBER(2) NOT NULL,
    nm_cidade VARCHAR2(60) NOT NULL,
    cd_ibge   NUMBER(8) NOT NULL,
    nr_ddd    NUMBER(3) NOT NULL
);

COMMENT ON COLUMN t_rhstu_cidade.id_cidade IS
    'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório e será preenchido automaticamente pelo sistema.

';

COMMENT ON COLUMN t_rhstu_cidade.id_estado IS
    'Esta coluna irá receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_cidade.nm_cidade IS
    'Esta coluna irá receber o nome do Cidade pertencente ao Estado Brasileiro. O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_cidade.cd_ibge IS
    'Esta coluna irá receber o código do IBGE que fornece informações para geração da NFe.';

ALTER TABLE t_rhstu_cidade ADD CONSTRAINT pk_rhstu_cidade PRIMARY KEY ( id_cidade );

CREATE TABLE t_rhstu_consulta (
    id_unid_hospital NUMBER(9) NOT NULL,
    nr_consulta      NUMBER NOT NULL,
    id_paciente      NUMBER(9) NOT NULL,
    cd_medico        NUMBER NOT NULL,
    dt_hr_consulta   DATE NOT NULL,
    nr_consultorio   NUMBER(5) NOT NULL
);

ALTER TABLE t_rhstu_consulta ADD CONSTRAINT pk_rhstu_consulta PRIMARY KEY ( nr_consulta,
                                                                            id_unid_hospital );

CREATE TABLE t_rhstu_consulta_forma_pagto (
    id_consulta_forma_pagto NUMBER NOT NULL,
    id_unid_hospital        NUMBER(9) NOT NULL,
    nr_consulta             NUMBER NOT NULL,
    id_paciente_ps          NUMBER(10) NOT NULL,
    id_forma_pagto          NUMBER NOT NULL,
    dt_cadastro             DATE NOT NULL,
    dt_pagto_consulta       DATE,
    st_pagto_consulta       CHAR(1) NOT NULL
);

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT uk_rhstu_status_pagto_paci CHECK ( st_pagto_consulta IN ( 'A', 'C', 'P' ) );

ALTER TABLE t_rhstu_consulta_forma_pagto ADD CONSTRAINT pk_rhstu_consulta_forma_pagto PRIMARY KEY ( id_consulta_forma_pagto );

CREATE TABLE t_rhstu_contato_paciente (
    id_paciente     NUMBER(9) NOT NULL,
    id_contato      NUMBER(9) NOT NULL,
    id_tipo_contato NUMBER(5) NOT NULL,
    nm_contato      VARCHAR2(40) NOT NULL,
    nr_ddi          NUMBER(3),
    nr_ddd          NUMBER(3),
    nr_telefone     NUMBER(10)
);

COMMENT ON COLUMN t_rhstu_contato_paciente.id_paciente IS
    'Esse atributo irá receber a chave primária do paciente. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_contato_paciente.id_contato IS
    'Esse atributo irá receber a chave primária do contato do paciente. Esse número é sequencial e inicia sempre com 1 a partir do id do paciente e é gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_contato_paciente.id_tipo_contato IS
    'Esse atributo irá receber a chave primária do tipo do contato. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nm_contato IS
    'Este atributo irá receber o nome do contato do paciente. Seu conteudo é obrigatório.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_ddi IS
    'Este atributo irá receber o número do DDI do telefone do contato do paciente. Seu conteudo é opcional.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_ddd IS
    'Este atributo irá receber o número do DDD  do telefone do contato do paciente. Seu conteudo é opcional.';

COMMENT ON COLUMN t_rhstu_contato_paciente.nr_telefone IS
    'Este atributo irá receber o número do telefone do contato do paciente. Seu conteudo é opcional.';

ALTER TABLE t_rhstu_contato_paciente ADD CONSTRAINT pk_rhstu_contato_emerg_pac PRIMARY KEY ( id_contato,
                                                                                             id_paciente );

CREATE TABLE t_rhstu_email_paciente (
    id_email    NUMBER(9) NOT NULL,
    id_paciente NUMBER(9) NOT NULL,
    ds_email    VARCHAR2(100) NOT NULL,
    tp_email    VARCHAR2(20) NOT NULL,
    st_email    CHAR(1) NOT NULL
);

ALTER TABLE t_rhstu_email_paciente
    ADD CONSTRAINT uk_rhstu_status_email_pac CHECK ( st_email IN ( 'A', 'I' ) );

COMMENT ON COLUMN t_rhstu_email_paciente.id_email IS
    'Esse atributo irá receber a chave primária do email do paciente. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_email_paciente.id_paciente IS
    'Esse atributo irá receber a chave primária do paciente. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_email_paciente.ds_email IS
    'Esse atributo irá receber o email do paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_email_paciente.tp_email IS
    'Esse atributo irá receber o tipo email do paciente.  Seu conteúdo é obrigatório e deve possuir os seguintes valores: Pessoal ou Profissional.';

COMMENT ON COLUMN t_rhstu_email_paciente.st_email IS
    'Esse atributo irá receber o status do email do paciente.  Seu conteúdo é obrigatório e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

ALTER TABLE t_rhstu_email_paciente ADD CONSTRAINT pk_rhstu_email_paciente PRIMARY KEY ( id_email );

CREATE TABLE t_rhstu_endereco_paciente (
    id_endereco           NUMBER(9) NOT NULL,
    id_paciente           NUMBER(9) NOT NULL,
    id_logradouro         NUMBER(10) NOT NULL,
    nr_logradouro         NUMBER(7),
    ds_complemento_numero VARCHAR2(30),
    ds_ponto_referencia   VARCHAR2(50),
    dt_inicio             DATE NOT NULL,
    dt_fim                DATE
);

COMMENT ON COLUMN t_rhstu_endereco_paciente.id_endereco IS
    'Esse atributo irá receber a chave primária do endereco do paciente. Esse número é sequencia e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.id_paciente IS
    'Esse atributo irá receber a chave primária do paciente. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.nr_logradouro IS
    'Esse atributo irá receber o número do logradouro do endereco do paciente.  Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.ds_complemento_numero IS
    'Esse atributo irá receber o complemeneto  do logradouro do endereco do paciente caso ele exista. Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.ds_ponto_referencia IS
    'Esse atributo irá receber o ponto de referência  do logradouro do endereco do paciente.  Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.dt_inicio IS
    'Esse atributo irá receber a data inicio do paciente associado ao endereço (logradouro). Seu conteúdo é obrigatorio.';

COMMENT ON COLUMN t_rhstu_endereco_paciente.dt_fim IS
    'Esse atributo irá receber a data fim do paciente associado ao endereço (logradouro), ou seja, ele não reside mais nesse endereço.  Seu conteúdo é opcional.';

ALTER TABLE t_rhstu_endereco_paciente ADD CONSTRAINT pk_rhstu_endereco_paciente PRIMARY KEY ( id_endereco );

CREATE TABLE t_rhstu_estado (
    id_estado NUMBER(2) NOT NULL,
    sg_estado CHAR(2) NOT NULL,
    nm_estado VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN t_rhstu_estado.id_estado IS
    'Esta coluna irá receber o codigo interno para garantir unicidade dos Estados do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_estado.nm_estado IS
    'Esta coluna irá receber o nome do estado. O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.';

ALTER TABLE t_rhstu_estado ADD CONSTRAINT pk_rhstu_estado PRIMARY KEY ( id_estado );

CREATE TABLE t_rhstu_forma_pagamento (
    id_forma_pagto NUMBER NOT NULL,
    nm_forma_pagto VARCHAR2(60) NOT NULL,
    ds_forma_pagto VARCHAR2(500),
    st_forma_pagto CHAR(1) DEFAULT 'A' NOT NULL
);

ALTER TABLE t_rhstu_forma_pagamento
    ADD CONSTRAINT uk_rhstu_status_forma_pagto CHECK ( st_forma_pagto IN ( 'A', 'I' ) );

ALTER TABLE t_rhstu_forma_pagamento ADD CONSTRAINT pk_rhstu_forma_pagto PRIMARY KEY ( id_forma_pagto );

CREATE TABLE t_rhstu_logradouro (
    id_logradouro NUMBER(10) NOT NULL,
    id_bairro     NUMBER(8) NOT NULL,
    nm_logradouro VARCHAR2(100) NOT NULL,
    nr_cep        NUMBER(8) NOT NULL
);

COMMENT ON COLUMN t_rhstu_logradouro.id_logradouro IS
    'Esta coluna irá receber o codigo interno para garantir o lograouro, que esta localizado no  cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_logradouro.id_bairro IS
    'Esta coluna irá receber o codigo interno para garantir o cadastro dos  Bairros da Cidade do Estado do Brasil. Seu conteúdo é obrigatório e único será preenchido automaticamente pelo sistema.';

COMMENT ON COLUMN t_rhstu_logradouro.nm_logradouro IS
    'Esta coluna irá receber o nome do lograoduro. O padrão de armazenmento é  InitCap e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.';

COMMENT ON COLUMN t_rhstu_logradouro.nr_cep IS
    'Esta coluna irá receber o número do CEP do lograoduro. O padrão de armazenmento é  numérico  e seu conteúdo é obrigatório. Essa tabela já será preenchida pela área responsável. Novas inseções necessitam ser avaladas pelos gestores.';

ALTER TABLE t_rhstu_logradouro ADD CONSTRAINT pk_rhstu_logradouro PRIMARY KEY ( id_logradouro );

CREATE TABLE t_rhstu_medicamento (
    id_medicamento           NUMBER NOT NULL,
    nm_medicamento           VARCHAR2(50) NOT NULL,
    ds_detalhada_medicamento VARCHAR2(4000),
    nr_codigo_barras         NUMBER NOT NULL
);

ALTER TABLE t_rhstu_medicamento ADD CONSTRAINT pk_rhstu_medicamento PRIMARY KEY ( id_medicamento );

CREATE TABLE t_rhstu_medico (
    cd_medico        NUMBER NOT NULL,
    nm_medico        VARCHAR2(90) NOT NULL,
    nr_crm           NUMBER(10) NOT NULL,
    ds_especialidade VARCHAR2(50) NOT NULL
);

ALTER TABLE t_rhstu_medico ADD CONSTRAINT pk_rhstu_medico PRIMARY KEY ( cd_medico );

CREATE TABLE t_rhstu_paciente (
    id_paciente        NUMBER(9) NOT NULL,
    nm_paciente        VARCHAR2(80) NOT NULL,
    nr_cpf             NUMBER(12) NOT NULL,
    nm_rg              VARCHAR2(15),
    dt_nascimento      DATE NOT NULL,
    fl_sexo_biologico  CHAR(1) NOT NULL,
    ds_escolaridade    VARCHAR2(40) NOT NULL,
    ds_estado_civil    VARCHAR2(25) NOT NULL,
    nm_grupo_sanguineo VARCHAR2(6) NOT NULL,
    nr_altura          NUMBER(3, 2) DEFAULT 0.1 NOT NULL,
    nr_peso            NUMBER(4, 1) DEFAULT 1 NOT NULL
);

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT ck_rhstu_paciente_sexo CHECK ( fl_sexo_biologico IN ( 'F', 'I', 'M' ) );

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT ck_rhstu_paciente_altura CHECK ( nr_altura BETWEEN 0.1 AND 2.99 );

ALTER TABLE t_rhstu_paciente
    ADD CONSTRAINT uk_rhstu_paciente_peso CHECK ( nr_peso BETWEEN 1 AND 800 );

COMMENT ON COLUMN t_rhstu_paciente.id_paciente IS
    'Esse atributo irá receber a chave primária do paciente. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.nm_paciente IS
    'Esse atributo irá receber o nome completo do  paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.nr_cpf IS
    'Esse atributo irá receber o número do  CPF paciente.  Seu conteúdo é obrigatório e será validado de acordo com regras de negócio.';

COMMENT ON COLUMN t_rhstu_paciente.nm_rg IS
    'Esse atributo irá receber o número do  RG  paciente.  Seu conteúdo é obrigatório e será validado de acordo com regras de negócio.';

COMMENT ON COLUMN t_rhstu_paciente.dt_nascimento IS
    'Esse atributo irá receber a data de nascimento do  paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.fl_sexo_biologico IS
    'Esse atributo irá receber a flag do sexo biológico de nascimento do Paciente. Os valores possíveis são (F)emea  ou (M)acho ou (I)ntersexual. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.ds_escolaridade IS
    'Esse atributo irá receber a Escolaridade do  paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.ds_estado_civil IS
    'Esse atributo irá receber o Estado Civil  do  paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.nm_grupo_sanguineo IS
    'Esse atributo irá receber o grupo sanguineo do  paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente.nr_altura IS
    'Esse atributo irá receber a altura do  paciente.  Seu conteúdo é obrigatório e o limite de altura deve ficar entre 0.1 e 2.99.';

COMMENT ON COLUMN t_rhstu_paciente.nr_peso IS
    'Esse atributo irá receber o peso  do  paciente.  Seu conteúdo é obrigatório. A faixa de valores permitidos está entre 1 e 800kg.';

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT pk_rhstu_paciente PRIMARY KEY ( id_paciente );

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT uk_rhstu_cpf_paciente UNIQUE ( nr_cpf );

ALTER TABLE t_rhstu_paciente ADD CONSTRAINT uk_rhstu_rg_paciente UNIQUE ( nm_rg );

CREATE TABLE t_rhstu_paciente_plano_saude (
    id_paciente_ps NUMBER(10) NOT NULL,
    id_paciente    NUMBER(9) NOT NULL,
    id_plano_saude NUMBER(5) NOT NULL,
    nr_carteira_ps NUMBER(15),
    dt_inicio      DATE NOT NULL,
    dt_fim         DATE
);

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_paciente_ps IS
    'Esse atributo irá receber a chave primária do plano de saúde do paciente. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.id_paciente IS
    'Esse atributo irá receber a chave primária do paciente. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_inicio IS
    'Esse atributo irá receber a data de início para atendimento do plano de saúde do cliente aceito na RHSTU. Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_paciente_plano_saude.dt_fim IS
    'Esse atributo irá receber a data de encerramento do plano de saúde aceito na RHSTU. Seu conteúdo é opcional.';

ALTER TABLE t_rhstu_paciente_plano_saude ADD CONSTRAINT pk_rhstu_pac_plano_saude PRIMARY KEY ( id_paciente_ps );

CREATE TABLE t_rhstu_plano_saude (
    id_plano_saude          NUMBER(5) NOT NULL,
    ds_razao_social         VARCHAR2(70) NOT NULL,
    nm_fantasia_plano_saude VARCHAR2(80),
    ds_plano_saude          VARCHAR2(100) NOT NULL,
    nr_cnpj                 NUMBER(14) NOT NULL,
    nm_contato              VARCHAR2(30),
    ds_telefone             VARCHAR2(30),
    dt_inicio               DATE NOT NULL,
    dt_fim                  DATE
);

COMMENT ON COLUMN t_rhstu_plano_saude.id_plano_saude IS
    'Esse atributo irá receber a chave primária do plano de saúde. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_razao_social IS
    'Esse atributo irá receber Razão Social do plano de saúde aceito na RHSTU. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_plano_saude.nm_fantasia_plano_saude IS
    'Esse atributo irá receber o nome Fantasia do plano de saúde aceito na RHSTU. Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_plano_saude IS
    'Esse atributo irá receber a descrição do  plano de saúde aceito na RHSTU. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_plano_saude.nr_cnpj IS
    'Esse atributo irá receber o numero do CNPJ do plano de saúde aceito na RHSTU. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_plano_saude.nm_contato IS
    'Esse atributo irá receber o nome  do contato dentro do plano de saúde aceito na RHSTU. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_plano_saude.ds_telefone IS
    'Esse atributo irá receber os dados do telefone para contato no plano de saúde aceito na RHSTU. Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.dt_inicio IS
    'Esse atributo irá receber a data de início para atendimento do plano de saúde aceito na RHSTU. Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_plano_saude.dt_fim IS
    'Esse atributo irá receber a data de encerramento do plano de saúde aceito na RHSTU. Seu conteúdo é opcional.';

ALTER TABLE t_rhstu_plano_saude ADD CONSTRAINT pk_rhstu_plano_saude PRIMARY KEY ( id_plano_saude );

CREATE TABLE t_rhstu_prescicao_medica (
    id_prescricao_medica NUMBER NOT NULL,
    id_unid_hospital     NUMBER(9) NOT NULL,
    nr_consulta          NUMBER NOT NULL,
    id_medicamento       NUMBER NOT NULL,
    ds_posologia         VARCHAR2(150) NOT NULL,
    ds_via               VARCHAR2(40) NOT NULL,
    ds_observacao_uso    VARCHAR2(100),
    qt_medicamento       NUMBER(10, 4)
);

ALTER TABLE t_rhstu_prescicao_medica ADD CONSTRAINT pk_rhstu_prescicao_medica PRIMARY KEY ( id_prescricao_medica );

CREATE TABLE t_rhstu_telefone_paciente (
    id_paciente NUMBER(9) NOT NULL,
    id_telefone NUMBER(9) NOT NULL,
    nr_ddi      NUMBER(3) NOT NULL,
    nr_ddd      NUMBER(3) NOT NULL,
    nr_telefone NUMBER(10) NOT NULL,
    tp_telefone VARCHAR2(20) NOT NULL,
    st_telefone CHAR(1) NOT NULL
);

ALTER TABLE t_rhstu_telefone_paciente
    ADD CONSTRAINT uk_rhstu_status_telef_paciente CHECK ( st_telefone IN ( 'A', 'I' ) );

COMMENT ON COLUMN t_rhstu_telefone_paciente.id_paciente IS
    'Esse atributo irá receber a chave primária do paciente. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.id_telefone IS
    'Esse atributo irá receber a chave primária do telefone do paciente. Esse número é sequencial iniciando com 1 a partir do id do paciente e é  gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_ddi IS
    'Este atributo irá receber o número do DDI do telefone do  paciente. Seu conteudo é obrigatório.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_ddd IS
    'Esse atributo irá receber o número do DDD do telefone paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.nr_telefone IS
    'Esse atributo irá receber o número do telefone do  DDD do telefone paciente.  Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_telefone_paciente.tp_telefone IS
    'Esse atributo irá receber o tipo do  telefone  do telefone paciente.  Seu conteúdo é obrigatório e os valores possiveis são: Comercial, Residencial, Recado e Celular';

COMMENT ON COLUMN t_rhstu_telefone_paciente.st_telefone IS
    'Esse atributo irá receber o status do telefone do paciente.  Seu conteúdo é obrigatório e deve possuir os seguintes valores: (A)tivo ou (I)nativo.';

ALTER TABLE t_rhstu_telefone_paciente ADD CONSTRAINT pk_rhstu_telefone_paciente PRIMARY KEY ( id_telefone,
                                                                                              id_paciente );

CREATE TABLE t_rhstu_tipo_contato (
    id_tipo_contato NUMBER(5) NOT NULL,
    nm_tipo_contato VARCHAR2(80) NOT NULL,
    dt_inicio       DATE NOT NULL,
    dt_fim          DATE
);

COMMENT ON COLUMN t_rhstu_tipo_contato.id_tipo_contato IS
    'Esse atributo irá receber a chave primária do tipo do contato. Esse número é sequencial e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_tipo_contato.nm_tipo_contato IS
    'Este atributo irá  receber o nome  do tipo de contato (Mãe, Pai, Prima(o), Irmã(o), Amiga(o), Colega de trabalho) entre outros. Seu conteudo é obrigatório.
';

COMMENT ON COLUMN t_rhstu_tipo_contato.dt_inicio IS
    'Este atributo irá  receber a data de início de validade do tipo do contato. Seu conteudo é obrigatório.';

COMMENT ON COLUMN t_rhstu_tipo_contato.dt_fim IS
    'Este atributo irá  receber a data de término  de validade do tipo do contato. Seu conteudo é obrigatório.';

ALTER TABLE t_rhstu_tipo_contato ADD CONSTRAINT pk_rhstu_tipo_contato PRIMARY KEY ( id_tipo_contato );

CREATE TABLE t_rhstu_unid_hospitalar (
    id_unid_hospital          NUMBER(9) NOT NULL,
    id_logradouro             NUMBER(10) NOT NULL,
    nm_unid_hospitalar        VARCHAR2(80) NOT NULL,
    nm_razao_social_unid_hosp VARCHAR2(80) NOT NULL,
    dt_fundacao               DATE,
    nr_logradouro             NUMBER(7),
    ds_complemento_numero     VARCHAR2(30),
    ds_ponto_referencia       VARCHAR2(50),
    dt_inicio                 DATE NOT NULL,
    dt_termino                DATE
);

COMMENT ON COLUMN t_rhstu_unid_hospitalar.id_unid_hospital IS
    'Esse atributo irá receber a chave primária da Unidade Hospitalar. Esse número é sequencia e gerado automaticamente pelo sistema. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.nr_logradouro IS
    'Esse atributo irá receber o número do logradouro do endereco da Unidade Hospitalar.  Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.ds_complemento_numero IS
    'Esse atributo irá receber o complemeneto  do logradouro do endereco da Unidade Hospitalar caso ele exista. Seu conteúdo é opcional.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.ds_ponto_referencia IS
    'Esse atributo irá receber o ponto de referência  do logradouro do endereco da Unidade Hospitalar.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_inicio IS
    'Esse atributo irá receber a data inicio do endereço da Unidade Hospitalar associado ao endereço (logradouro). Seu conteúdo é obrigatorio.';

COMMENT ON COLUMN t_rhstu_unid_hospitalar.dt_termino IS
    'Esse atributo irá receber a data término  do endereço da Unidade Hospitalar associado ao endereço (logradouro). Seu conteúdo é opcional.';

ALTER TABLE t_rhstu_unid_hospitalar ADD CONSTRAINT pk_rhstu_uni_hosp_end PRIMARY KEY ( id_unid_hospital );

ALTER TABLE t_rhstu_unid_hospitalar
    ADD CONSTRAINT fk_logr_end_unid_hospitalar FOREIGN KEY ( id_logradouro )
        REFERENCES t_rhstu_logradouro ( id_logradouro );

ALTER TABLE t_rhstu_contato_paciente
    ADD CONSTRAINT fk_paciente_contato_emerg FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_endereco_paciente
    ADD CONSTRAINT fk_paciente_endereco FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_logradouro
    ADD CONSTRAINT fk_rhstu_bairro_logradouro FOREIGN KEY ( id_bairro )
        REFERENCES t_rhstu_bairro ( id_bairro );

ALTER TABLE t_rhstu_bairro
    ADD CONSTRAINT fk_rhstu_cidade_bairro FOREIGN KEY ( id_cidade )
        REFERENCES t_rhstu_cidade ( id_cidade );

ALTER TABLE t_rhstu_cidade
    ADD CONSTRAINT fk_rhstu_estado_cidade FOREIGN KEY ( id_estado )
        REFERENCES t_rhstu_estado ( id_estado );

ALTER TABLE t_rhstu_endereco_paciente
    ADD CONSTRAINT fk_rhstu_logr_end_paciente FOREIGN KEY ( id_logradouro )
        REFERENCES t_rhstu_logradouro ( id_logradouro );

ALTER TABLE t_rhstu_paciente_plano_saude
    ADD CONSTRAINT fk_rhstu_pac_plano_saude FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_email_paciente
    ADD CONSTRAINT fk_rhstu_paciente_email FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_telefone_paciente
    ADD CONSTRAINT fk_rhstu_paciente_telef FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_paciente_plano_saude
    ADD CONSTRAINT fk_rhstu_plano_saude_pac FOREIGN KEY ( id_plano_saude )
        REFERENCES t_rhstu_plano_saude ( id_plano_saude );

ALTER TABLE t_rhstu_contato_paciente
    ADD CONSTRAINT fk_rhstu_tipo_contato FOREIGN KEY ( id_tipo_contato )
        REFERENCES t_rhstu_tipo_contato ( id_tipo_contato );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_rhstu_unid_hosp_consulta FOREIGN KEY ( id_unid_hospital )
        REFERENCES t_rhstu_unid_hospitalar ( id_unid_hospital );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_stu_consulta_forma_pagto FOREIGN KEY ( nr_consulta,
                                                             id_unid_hospital )
        REFERENCES t_rhstu_consulta ( nr_consulta,
                                      id_unid_hospital );

ALTER TABLE t_rhstu_prescicao_medica
    ADD CONSTRAINT fk_stu_consulta_presc_medica FOREIGN KEY ( nr_consulta,
                                                              id_unid_hospital )
        REFERENCES t_rhstu_consulta ( nr_consulta,
                                      id_unid_hospital );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_stu_forma_pagto_consulta FOREIGN KEY ( id_forma_pagto )
        REFERENCES t_rhstu_forma_pagamento ( id_forma_pagto );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_stu_med_consulta FOREIGN KEY ( cd_medico )
        REFERENCES t_rhstu_medico ( cd_medico );

ALTER TABLE t_rhstu_prescicao_medica
    ADD CONSTRAINT fk_stu_medicamento_pm FOREIGN KEY ( id_medicamento )
        REFERENCES t_rhstu_medicamento ( id_medicamento );

ALTER TABLE t_rhstu_consulta
    ADD CONSTRAINT fk_stu_pac_consulta FOREIGN KEY ( id_paciente )
        REFERENCES t_rhstu_paciente ( id_paciente );

ALTER TABLE t_rhstu_consulta_forma_pagto
    ADD CONSTRAINT fk_stu_pac_ps_cnst_fp FOREIGN KEY ( id_paciente_ps )
        REFERENCES t_rhstu_paciente_plano_saude ( id_paciente_ps );

CREATE SEQUENCE SQ_RHSTU_BAIRRO 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_BAIRRO 
BEFORE INSERT ON T_RHSTU_BAIRRO 
FOR EACH ROW 
WHEN (NEW.ID_BAIRRO IS NULL) 
BEGIN
:new.id_bairro := sq_rhstu_bairro.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_CIDADE 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_CIDADE 
BEFORE INSERT ON T_RHSTU_CIDADE 
FOR EACH ROW 
WHEN (NEW.ID_CIDADE IS NULL) 
BEGIN
:new.id_cidade := sq_rhstu_cidade.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_CONS_FORM_PAGTO 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU__CONS_FORM_PAGTO 
BEFORE INSERT ON T_RHSTU_CONSULTA_FORMA_PAGTO 
FOR EACH ROW 
WHEN (NEW.ID_CONSULTA_FORMA_PAGTO IS NULL) 
BEGIN
:new.id_consulta_forma_pagto := sq_rhstu_cons_form_pagto.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_PAC_EMAIL 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_PAC_EMAIL 
BEFORE INSERT ON T_RHSTU_EMAIL_PACIENTE 
FOR EACH ROW 
WHEN (NEW.ID_EMAIL IS NULL) 
BEGIN
:new.id_email := sq_rhstu_pac_email.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_END_PACIENTE 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_END_PACIENTE 
BEFORE INSERT ON T_RHSTU_ENDERECO_PACIENTE 
FOR EACH ROW 
WHEN (NEW.ID_ENDERECO IS NULL) 
BEGIN
:new.id_endereco := sq_rhstu_end_paciente.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_ESTADO 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_ESTADO 
BEFORE INSERT ON T_RHSTU_ESTADO 
FOR EACH ROW 
WHEN (NEW.ID_ESTADO IS NULL) 
BEGIN
:new.id_estado := sq_rhstu_estado.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_FORMA_PAGTO 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_FORMA_PAGTO 
BEFORE INSERT ON T_RHSTU_FORMA_PAGAMENTO 
FOR EACH ROW 
WHEN (NEW.ID_FORMA_PAGTO IS NULL) 
BEGIN
:new.id_forma_pagto := sq_rhstu_forma_pagto.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_LOGRADOURO 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_LOGRADOURO 
BEFORE INSERT ON T_RHSTU_LOGRADOURO 
FOR EACH ROW 
WHEN (NEW.ID_LOGRADOURO IS NULL) 
BEGIN
:new.id_logradouro := sq_rhstu_logradouro.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_MEDICAMENTO 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_MEDICAMENTO 
BEFORE INSERT ON T_RHSTU_MEDICAMENTO 
FOR EACH ROW 
WHEN (NEW.ID_MEDICAMENTO IS NULL) 
BEGIN
:new.id_medicamento := sq_rhstu_medicamento.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_MEDICO 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_MEDICO 
BEFORE INSERT ON T_RHSTU_MEDICO 
FOR EACH ROW 
WHEN (NEW.CD_MEDICO IS NULL) 
BEGIN
:new.cd_medico := sq_rhstu_medico.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_PACIENTE 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER RT_RHSTU_PACIENTE 
BEFORE INSERT ON T_RHSTU_PACIENTE 
FOR EACH ROW 
WHEN (NEW.ID_PACIENTE IS NULL) 
BEGIN
:new.id_paciente := sq_rhstu_paciente.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_PACIENTE_PS 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_PACIENTE_PS 
BEFORE INSERT ON T_RHSTU_PACIENTE_PLANO_SAUDE 
FOR EACH ROW 
WHEN (NEW.ID_PACIENTE_PS IS NULL) 
BEGIN
:new.id_paciente_ps := sq_rhstu_paciente_ps.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_PLANO_SAUDE 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_PLANO_SAUDE 
BEFORE INSERT ON T_RHSTU_PLANO_SAUDE 
FOR EACH ROW 
WHEN (NEW.ID_PLANO_SAUDE IS NULL) 
BEGIN
:new.id_plano_saude := sq_rhstu_plano_saude.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_PRESC_MEDICA 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_PRESC_MEDICA 
BEFORE INSERT ON T_RHSTU_PRESCICAO_MEDICA 
FOR EACH ROW 
WHEN (NEW.ID_PRESCRICAO_MEDICA IS NULL) 
BEGIN
:new.id_prescricao_medica := sq_rhstu_presc_medica.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_TIPO_CONTATO 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_TIPO_CONTATO 
BEFORE INSERT ON T_RHSTU_TIPO_CONTATO 
FOR EACH ROW 
WHEN (NEW.ID_TIPO_CONTATO IS NULL) 
BEGIN
:new.id_tipo_contato := sq_rhstu_tipo_contato.nextval;

end;
/

CREATE SEQUENCE SQ_RHSTU_UNID_HOSP 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_RHSTU_UNID_HOSP 
BEFORE INSERT ON T_RHSTU_UNID_HOSPITALAR 
FOR EACH ROW 
WHEN (NEW.ID_UNID_HOSPITAL IS NULL) 
BEGIN
:new.id_unid_hospital := sq_rhstu_unid_hosp.nextval;

end;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            19
-- CREATE INDEX                             0
-- ALTER TABLE                             49
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                          16
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
-- CREATE SEQUENCE                         16
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
