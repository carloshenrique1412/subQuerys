use dbEscolaIdioma
go

---a) Criar uma consulta que retorne o nome e o preço dos cursos que custem abaixo do valor médio

SELECT nomeCurso, valorCurso FROM tbCurso WHERE valorCurso < (SELECT AVG(valorCurso) FROM tbCurso);

---b) Criar uma consulta que retorne o nome e o RG do aluno mais novo

SELECT nomeAluno, rgAluno FROM tbAluno WHERE dataNascimento = (SELECT MAX(dataNascimento) FROM tbAluno);

---c) Criar uma consulta que retorne o nome do aluno mais velho

SELECT nomeAluno FROm tbALuno WHERE dataNascimento = (SELECT MIN(dataNascimento) FROM tbAluno);

---d) Criar uma consulta que retorne o nome e o valor do curso mais caro
SELECT nomeCurso, valorCurso FROM tbCurso WHERE valorCurso = (SELECT MAX(valorCurso) FROM tbCurso);

---e) Criar uma consulta que retorne o nome do aluno e o nome do curso do aluno que fez a última matrícula

SELECT a.nomeAluno, c.nomeCurso FROM tbAluno a
        INNER JOIN tbMatricula m
            ON a.codAluno = m.codAluno
                INNER JOIN tbTurma t
                ON m.codTurma = t.codTurma
                    INNER JOIN tbCurso c
                    ON t.codCurso = c.codCurso
                            WHERE m.dataMatricula =
(
    SELECT MAX(dataMatricula)
    FROM tbMatricula
);

---f) Criar uma consulta que retorne o nome do primeiro aluno a ser matriculado na escola de idiomas

SELECT nomeAluno FROM tbAluno WHERE codAluno =
(
    SELECT codAluno FROM tbMatricula
    WHERE dataMatricula = (
        SELECT MIN(dataMatricula)
        FROM tbMatricula
    )
);

--g) Criar uma consulta que retorne o nome, RG e data de nascimento de todos os alunos que estejam matriculados no curso de Inglês
SELECT nomeAluno, rgAluno, dataNascimento FROM tbAluno
        WHERE codAluno IN(
    SELECT m.codAluno  FROM tbMatricula m
    INNER JOIN tbTurma t ON m.codTurma = t.codTurma
        INNER JOIN tbCurso c
            ON t.codCurso = c.codCurso
                WHERE c.nomeCurso = 'Inglês'
         );
