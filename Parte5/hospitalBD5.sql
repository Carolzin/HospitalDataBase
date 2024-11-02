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
('11111111111', 1, 101, '2024-10-01', '2024-10-05', '2024-10-05', 'Tratamento de pneumonia'),
('22222222222', 2, 102, '2024-10-03', '2024-10-07', '2024-10-07', 'Cirurgia de apendicite'),
('33333333333', 3, 201, '2024-10-05', '2024-10-10', '2024-10-10', 'Consulta de rotina'),
('44444444444', 4, 202, '2024-10-06', '2024-10-12', '2024-10-12', 'Tratamento dermatológico'),
('55555555555', 5, 301, '2024-10-07', '2024-10-14', '2024-10-14', 'Fratura no braço'),
('66666666666', 6, 302, '2024-10-08', '2024-10-15', '2024-10-15', 'Check-up geral');


INSERT INTO Consulta (Num_Carteira, Data, Hora, Valor, Paciente_CPF, Medico_ID, Convenio_CNPJ, Especialidade_ID) VALUES
('C12345', '2024-10-10', '09:00:00', 150.00, '11111111111', 1, '12345678000101', 1),
('C12346', '2024-10-11', '10:00:00', 200.00, '22222222222', 2, '23456789000112', 2),
('C12347', '2024-10-12', '11:00:00', 120.00, '33333333333', 3, '34567890000123', 3),
('C12348', '2024-10-13', '08:30:00', 175.00, '44444444444', 4, '45678901000134', 4),
('C12349', '2024-10-14', '14:00:00', 90.00, '55555555555', 5, '12345678000101', 5),
('C12350', '2024-10-15', '16:00:00', 160.00, '66666666666', 6, '23456789000112', 6),
('C12351', '2024-10-16', '10:30:00', 110.00, '77777777777', 7, '34567890000123', 7),
('C12352', '2024-10-17', '13:00:00', 140.00, '88888888888', 2, '45678901000134', 2),
('C12353', '2024-10-18', '11:30:00', 155.00, '99999999999', 3, '12345678000101', 3),
('C12354', '2024-10-19', '15:30:00', 135.00, '10101010101', 4, '23456789000112', 4),
('C12355', '2024-10-20', '09:15:00', 145.00, '12121212121', 5, '34567890000123', 5),
('C12356', '2024-10-21', '17:00:00', 165.00, '13131313131', 6, '45678901000134', 6),
('C12357', '2024-10-22', '10:45:00', 125.00, '14141414141', 7, '12345678000101', 7),
('C12358', '2024-10-23', '13:15:00', 175.00, '15151515151', 2, '23456789000112', 2),
('C12359', '2024-10-24', '09:30:00', 190.00, '11111111111', 3, '34567890000123', 3),
('C12360', '2024-10-25', '14:15:00', 180.00, '22222222222', 4, '45678901000134', 4),
('C12361', '2024-10-26', '11:00:00', 170.00, '33333333333', 5, '12345678000101', 5),
('C12362', '2024-10-27', '12:00:00', 165.00, '44444444444', 6, '23456789000112', 6),
('C12363', '2024-10-28', '10:00:00', 150.00, '55555555555', 7, '34567890000123', 7),
('C12364', '2024-10-29', '15:00:00', 155.00, '66666666666', 2, '45678901000134', 2);

INSERT INTO Receita (Consulta_ID, Medicamento, Quantidade, Instrucoes) VALUES
(1, 'Paracetamol', 2, 'Tomar a cada 8 horas se necessário'),
(2, 'Amoxicilina', 10, 'Tomar durante 7 dias'),
(3, 'Ibuprofeno', 5, 'Tomar a cada 6 horas após as refeições'),
(4, 'Cetirizina', 15, 'Tomar 1 comprimido ao dia'),
(5, 'Omeprazol', 30, 'Tomar 1 comprimido em jejum'),
(6, 'Dipirona', 12, 'Tomar a cada 6 horas se necessário'),
(7, 'Ranitidina', 8, 'Tomar 1 comprimido duas vezes ao dia'),
(8, 'Losartana', 30, 'Tomar 1 comprimido ao dia'),
(9, 'Simeticona', 20, 'Tomar após as refeições conforme necessário'),
(10, 'Lorazepam', 5, 'Tomar 1 comprimido à noite'),
(11, 'Sibutramina', 30, 'Tomar 1 comprimido ao dia'),
(12, 'Fluoxetina', 15, 'Tomar 1 comprimido ao dia'),
(13, 'Glucosamina', 10, 'Tomar 1 comprimido duas vezes ao dia'),
(14, 'Metformina', 60, 'Tomar 1 comprimido com as refeições'),
(15, 'Insulina', 5, 'Aplicar conforme orientação médica'),
(16, 'Atenolol', 30, 'Tomar 1 comprimido ao dia'),
(17, 'Ciprofloxacino', 14, 'Tomar 1 comprimido a cada 12 horas'),
(18, 'Sertralina', 15, 'Tomar 1 comprimido ao dia'),
(19, 'Dexametasona', 10, 'Tomar 1 comprimido ao dia durante 5 dias'),
(20, 'Furosemida', 30, 'Tomar 1 comprimido ao dia');

INSERT INTO Enfermeiro (Nome, CPF, Coren) VALUES
('Juliana Costa', '22222222222', 'COREN1234'),
('Marcos Silva', '33333333333', 'COREN5678'),
('Ana Paula', '44444444444', 'COREN9101'),
('Ricardo Almeida', '55555555555', 'COREN1121'),
('Fernanda Souza', '66666666666', 'COREN3141'),
('Bruno Dias', '77777777777', 'COREN4151'),
('Camila Pereira', '88888888888', 'COREN6161'),
('Daniel Ferreira', '99999999999', 'COREN7181'),
('Tatiane Lima', '10101010101', 'COREN8191'),
('André Martins', '11111111111', 'COREN9201'),
('Gustavo Rocha', '12121212121', 'COREN0212'),
('Aline Nascimento', '13131313131', 'COREN1222'),
('Roberta Santos', '14141414141', 'COREN2232'),
('Carlos Mendes', '15151515151', 'COREN3242'),
('Isabela Lima', '16161616161', 'COREN4252'),
('Felipe Alves', '17171717171', 'COREN5262'),
('Vanessa Oliveira', '18181818181', 'COREN6272'),
('Julio César', '19191919191', 'COREN7282'),
('Rafaela Costa', '20202020202', 'COREN8292'),
('Paulo Henrique', '21212121212', 'COREN9302');

ALTER TABLE Medico ADD COLUMN Em_atividade VARCHAR (10);

UPDATE Medico SET Em_atividade = 'Ativo';

UPDATE Medico SET Em_atividade = 'Inativo' WHERE ID IN (1, 2);

SELECT * FROM Internacao;



