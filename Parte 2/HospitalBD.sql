USE hospital;

CREATE TABLE IF NOT EXISTS Convenio (
    CNPJ VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(100),
    Tempo_Carencia INT
);

CREATE TABLE IF NOT EXISTS Especialidade (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Tipo_Quarto (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Valor_Diaria DECIMAL(10, 2),
    Descricao VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Medico (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Tipo VARCHAR(50),
    Especialidade_ID INT,
    FOREIGN KEY (Especialidade_ID) REFERENCES Especialidade(ID)
);

CREATE TABLE IF NOT EXISTS Paciente (
    CPF VARCHAR(11) PRIMARY KEY,
    Nome VARCHAR(100),
    Endereco VARCHAR(200),
    Telefone VARCHAR(15),
    Data_Nasc DATE,
    RG VARCHAR(20),
    Email VARCHAR(100),
    Convenio_CNPJ VARCHAR(20),
    FOREIGN KEY (Convenio_CNPJ) REFERENCES Convenio(CNPJ)
);

CREATE TABLE IF NOT EXISTS Quarto (
    Numero INT PRIMARY KEY,
    Tipo_ID INT,
    FOREIGN KEY (Tipo_ID) REFERENCES Tipo_Quarto(ID)
);

CREATE TABLE IF NOT EXISTS Consulta (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Num_Carteira VARCHAR(20),
    Data DATE,
    Hora TIME,
    Valor DECIMAL(10, 2),
    Paciente_CPF VARCHAR(11),
    Medico_ID INT,
    Convenio_CNPJ VARCHAR(20),
    Especialidade_ID INT,
    FOREIGN KEY (Paciente_CPF) REFERENCES Paciente(CPF),
    FOREIGN KEY (Medico_ID) REFERENCES Medico(ID),
    FOREIGN KEY (Convenio_CNPJ) REFERENCES Convenio(CNPJ),
    FOREIGN KEY (Especialidade_ID) REFERENCES Especialidade(ID)
);

CREATE TABLE IF NOT EXISTS Receita (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Consulta_ID INT,
    Medicamento VARCHAR(100),
    Quantidade INT,
    Instrucoes TEXT,
    FOREIGN KEY (Consulta_ID) REFERENCES Consulta(ID)
);

CREATE TABLE IF NOT EXISTS Internacao (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Paciente_CPF VARCHAR(11),
    Medico_ID INT,
    Quarto_Numero INT,
    Data_Entrada DATE,
    Data_Prev_Alta DATE,
    Data_Alta DATE,
    Procedimento TEXT,
    FOREIGN KEY (Paciente_CPF) REFERENCES Paciente(CPF),
    FOREIGN KEY (Medico_ID) REFERENCES Medico(ID),
    FOREIGN KEY (Quarto_Numero) REFERENCES Quarto(Numero)
);

CREATE TABLE IF NOT EXISTS Enfermeiro (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    CPF VARCHAR(11),
    Coren VARCHAR(20)
);

SHOW TABLES;

SELECT * FROM Tipo_Quarto;

