
#1.Clientes inhabilitados, ordenados alfabéticamente [Cliente, Zona]
SELECT c.Cliente,z.Zona
FROM clientes c inner join zonas z on c.idZona = z.idZona
WHERE c.cuentaHabilitada = 0
ORDER BY c.Cliente;

#2.Zonas cuyo nombre contenga el digito 9, ordenadas alfabéticamente descendente. [Zona]
SELECT z.zona
FROM zonas z 
WHERE z.Zona like '%9%'
ORDER BY z.Zona desc; 

select * from clientes;
#3.Clientes cuyo nombre termine con el digito 7. [Cliente, Zona]
SELECT c.cliente,z.zona 
FROM clientes c inner join zonas z on c.idZona=z.idZona
WHERE c.Cliente LIKE '%7';

#4.Productos en cuyo nombre se encuentre el digito 3, en cualquier parte. [Producto]
SELECT p.Producto
FROM productos p
WHERE p.Producto LIKE '%3%';

#5.Facturas anuladas en el año 2008, ordenadas por fecha [Nº de Factura, Fecha, Cliente, Zona, Vendedor]
SELECT fc.numero,fc.fecha,c.Cliente,z.Zona,v.Vendedor
FROM facturacabecera fc inner join clientes c on fc.idCliente=c.idCliente
		INNER JOIN zonas z on z.idZona=c.idZona inner join vendedores v on v.idVendedor= fc.idVendedor
WHERE fc.anulada=1 AND year(fc.fecha) = 2008;

#6.Los 4 Vendedores que tengan mayor comisión. [Vendedor, comisión]
SELECT v.Vendedor,v.Comision
FROM vendedores v
ORDER BY v.Comision DESC
LIMIT 4;

#7.Lista de precios conteniendo 4 columnas: 1) precio base, 2) precio base + 10%, 
#3) precio base + 30%, 4) precio base + 40%. La lista debe estar ordenada por rubro y producto. 
#[Rubro, Producto, PrecioBase, PrecioMayorista, PrecioConDescuento, PrecioPublico]

SELECT *
FROM(
SELECT r.Rubro, p.Producto, p.precio AS precioBase,round(p.precio+p.precio*.1,2) AS precioMayorista, 
		round(p.precio+p.precio*.3,2) AS precioConDescuento,round(p.precio+p.precio*.4,2) AS precioPublico
FROM rubros r inner join productos p on r.idRubro=p.idRubro
ORDER BY r.idRubro
) a
ORDER BY a.Producto;

#8.Lista de los 8 Productos más caros, ordenados alfabéticamente [Producto, Proveedor, Rubro, Precio]
SELECT * 
FROM(
SELECT p.Producto, pr.Proveedor, r.Rubro, p.precio
FROM productos p inner join rubros r on p.idRubro=r.idRubro
	inner join proveedores pr on pr.idProveedor = p.idProveedor
ORDER BY p.Producto DESC LIMIT 8
) a
ORDER BY a.Producto;
        
#9.Lista de Productos de los Rubros 2,5,8,16 y 18 con un 15% de aumento, 
#ordenados alfabéticamente [Producto, Proveedor, Rubro, Precio con un 15%]
SELECT *
FROM productos p inner join proveedores pr on p.idProveedor=pr.idProveedor
	inner join rubros r on r.idRubro=p.idRubro
WHERE p.idRubro in(2,5,8,16,18);

#10.Lista de los productos cuyo precio supere el promedio de precio de todos los productos. [Producto, Precio]
SELECT Producto, precio,round((SELECT avg(precio) FROM productos),2) AS promedio
FROM productos 
WHERE precio > (SELECT avg(precio) FROM productos);

#11.Cantidad de clientes con la cuenta habilitada. [Cantidad]
SELECT count(c.Cliente) 
FROM clientes c
WHERE c.cuentaHabilitada = 1;

#12.Proveedores que nunca proveyeron Productos, ordenados alfabéticamente [Proveedor]
SELECT Proveedor
FROM  proveedores 
WHERE idProveedor NOT IN (SELECT pr.idProveedor
FROM proveedores pr inner join productos p on p.idProveedor=pr.idProveedor
ORDER BY pr.Proveedor DESC);

