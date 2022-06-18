#correlativas con ingenieria web 1
WITH RECURSIVE cte_ingenieriaWeb1 AS (
	SELECT m.idMateria,m.materia, s.semestre, c.idMateria1
    FROM Materia m INNER JOIN Correlativa c ON m.idMateria=c.idMateria
					INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
	WHERE m.idMateria=5
    UNION
    SELECT m.idMateria,m.materia, s.semestre, c.idMateria1
    FROM cte_ingenieriaWeb1 a INNER JOIN Correlativa c ON a.idMateria=c.idMateria1
								INNER JOIN Materia m ON c.idMateria=m.idMateria
								INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
) SELECT * FROM cte_ingenieriaWeb1
ORDER BY idMateria; 

#correlativas con redes 1
WITH RECURSIVE cte_redes1 AS (
	SELECT m.idMateria, m.materia, s.semestre, c.idMateria1
    FROM Materia m INNER JOIN Correlativa c ON m.idMateria=c.idMateria
					INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
	WHERE m.idMateria=8
	UNION
    SELECT m.idMateria, m.materia, s.semestre , c.idMateria1
    FROM cte_redes1 a INNER JOIN Correlativa c ON a.idMateria=c.idMateria1
							INNER JOIN Materia m ON c.idMateria=m.idMateria
                            INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
    )
    SELECT *
    FROM cte_redes1;
    
#alumnos cursando redes
WITH RECURSIVE cte_redes1 AS (
	SELECT m.idMateria, m.cantAlumnos
    FROM Materia m INNER JOIN Correlativa c ON m.idMateria=c.idMateria
	WHERE m.idMateria=8
	UNION
    SELECT m.idMateria, m.cantAlumnos
    FROM cte_redes1 a INNER JOIN Correlativa c ON a.idMateria=c.idMateria1
							INNER JOIN Materia m ON c.idMateria=m.idMateria
    )
    SELECT SUM(cantAlumnos) AS alumnosCursandoRedes
    FROM cte_redes1;


#correlativas con informatica 1
WITH RECURSIVE  cte_informatica1 AS (
	SELECT m.idMateria, m.materia, s.semestre, c.idMateria1
    FROM Materia m INNER JOIN Correlativa c ON m.idMateria=c.idMateria
					INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
	WHERE m.idMateria=1
	UNION
    SELECT m.idMateria, m.materia, s.semestre , c.idMateria1
    FROM cte_informatica1 a INNER JOIN Correlativa c ON a.idMateria=c.idMateria1
							INNER JOIN Materia m ON c.idMateria=m.idMateria
                            INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
)SELECT a.idMateria, a.materia, a.idMateria1, a.semestre
    FROM cte_informatica1 a
    ORDER BY a.idMateria;
    
#carga horaria total del departmento de informatica
WITH RECURSIVE  cte_informatica1 AS (
	SELECT m.idMateria, m.cargaHoraria
    FROM Materia m INNER JOIN Correlativa c ON m.idMateria=c.idMateria
	WHERE m.idMateria=1
	UNION
    SELECT m.idMateria, m.cargaHoraria
    FROM cte_informatica1 a INNER JOIN Correlativa c ON a.idMateria=c.idMateria1
							INNER JOIN Materia m ON c.idMateria=m.idMateria
)SELECT SUM(cargaHoraria) AS cargaHorariaInformatica
    FROM cte_informatica1;
    
#cantidad de alumnos en el departamento de informatica
WITH RECURSIVE  cte_informatica1 AS (
	SELECT m.idMateria, m.cantAlumnos
    FROM Materia m INNER JOIN Correlativa c ON m.idMateria=c.idMateria
	WHERE m.idMateria=1
	UNION
    SELECT m.idMateria, m.cantAlumnos
    FROM cte_informatica1 a INNER JOIN Correlativa c ON a.idMateria=c.idMateria1
							INNER JOIN Materia m ON c.idMateria=m.idMateria
)SELECT SUM(cantAlumnos) AS cantidadAlumnosDeptoInformatica
    FROM cte_informatica1;




    
    
    
    
    
    