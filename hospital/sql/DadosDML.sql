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