#alternativa con exists
SELECT pr.Proveedor
FROM proveedores pr 
WHERE NOT EXISTS(SELECT * FROM productos p WHERE p.idProveedor=pr.idProveedor)
ORDER BY pr.Proveedor;


#13.Cantidad de Productos por Rubro y precio promedio, ordenados alfabéticamente [Rubro, Cantidad de Productos, Precio Promedio]
SELECT r.Rubro,count(*),avg(p.precio)
FROM rubros r INNER JOIN productos p on r.idRubro=p.idRubro
GROUP BY r.idRubro
ORDER BY r.Rubro;


#14.Todas las Facturas emitidas en el 1er Trimestre año 2008, ordenadas alfabéticamente 
#[Nº de Factura, Fecha, Cliente, Vendedor, Total]
SELECT 
    fc.numero,
    fc.fecha,
    c.Cliente,
    v.Vendedor,
    SUM(p.precio * fd.cantidad) AS total
FROM
    facturacabecera fc
        INNER JOIN
    clientes c ON fc.idCliente = c.idCliente
        INNER JOIN
    vendedores v ON v.idVendedor = fc.idVendedor
        INNER JOIN
    facturadetalle fd ON fd.idFactura = fc.idFactura
        INNER JOIN
    productos p ON p.idProducto = fd.idProducto
WHERE
    fc.anulada = 0
        AND MONTH(fc.fecha) <= 4
        AND YEAR(fc.fecha) = 2008
GROUP BY fc.idFactura
ORDER BY fc.numero;

#15.Detalle de la Factura 12, ordenada por Producto
#[Nº de Factura, Fecha, Cliente, Vendedor, Rubro, Proveedor, Producto, Cantidad, Precio, Subtotal]
SELECT fc.numero, fc.fecha, c.Cliente, v.Vendedor, r.Rubro, pr.Proveedor, p.Producto, fd.cantidad, p.precio, p.precio*fd.cantidad AS subtotal
FROM facturacabecera fc INNER JOIN clientes c ON fc.idCliente=c.idCliente
	INNER JOIN vendedores v ON fc.idVendedor=v.idVendedor
    INNER JOIN facturadetalle fd ON fc.idFactura=fd.idFactura
    INNER JOIN productos p ON fd.idProducto=p.idProducto
    INNER JOIN rubros r ON p.idRubro=r.idRubro
    INNER JOIN proveedores pr ON p.idProveedor=pr.idProveedor
WHERE fc.numero = 12
ORDER BY p.Producto DESC;

#16.Importe Total facturado por Cliente hasta el 06/03/2014, 
#ordenado por importe descendente [Cliente, Importe facturado]
SELECT c.Cliente, round(sum(p.precio*fd.cantidad),2) importeFacturado
FROM clientes c INNER JOIN facturacabecera fc ON c.idCliente=fc.idCliente
		INNER JOIN facturadetalle fd ON fc.idFactura=fd.idFactura
        INNER JOIN productos p ON fd.idProducto=p.idProducto
WHERE fc.anulada=0 AND fc.fecha between'2006-01-01' AND '2014-03-06'
GROUP BY c.idCliente
ORDER BY importeFacturado;

#17.Los 3 productos más vendidos ordenados alfabéticamente [Rubro, Proveedor, Producto, Cantidad Vendida, Precio, Total]

SELECT r.Rubro,pr.Proveedor, p.Producto,sum(fd.cantidad) AS cantidadVendida,p.precio,sum(fd.cantidad*p.precio)
FROM productos p INNER JOIN facturadetalle fd ON p.idProducto=fd.idProducto
	INNER JOIN rubros r ON r.idRubro=p.idRubro 
    INNER JOIN proveedores pr ON pr.idProveedor=p.idProveedor
GROUP BY p.idProducto
ORDER BY cantidadVendida DESC LIMIT 3;

