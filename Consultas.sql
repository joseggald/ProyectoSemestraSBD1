-- Consulta 1: para Encontrar el Partido con Más Votos por Elección

SELECT e.Nombre AS Eleccion, e.Ano AS Año, pp.Nombre AS Partido, SUM(re.Votos) AS TotalVotos
FROM ResultadoEleccion re
JOIN Eleccion e ON re.ID_Eleccion = e.ID_Eleccion
JOIN PartidoPolitico pp ON re.ID_Partido = pp.ID_Partido
GROUP BY e.Nombre, e.Ano, pp.Nombre
ORDER BY e.Nombre, e.Ano, SUM(re.Votos) DESC;

-- Consulta 2: para Desplegar la Demografía por Zona

SELECT z.Nombre AS Zona, d.Sexo, d.Raza, d.Educacion, d.Analfabetos, d.Alfabetos, d.Primaria, d.NivelMedio, d.Universitarios
FROM Demografia d
JOIN Zona z ON d.ID_Zona = z.ID_Zona;

-- Consulta 3: para Encontrar el Total de Votos por Partido y Año

SELECT pp.Nombre AS Partido, e.Ano AS Año, SUM(re.Votos) AS TotalVotos
FROM ResultadoEleccion re
JOIN PartidoPolitico pp ON re.ID_Partido = pp.ID_Partido
JOIN Eleccion e ON re.ID_Eleccion = e.ID_Eleccion
GROUP BY pp.Nombre, e.Ano
ORDER BY e.Ano, SUM(re.Votos) DESC;

-- Consulta 4: para Desplegar las Zonas con Mayores Votaciones

SELECT z.Nombre AS Zona, e.Nombre AS Eleccion, e.Ano AS Año, SUM(re.Votos) AS TotalVotos
FROM ResultadoEleccion re
JOIN Eleccion e ON re.ID_Eleccion = e.ID_Eleccion
JOIN Zona z ON e.ID_Zona = z.ID_Zona
GROUP BY z.Nombre, e.Nombre, e.Ano
ORDER BY SUM(re.Votos) DESC;

-- Consulta 5: para Votaciones Según Educación y Raza

SELECT z.Nombre AS Departamento, 
       100 * SUM(CASE WHEN d.Sexo = 'mujeres' AND d.Educacion = 'universitarios' THEN d.Alfabetos ELSE 0 END) /
       GREATEST(SUM(CASE WHEN d.Sexo = 'hombres' AND d.Educacion = 'universitarios' THEN d.Alfabetos ELSE 0 END), 1) AS PorcentajeMujeresVsHombres
FROM Demografia d
JOIN Zona z ON d.ID_Zona = z.ID_Zona
GROUP BY z.Nombre
HAVING SUM(CASE WHEN d.Sexo = 'mujeres' AND d.Educacion = 'universitarios' THEN d.Alfabetos ELSE 0 END) >
       SUM(CASE WHEN d.Sexo = 'hombres' AND d.Educacion = 'universitarios' THEN d.Alfabetos ELSE 0 END);

-- Consulta 6: Promedio de Votos por Departamento en Cada Región

SELECT z1.Nombre AS País, z2.Nombre AS Región, AVG(re.Votos) AS PromedioVotos
FROM ResultadoEleccion re
JOIN Eleccion e ON re.ID_Eleccion = e.ID_Eleccion
JOIN Zona z3 ON e.ID_Zona = z3.ID_Zona
JOIN Zona z2 ON z3.ID_Padre = z2.ID_Zona
JOIN Zona z1 ON z2.ID_Padre = z1.ID_Zona
GROUP BY z1.Nombre, z2.Nombre;

-- Consulta 7: Porcentaje de Votos por Raza en Cada País

SELECT z.Nombre AS País, d.Raza, 100 * SUM(d.Alfabetos) / t.TotalVotos AS Porcentaje
FROM Demografia d
JOIN Zona z ON d.ID_Zona = z.ID_Zona
JOIN (SELECT ID_Zona, SUM(Alfabetos) AS TotalVotos FROM Demografia GROUP BY ID_Zona) t ON z.ID_Zona = t.ID_Zona
GROUP BY z.Nombre, d.Raza;

-- Consulta 8: Países con las Elecciones Más Peleadas

SELECT e.Nombre AS Eleccion, z.Nombre AS País, MAX(re.Votos) - MIN(re.Votos) AS DiferenciaVotos
FROM ResultadoEleccion re
JOIN Eleccion e ON re.ID_Eleccion = e.ID_Eleccion
JOIN Zona z ON e.ID_Zona = z.ID_Zona
GROUP BY e.Nombre, z.Nombre
ORDER BY DiferenciaVotos DESC
LIMIT 1;

-- Consulta 9: País con Mayor Porcentaje de Analfabetas Votantes

SELECT z.Nombre AS País, MAX(100 * SUM(d.Analfabetos) / t.TotalVotos) AS PorcentajeAnalfabetos
FROM Demografia d
JOIN Zona z ON d.ID_Zona = z.ID_Zona
JOIN (SELECT ID_Zona, SUM(Analfabetos) AS TotalVotos FROM Demografia GROUP BY ID_Zona) t ON z.ID_Zona = t.ID_Zona
GROUP BY z.Nombre
ORDER BY PorcentajeAnalfabetos DESC
LIMIT 1;

-- Consulta 10: Departamentos de Guatemala con Más Votos que el Departamento de Guatemala

SELECT z.Nombre AS Departamento, SUM(re.Votos) AS Votos
FROM ResultadoEleccion re
JOIN Eleccion e ON re.ID_Eleccion = e.ID_Eleccion
JOIN Zona z ON e.ID_Zona = z.ID_Zona
JOIN Zona zp ON z.ID_Padre = zp.ID_Zona
WHERE zp.Nombre = 'Guatemala' AND z.Nombre != 'Departamento de Guatemala'
GROUP BY z.Nombre
HAVING SUM(re.Votos) > (
    SELECT SUM(re2.Votos)
    FROM ResultadoEleccion re2
    JOIN Eleccion e2 ON re2.ID_Eleccion = e2.ID_Eleccion
    JOIN Zona z2 ON e2.ID_Zona = z2.ID_Zona
    WHERE z2.Nombre = 'Departamento de Guatemala'
);
