
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