#18.Lista de los productos cuyo precio supere el 90% del producto mas caro, 
#ordenado descendente por precio. [Producto, Precio]
SELECT Producto, precio 
FROM productos 
WHERE precio>(SELECT precio FROM productos ORDER BY precio DESC LIMIT 1)*.9
ORDER BY precio DESC;

#19.Nombre del Vendedor que más a vendido [Vendedor, Importe vendido]
SELECT v.Vendedor,sum(fd.cantidad*p.precio) AS importeVendido
FROM vendedores v INNER JOIN facturacabecera fc ON v.idVendedor=fc.idVendedor
				INNER JOIN facturadetalle fd ON fc.idFactura=fd.idFactura 
                INNER JOIN productos p ON fd.idProducto=p.idProducto
GROUP BY v.Vendedor
ORDER BY importeVendido DESC LIMIT 1;

#20.Productos que no ha vendido nunca el Vendedor 5, ordenados alfabéticamente [Rubro, Proveedor, Producto, Precio]

SELECT r.Rubro, pr.Proveedor, p1.Producto, p1.precio
FROM productos p1 INNER JOIN rubros r ON p1.idRubro=r.idRubro
					INNER JOIN proveedores pr ON p1.idProveedor=pr.idProveedor 
WHERE p1.idProducto NOT IN 
(
SELECT p.idProducto
FROM vendedores v INNER JOIN facturacabecera fc ON v.idVendedor=fc.idVendedor
					INNER JOIN facturadetalle fd ON fc.idFactura=fd.idFactura
					INNER JOIN productos p ON fd.idProducto=p.idProducto
WHERE v.idVendedor=5
)
ORDER BY p1.Producto;

#alternativa con exists


#21.Importe a pagar por Vendedor en concepto de comisión por el mes de julio/2005, ordenados por Vendedor [Vendedor, Importe]
SELECT v.Vendedor, (SUM(fd.cantidad * p.precio) * (v.Comision/100)) AS importe
FROM vendedores v INNER JOIN facturacabecera fc ON v.idVendedor=fc.idVendedor 
					INNER JOIN facturadetalle fd ON fc.idFactura=fd.idFactura
                    INNER JOIN productos p ON fd.idProducto=p.idProducto
WHERE year(fc.fecha)=2008 AND month(fc.fecha)=7
GROUP BY v.idVendedor
ORDER BY v.Vendedor;

#22.Zonas en las que nunca se vendió, ordenadas alfabéticamente [Zona]

SELECT Zona 
FROM zonas
WHERE idZona NOT IN (
SELECT z.idZona
FROM zonas z INNER JOIN clientes c ON z.idZona=c.idZona
				INNER JOIN facturacabecera fc ON c.idCliente=fc.idCliente
GROUP BY z.idZona
);

#alternativa con exists

#23.Cliente al que más cantidad de productos se le ha facturado. [Cliente, Zona, Cantidad]
SELECT c.idCliente,z.Zona, sum(fd.cantidad) AS cantidad
FROM clientes c INNER JOIN facturacabecera fc ON c.idCliente=fc.idCliente
				INNER JOIN facturadetalle fd ON fc.idFactura=fd.idFactura
                INNER JOIN zonas z ON c.idZona=z.idZona
GROUP BY c.idCliente
ORDER BY cantidad DESC LIMIT 1;

#24.Proveedor del cual se han vendido más Productos. [Proveedor, Cantidad]
SELECT pr.Proveedor, sum(fd.cantidad) AS cantidad
FROM proveedores pr INNER JOIN productos p ON pr.idProveedor=p.idProveedor
					INNER JOIN facturadetalle fd ON p.idProducto=fd.idProducto
                    INNER JOIN facturacabecera fc ON fd.idFactura=fc.idFactura
WHERE fc.anulada=0
GROUP BY pr.idProveedor 
ORDER BY pr.Proveedor DESC
LIMIT 1;

#25.Promedio de totales por Factura del año 2005. [Promedio] – No es el promedio por time facturado sino por Factura

