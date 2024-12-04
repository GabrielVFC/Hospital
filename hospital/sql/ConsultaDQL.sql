-- Consultas Básicas
-- Liste todos os pacientes e suas respectivas consultas
SELECT p.nome AS paciente, c.data_consulta, c.observacoes
FROM Pacientes p
JOIN Consultas c ON p.id_paciente = c.id_paciente;

-- Liste todos os pacientes sem números de telefone registrados
SELECT * FROM Pacientes WHERE telefone IS NULL;



-- Operadores
-- Encontre todos os médicos com especialidades "Cardiologia" ou "Pediatria"
SELECT * FROM Medicos WHERE especialidade IN ('Cardiologia', 'Pediatria');

-- Mostre todas as consultas agendadas entre 2024-12-01 e 2024-12-10
SELECT * FROM Consultas WHERE data_consulta BETWEEN '2024-12-01' AND '2024-12-10';

-- Filtre pacientes cujo nome começa com "A"
SELECT * FROM Pacientes WHERE nome LIKE 'A%';

-- Liste as especialidades únicas dos médicos
SELECT DISTINCT especialidade FROM Medicos;


-- Funções de agregação
-- Calcule a idade média dos pacientes
SELECT AVG(JULIANDAY('now') - JULIANDAY(data_nascimento)) / 365.25 AS idade_media FROM Pacientes;

-- Conte o número total de consultas realizadas
SELECT COUNT(*) AS total_consultas FROM Consultas;

-- Encontre a primeira e a última data de consulta
SELECT MIN(data_consulta) AS primeira_consulta, MAX(data_consulta) AS ultima_consulta FROM Consultas;

-- Some o total de exames realizados
SELECT COUNT(*) AS total_exames FROM Exames;



-- Cláusulas Avançadas
-- Liste todos os pacientes ordenados por data de nascimento
SELECT * FROM Pacientes ORDER BY data_nascimento;

-- Liste o número de consultas por médico, mostrando apenas médicos com mais de uma consulta
SELECT id_medico, COUNT(*) AS total_consultas
FROM Consultas
GROUP BY id_medico
HAVING COUNT(*) > 1;

-- Obtenha uma lista de exames com os dados dos pacientes e médicos envolvidos
SELECT e.id_exame, p.nome AS paciente, m.nome AS medico, e.tipo_exame, e.resultado
FROM Exames e
JOIN Consultas c ON e.id_consulta = c.id_consulta
JOIN Pacientes p ON c.id_paciente = p.id_paciente
JOIN Medicos m ON c.id_medico = m.id_medico;

-- Combine duas consultas para listar todos os médicos e pacientes em uma única lista
SELECT nome AS nome_pessoa, 'Medico' AS tipo FROM Medicos
UNION
SELECT nome AS nome_pessoa, 'Paciente' AS tipo FROM Pacientes;



-- JOINs
-- Use LEFT JOIN para listar todos os pacientes e suas consultas, incluindo os pacientes sem consultas
SELECT p.nome AS paciente, c.data_consulta
FROM Pacientes p
LEFT JOIN Consultas c ON p.id_paciente = c.id_paciente;

-- Use RIGHT JOIN para listar todos os médicos e as consultas realizadas, incluindo médicos sem consultas
SELECT m.nome AS medico, c.data_consulta
FROM Medicos m
LEFT JOIN Consultas c ON m.id_medico = c.id_medico;

-- Use LEFT JOIN para listar todas as consultas e os exames correspondentes, incluindo consultas sem exames
SELECT c.data_consulta, e.tipo_exame, e.resultado
FROM Consultas c
LEFT JOIN Exames e ON c.id_consulta = e.id_consulta;

-- Use LEFT JOIN para listar todos os médicos e os pacientes que eles atenderam, incluindo médicos que não atenderam pacientes
SELECT m.nome AS medico, p.nome AS paciente
FROM Medicos m
LEFT JOIN Consultas c ON m.id_medico = c.id_medico
LEFT JOIN Pacientes p ON c.id_paciente = p.id_paciente;

