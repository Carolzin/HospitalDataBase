-- Consulta 1
SELECT *, AVG(Valor) AS Media_Valor_Consultas
FROM Consulta
WHERE YEAR(Data) = 2020 OR Convenio_CNPJ IS NOT NULL
GROUP BY ID;

-- Consulta 2
SELECT ID, Data_Alta, Data_Prev_Alta
FROM Internacao
WHERE Data_Alta IS NOT NULL;


-- Consulta 3
SELECT c.*, r.*
FROM Consulta c
LEFT JOIN Receita r ON c.ID = r.Consulta_ID
ORDER BY c.Data ASC
LIMIT 1;

-- Consulta 4
SELECT *
FROM Consulta
WHERE Convenio_CNPJ IS NULL
AND (Valor = (SELECT MAX(Valor) FROM Consulta WHERE Convenio_CNPJ IS NULL)
OR Valor = (SELECT MIN(Valor) FROM Consulta WHERE Convenio_CNPJ IS NULL));


-- Consulta 5
SELECT i.*, q.*, 
DATEDIFF(i.Data_Alta, i.Data_Entrada) * tq.Valor_Diaria AS Total_Internacao
FROM Internacao i
JOIN Quarto q ON i.Quarto_Numero = q.Numero
JOIN Tipo_Quarto tq ON q.Tipo_ID = tq.ID;

-- Consulta 6
SELECT i.Data_Alta, i.Procedimento, i.Quarto_Numero
FROM Internacao i
JOIN Quarto q ON i.Quarto_Numero = q.Numero
WHERE q.Tipo_ID = (SELECT ID FROM Tipo_Quarto WHERE Descricao = 'Quarto Luxo');

-- Consulta 7
SELECT p.Nome AS Nome_Paciente, c.Data AS Data_Consulta, e.Nome AS Especialidade
FROM Paciente p
JOIN Consulta c ON p.CPF = c.Paciente_CPF
JOIN Medico m ON c.Medico_ID = m.ID
JOIN Especialidade e ON m.Especialidade_ID = e.ID
WHERE (DATEDIFF(c.Data, p.Data_Nasc) / 365) < 18
AND e.Nome <> 'Pediatria'
ORDER BY c.Data;


-- Consulta 8
SELECT p.Nome AS Nome_Paciente, m.Nome AS Nome_Medico, i.Data_Entrada, i.Procedimento
FROM Internacao i
JOIN Medico m ON i.Medico_ID = m.ID
JOIN Paciente p ON i.Paciente_CPF = p.CPF
WHERE m.Especialidade_ID = (SELECT ID FROM Especialidade WHERE Nome = 'Gastroenterologia')
AND i.Quarto_Numero IN (SELECT Numero FROM Quarto q JOIN Tipo_Quarto tq ON q.Tipo_ID = tq.ID WHERE tq.Descricao = 'Quarto Duplo');

-- Consulta 9
SELECT m.Nome, m.ID AS CRM, COUNT(c.ID) AS Total_Consultas
FROM Medico m
LEFT JOIN Consulta c ON m.ID = c.Medico_ID
GROUP BY m.ID;

-- Consulta 10
SELECT *
FROM Medico
WHERE Nome LIKE '%Gabriel%';

-- Consulta 11
SELECT e.Nome, e.Coren, COUNT(i.ID) AS Numero_Internacoes
FROM Enfermeiro e
JOIN Internacao i ON i.Medico_ID IN (SELECT ID FROM Medico WHERE ID IN (SELECT Medico_ID FROM Internacao WHERE Paciente_CPF IS NOT NULL))
GROUP BY e.ID
HAVING COUNT(i.ID) > 1;