SELECT avg(T.total)
FROM (
SELECT sum(p.precio*fd.cantidad) AS total
FROM facturacabecera fc INNER JOIN facturadetalle fd ON fc.idFactura=fd.idFactura
						INNER JOIN productos p ON fd.idProducto=p.idProducto
WHERE fc.anulada=0 AND year(fc.fecha)=2008
GROUP BY fc.idFactura) AS T;

#26.Importe facturado por mes del año 2006, ordenado por mes. [Mes/Año, Importe] – Mes/Año en formato Enero/2001 por Ej.
SELECT CONCAT(MONTHNAME(fc.fecha), '/', YEAR(fc.fecha)) AS mes, round(sum(fd.cantidad*p.precio),3) 
FROM facturacabecera fc INNER JOIN facturadetalle fd ON fc.idFactura=fd.idFactura
						INNER JOIN productos p ON fd.idProducto=p.idProducto
WHERE fc.anulada=0 AND year(fc.fecha)=2008
GROUP BY mes
ORDER BY mes;

#27.Importe total por año de facturas anuladas, ordenado por año. [Año, Importe]
SELECT year(fc.fecha) AS anio, round(sum(fd.cantidad*p.precio),2) AS importe
FROM facturacabecera fc INNER JOIN facturadetalle fd ON fc.idFactura=fd.idFactura
						INNER JOIN productos p ON fd.idProducto=p.idProducto
WHERE fc.anulada=1
GROUP BY anio
ORDER BY anio;

#28.Productos que nunca se vendieron en la Zona 4, ordenados por Rubro, Proveedor, Producto. [Rubro, Proveedor, Producto, Precio]


SELECT *
FROM
(SELECT r.Rubro, pr.Proveedor, p.Producto, p.precio
FROM productos p INNER JOIN rubros r ON p.idRubro=r.idRubro
					INNER JOIN proveedores pr ON p.idProveedor=pr.idProveedor
WHERE p.idProducto NOT IN(SELECT DISTINCT p.idProducto
FROM productos p INNER JOIN facturadetalle fd ON p.idProducto=fd.idProducto
					INNER JOIN facturacabecera fc ON fd.idFactura=fc.idFactura
					INNER JOIN clientes c ON fc.idCliente=c.idCliente
                    INNER JOIN zonas z ON c.idZona=z.idZona
WHERE z.idZona=4	
ORDER BY p.Producto
) 
ORDER BY pr.Proveedor) a 
ORDER BY a.rubro;

#alternativa con exists

#29.Inserte un nuevo Producto
INSERT INTO `practico`.`productos` (`Producto`) VALUES ('producto','2','1''100');


#30.Cree una nueva tabla llamada ProductosTemp con todos los Productos de los rubros 2, 
#3, 7 y 9. Para crearla puede utilizar un asistente si lo desea.
#31.A la tabla recientemente creada sume 10000 a los ids de cada producto y aumente los precios un 33%
#32.Inserte los productos de la tabla ProductosTemp en la tabla Productos y luego 
#elimine todos los productos de la Tabla Productos Temp.
#33.Elimine la Tabla ProductosTemp, puede utilizar un asistente si desea.
#34.Modifique los nombres de los clientes con cuenta inhabilitada de tal manera que al final del 
#nombre se agregue el texto ‘- (Cuenta inhabilitada)’ Ej: Cliente 102 – (Cuenta Inhabilitada)
#35.Cambie el nombre del Producto Nº 20 por ‘Producto Modificado’
#36.Reduzca un 20% el precio de los productos que nunca fueron vendidos
#37.Elimine toda la información a cerca de las facturas anuladas
#38.Inserte un nuevo cliente e inserte una factura para este cliente, la factura incluye un detalle de al menos 2 productos.
#39.Inhabilite las cuentas de los clientes a los que nunca se les ha facturado
#40.Elimine las cuentas de los proveedores que nunca proveyeron ningún producto
#41.Cree una nueva tabla llamada Saldos con los datos de todos los Clientes, Zona, Saldo actual y una columna pagado en cero. Para crear la tabla puede utilizar un asistente si lo desea.



