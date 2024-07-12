-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui
CREATE TABLE student_prediction(
	studentID SERIAL PRIMARY KEY,
	age INT,
	gender INT,
	hs_type INT,
	scholarship INT,
	work INT,
	activity INT,
	PARTNER INT,
	SALARY INT,
	TRANSPORT INT,
	LIVING INT,
	MOTHER_EDU INT,
	FATHER_EDU INT,
	SIBLINGS INT,
	KIDS INT,
	MOTHER_JOB INT,
	FATHER_JOB INT,
	STUDY_HRS INT,
	READ_FREQ INT,
	READ_FREQ_SCI INT,
	ATTEND_DEPT INT,
	IMPACT INT,
	ATTEND INT,
	PREP_STUDY INT,
	PREP_EXAM INT,
	NOTES INT,
	LISTENS INT,
	LIKES_DISCUSS INT,
	CLASSROOM INT,
	CUML_GPA INT,
	EXP_GPA INT,
	COURSE_ID INT,
	GRADE INT
	
)

-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui
DO $$
DECLARE
--1. declaração do cursor
    cur_alunos_aprovados REFCURSOR;
    v_aluno INT;
BEGIN

    --2. abertura do cursor
    OPEN cur_alunos_aprovados FOR
    SELECT studentid
    FROM
    student_prediction
    WHERE
    grade != 0 AND
    father_edu = 6 OR
    mother_edu = 6;

    LOOP
    --3. Recuperação dos dados de interesse
    FETCH cur_alunos_aprovados INTO v_aluno;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE '%', v_aluno;
    END LOOP;
    --4. Fechamento do cursos
    CLOSE cur_alunos_aprovados;
END;

-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui

DO $$
    DECLARE
        cur_alunos_sozinhos REFCURSOR;
        v_alunos INT DEFAULT -1;
        v_estudo INT := 1;
        v_nome_tabela VARCHAR(200) := 'student_prediction';
        BEGIN
        OPEN cur_alunos_sozinhos FOR EXECUTE
        format
        (
            '
            SELECT
            studentid
            FROM
            %s
            WHERE prep_study = $1
            '
            ,
            v_nome_tabela
        )USING v_estudo;

        LOOP
        FETCH cur_alunos_sozinhos INTO v_alunos;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%', v_alunos;
        END LOOP;
        CLOSE cur_alunos_sozinhos;
    END;
$$


-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui
DO $$
DECLARE
    --cursor vinculado (bound)
    cur_alunos_salario CURSOR FOR SELECT studentid FROM
    student_prediction
    WHERE salary = 5 AND prep_exam = 2;
    tupla RECORD;
    resultado TEXT DEFAULT '';
    BEGIN

    OPEN cur_alunos_salario;
    FETCH cur_alunos_salario INTO tupla;
    WHILE FOUND LOOP
        resultado := resultado || tupla.studentid || ',' ;
        FETCH cur_alunos_salario INTO tupla;
    END LOOP;
    CLOSE cur_alunos_salario;
    RAISE NOTICE '%', tupla;
END;
$$


-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- ----------------------------------------------------------------