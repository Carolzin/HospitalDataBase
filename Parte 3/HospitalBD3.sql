DROP DATABASE IF EXISTS  Hospital;
CREATE DATABASE IF NOT EXISTS hospital;
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

INSERT INTO Especialidade (Nome) VALUES 
('Pediatria'),
('Clínica Geral'),
('Gastroenterologia'),
('Dermatologia'),
('Ortopedia'),
('Cardiologia'),
('Neurologia');

INSERT INTO Medico (Nome, Especialidade_ID) VALUES 
('Dr. Gustavo Portela', 1),
('Dr. Gabriel Augusto', 2),
('Dr. Josineudo Arruda', 3),
('Dr. Caroline Fernandes', 4),
('Dr. Paulo Mendes', 5),
('Dr. Fernanda Lima', 6),
('Dr. Gustavo Alves', 7),
('Dr. Roberta Freitas', 2),
('Dr. Ricardo Santos', 3),
('Dr. Bianca Andrade', 1);

INSERT INTO Convenio (CNPJ, Nome, Tempo_Carencia) VALUES
('12345678000101', 'Convenio Saúde Total', 12),
('23456789000112', 'Plano Vida Plena', 6),
('34567890000123', 'Saúde Completa', 9),
('45678901000134', 'Bem-Estar Médico', 3);

INSERT INTO Paciente (CPF, Nome, Endereco, Telefone, Data_Nasc, RG, Email, Convenio_CNPJ) VALUES
('11111111111', 'Ana Costa', 'Rua das Flores, 123', '(11) 99999-1111', '1990-05-14', 'MG1234567', 'ana.costa@email.com', '12345678000101'),
('22222222222', 'João Pereira', 'Avenida Brasil, 456', '(11) 99999-2222', '1985-03-22', 'SP7654321', 'joao.pereira@email.com', '23456789000112'),
('33333333333', 'Maria Souza', 'Rua da Paz, 789', '(21) 99999-3333', '1992-07-01', 'RJ9876543', 'maria.souza@email.com', '34567890000123'),
('44444444444', 'Carlos Silva', 'Avenida Paulista, 321', '(11) 99999-4444', '1980-12-12', 'SP1239874', 'carlos.silva@email.com', '45678901000134'),
('55555555555', 'Beatriz Lima', 'Rua do Sol, 987', '(21) 99999-5555', '1995-02-19', 'RJ6789123', 'beatriz.lima@email.com', '12345678000101'),
('66666666666', 'Roberto Dias', 'Avenida Rio Branco, 654', '(31) 99999-6666', '1978-06-25', 'MG4567891', 'roberto.dias@email.com', '23456789000112'),
('77777777777', 'Fernanda Oliveira', 'Rua das Acácias, 111', '(11) 99999-7777', '1989-11-11', 'SP2345678', 'fernanda.oliveira@email.com', '34567890000123'),
('88888888888', 'Ricardo Andrade', 'Avenida das Nações, 222', '(21) 99999-8888', '1991-09-08', 'RJ3216547', 'ricardo.andrade@email.com', '45678901000134'),
('99999999999', 'Patrícia Ferreira', 'Rua dos Cravos, 333', '(41) 99999-9999', '1983-01-20', 'PR6549873', 'patricia.ferreira@email.com', '12345678000101'),
('10101010101', 'Gabriel Martins', 'Avenida São João, 444', '(31) 99999-1010', '1994-04-04', 'MG8765432', 'gabriel.martins@email.com', '23456789000112'),
('12121212121', 'Juliana Barbosa', 'Rua das Palmeiras, 555', '(11) 99999-1212', '1997-08-18', 'SP4321987', 'juliana.barbosa@email.com', '34567890000123'),
('13131313131', 'Lucas Melo', 'Avenida Santos Dumont, 666', '(21) 99999-1313', '1987-10-10', 'RJ1236548', 'lucas.melo@email.com', '45678901000134'),
('14141414141', 'Isabela Faria', 'Rua dos Lírios, 777', '(41) 99999-1414', '1993-03-30', 'PR9871234', 'isabela.faria@email.com', '12345678000101'),
('15151515151', 'Bruno Rocha', 'Avenida 9 de Julho, 888', '(31) 99999-1515', '1990-07-07', 'MG4561238', 'bruno.rocha@email.com', '23456789000112');

INSERT INTO Tipo_Quarto (Valor_Diaria, Descricao) VALUES 
(100.00, 'Quarto Simples'),
(150.00, 'Quarto Duplo'),
(200.00, 'Quarto Luxo');

INSERT INTO Quarto (Numero, Tipo_ID) VALUES 
(101, 1),
(102, 1),
(201, 2),
(202, 2),
(301, 3),
(302, 3);

INSERT INTO Internacao (Paciente_CPF, Medico_ID, Quarto_Numero, Data_Entrada, Data_Prev_Alta, Data_Alta, Procedimento) VALUES
('11111111111', 1, 101, '2024-10-01', '2024-10-05', NULL, 'Tratamento de pneumonia'),
('22222222222', 2, 102, '2024-10-03', '2024-10-07', NULL, 'Cirurgia de apendicite'),
('33333333333', 3, 201, '2024-10-05', '2024-10-10', NULL, 'Consulta de rotina'),
('44444444444', 4, 202, '2024-10-06', '2024-10-12', NULL, 'Tratamento dermatológico'),
('55555555555', 5, 301, '2024-10-07', '2024-10-14', NULL, 'Fratura no braço'),
('66666666666', 6, 302, '2024-10-08', '2024-10-15', NULL, 'Check-up geral');

SELECT * FROM Internacao;

