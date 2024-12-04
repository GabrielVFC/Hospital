# Sistema de Gerenciamento Hospitalar
## Objetivo
Este sistema tem como objetivo a criação de um banco de dados para um hospital fictício chamado "Saúde em Dia". O banco deve armazenar informações sobre pacientes, médicos, especialidades, consultas e exames. O projeto envolve a criação de tabelas com as funcionalidades de DDL (Data Definition Language), DML (Data Manipulation Language) e DQL (Data Query Language), além de consultas avançadas e funções agregadas.

# Estrutura do Banco de Dados
## Criação do Banco de Dados e Estrutura das Tabelas (DDL)
```sql

-- Criação do banco de dados
-- No SQLite, você cria o banco ao abrir o arquivo de banco de dados, então não é necessário criar explicitamente um banco de dados como no MySQL.
-- Para criar o banco, basta usar um comando como: sqlite3 hospital.db

-- Criação da tabela Pacientes
CREATE TABLE Pacientes (
    id_paciente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    data_nascimento TEXT NOT NULL,
    telefone TEXT,
    endereco TEXT
);

-- Criação da tabela Medicos
CREATE TABLE Medicos (
    id_medico INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    especialidade TEXT NOT NULL,
    telefone TEXT
);

-- Criação da tabela Consultas
CREATE TABLE Consultas (
    id_consulta INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente INTEGER,
    id_medico INTEGER,
    data_consulta TEXT NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)
);

-- Criação da tabela Exames
CREATE TABLE Exames (
    id_exame INTEGER PRIMARY KEY AUTOINCREMENT,
    id_consulta INTEGER,
    tipo_exame TEXT NOT NULL,
    data_exame TEXT NOT NULL,
    resultado TEXT,
    FOREIGN KEY (id_consulta) REFERENCES Consultas(id_consulta)
);
```
Inserção de Dados (DML)
```sql
-- Inserção de dados na tabela Pacientes
INSERT INTO Pacientes (nome, data_nascimento, telefone, endereco) VALUES
('João Silva', '1985-07-20', '123456789', 'Rua A, 123'),
('Maria Oliveira', '1990-01-15', '987654321', 'Rua B, 456'),
('Carlos Souza', '1978-11-05', '555123456', 'Rua C, 789'),
('Ana Pereira', '1995-03-10', '777888999', 'Rua D, 101'),
('Luiza Costa', '1982-06-30', '999123456', 'Rua E, 202');

-- Inserção de dados na tabela Medicos
INSERT INTO Medicos (nome, especialidade, telefone) VALUES
('Dr. Jorge Lima', 'Cardiologia', '123098456'),
('Dr. Ana Costa', 'Pediatria', '789456123'),
('Dr. Bruno Silva', 'Ortopedia', '456789123'),
('Dr. Carla Oliveira', 'Neurologia', '321654987'),
('Dr. Felipe Santos', 'Dermatologia', '654321987');

-- Inserção de dados na tabela Consultas
INSERT INTO Consultas (id_paciente, id_medico, data_consulta, observacoes) VALUES
(1, 1, '2024-12-05 14:00:00', 'Consulta de rotina'),
(2, 2, '2024-12-06 10:00:00', 'Consulta pediátrica'),
(3, 3, '2024-12-07 09:30:00', 'Exame de ortopedia'),
(4, 4, '2024-12-08 15:30:00', 'Avaliação neurológica'),
(5, 5, '2024-12-09 16:00:00', 'Consulta dermatológica');

-- Inserção de dados na tabela Exames
INSERT INTO Exames (id_consulta, tipo_exame, data_exame, resultado) VALUES
(1, 'Eletrocardiograma', '2024-12-06 14:00:00', 'Normal'),
(2, 'Exame de sangue', '2024-12-07 11:00:00', 'Resultado em análise'),
(3, 'Raio-X', '2024-12-08 09:00:00', 'Fratura detectada'),
(4, 'Tomografia', '2024-12-09 10:00:00', 'Sem alterações'),
(5, 'Biópsia de pele', '2024-12-10 13:00:00', 'Em andamento');
```
Consultas (DQL)
Consultas Básicas
```sql
-- Liste todos os pacientes e suas respectivas consultas
SELECT p.nome AS paciente, c.data_consulta, c.observacoes
FROM Pacientes p
JOIN Consultas c ON p.id_paciente = c.id_paciente;

-- Liste todos os pacientes sem números de telefone registrados
SELECT * FROM Pacientes WHERE telefone IS NULL;
```
Operadores
```sql

-- Encontre todos os médicos com especialidades "Cardiologia" ou "Pediatria"
SELECT * FROM Medicos WHERE especialidade IN ('Cardiologia', 'Pediatria');

-- Mostre todas as consultas agendadas entre 2024-12-01 e 2024-12-10
SELECT * FROM Consultas WHERE data_consulta BETWEEN '2024-12-01' AND '2024-12-10';

-- Filtre pacientes cujo nome começa com "A"
SELECT * FROM Pacientes WHERE nome LIKE 'A%';

-- Liste as especialidades únicas dos médicos
SELECT DISTINCT especialidade FROM Medicos;
```
Funções de Agregação
```sql
-- Calcule a idade média dos pacientes
SELECT AVG(JULIANDAY('now') - JULIANDAY(data_nascimento)) / 365.25 AS idade_media FROM Pacientes;

-- Conte o número total de consultas realizadas
SELECT COUNT(*) AS total_consultas FROM Consultas;

-- Encontre a primeira e a última data de consulta
SELECT MIN(data_consulta) AS primeira_consulta, MAX(data_consulta) AS ultima_consulta FROM Consultas;

-- Some o total de exames realizados
SELECT COUNT(*) AS total_exames FROM Exames;
```
Cláusulas Avançadas
```sql
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
```
JOINs
```sql
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
```
## Considerações
- No SQLite, a principal diferença é o tipo de dados INTEGER PRIMARY KEY AUTOINCREMENT, que é utilizado para criar um campo de chave primária com incremento automático.
- O SQLite também utiliza tipos de dados mais flexíveis, como TEXT e INTEGER, em vez de VARCHAR.
- As funções JULIANDAY() são utilizadas para cálculos de datas e para calcular a idade média, pois o SQLite lida com datas no formato de texto.
Este script foi projetado para funcionar corretamente em um banco de dados SQLite.
