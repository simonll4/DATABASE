
#correlativas con informatica 1
WITH RECURSIVE  cte_informatica1 AS (
		SELECT m.idMateria, m.nombre, m.cargaHoraria, m.cantidadAlumnos, m.idCorrelativa, m.idCorrelativa2, s.semestre
        FROM Materia m INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
        WHERE m.idMateria=1
        UNION
        SELECT m.idMateria, m.nombre, m.cargaHoraria, m.cantidadAlumnos, m.idCorrelativa, m.idCorrelativa2, s.semestre
		FROM cte_informatica1 a INNER JOIN Materia m ON a.idMateria=m.idCorrelativa OR a.idMateria=m.idCorrelativa2
								INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
    ) 
    SELECT *
    FROM cte_informatica1 ;
    
#carga horaria total de las materias correlativas con info 1
WITH RECURSIVE  cte_informatica1 AS (
		SELECT m.idMateria,m.cargaHoraria
        FROM Materia m INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
        WHERE m.idMateria=1
        UNION
        SELECT m.idMateria, m.cargaHoraria
		FROM cte_informatica1 a INNER JOIN Materia m ON a.idMateria=m.idCorrelativa OR a.idMateria=m.idCorrelativa2
    ) 
    SELECT SUM(cargaHoraria) AS horasDeCursado
    FROM cte_informatica1 ;
    
#correlativas con redes 1
WITH RECURSIVE 
	cte_redes1 AS (
		SELECT m.idMateria, m.nombre, m.cargaHoraria, m.idCorrelativa, m.idCorrelativa2, s.semestre
        FROM Materia m INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
        WHERE m.idMateria=8
		UNION
        SELECT m.idMateria, m.nombre, m.cargaHoraria, m.idCorrelativa, m.idCorrelativa2, s.semestre
		FROM cte_redes1 a INNER JOIN Materia m ON a.idMateria=m.idCorrelativa OR a.idMateria=m.idCorrelativa2
								INNER JOIN Semestre s ON m.idSemestre=s.idSemestre
    )
    SELECT *
    FROM cte_redes1 ;
    
#alumnos cursando redes
WITH RECURSIVE 
	cte_redes AS (
		SELECT m.idMateria, m.cantidadAlumnos
        FROM Materia m 
        WHERE m.idMateria=8
		UNION
        SELECT m.idMateria, m.cantidadAlumnos
		FROM cte_redes a INNER JOIN Materia m ON a.idMateria=m.idCorrelativa OR a.idMateria=m.idCorrelativa2
    )
    SELECT sum(a.cantidadAlumnos) AS alumnosCursando
    FROM cte_redes a;