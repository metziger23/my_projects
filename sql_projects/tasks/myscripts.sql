--Задание: 1
--Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd

SELECT
  model,
  speed,
  hd
FROM PC
WHERE price < 500;

--Задание: 2
--Найдите производителей принтеров. Вывести: maker

SELECT DISTINCT
  maker
FROM Product
WHERE type = 'Printer';

--Задание: 3
--Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

SELECT
  model,
  ram,
  screen
FROM Laptop
WHERE price > 1000;

--Задание: 4
--Найдите все записи таблицы Printer для цветных принтеров.

SELECT
  *
FROM Printer
WHERE color = 'y';

--Задание: 5
--Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.

SELECT
  model,
  speed,
  hd
FROM PC
WHERE price < 600
AND cd IN ('12x', '24x');

--Задание: 6
--Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

SELECT DISTINCT
  maker,
  Laptop.speed
FROM Product
INNER JOIN Laptop
  ON Laptop.model = Product.model
WHERE Laptop.hd >= 10;

--Задание: 7
--Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

SELECT
  PC.model,
  price
FROM PC
INNER JOIN Product
  ON PC.model = Product.model
WHERE Product.maker = 'B'
UNION
SELECT
  Laptop.model,
  price
FROM Laptop
INNER JOIN Product
  ON Laptop.model = Product.model
WHERE Product.maker = 'B'
UNION
SELECT
  Printer.model,
  price
FROM Printer
INNER JOIN Product
  ON Printer.model = Product.model
WHERE Product.maker = 'B';

--Задание: 8
--Найдите производителя, выпускающего ПК, но не ПК-блокноты.

SELECT
  maker
FROM Product
WHERE type IN ('PC')
EXCEPT
SELECT
  maker
FROM Product
WHERE type IN ('Laptop');

--Задание: 9
--Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

SELECT DISTINCT
  maker
FROM Product
INNER JOIN PC
  ON Product.model = PC.model
WHERE PC.speed >= 450;

--Задание: 10
--Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

SELECT
  model,
  price
FROM Printer
WHERE price IN (SELECT
  MAX(price)
FROM Printer);

--Задание: 11
--Найдите среднюю скорость ПК.

SELECT
  AVG(speed)
FROM PC;

--Задание: 12
--Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

SELECT
  AVG(speed)
FROM Laptop
WHERE speed IN (SELECT
  speed
FROM Laptop
WHERE price > 1000);

--Задание: 13
--Найдите среднюю скорость ПК, выпущенных производителем A.

SELECT
  AVG(speed)
FROM PC
INNER JOIN Product
  ON PC.model = Product.model
WHERE Product.maker = 'A';

--Задание: 14
--Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

SELECT
  Classes.class,
  Ships.name,
  country
FROM Classes
INNER JOIN Ships
  ON Ships.class = Classes.class
WHERE numGuns >= 10;

--Задание: 15
--Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

SELECT
  hd
FROM PC
GROUP BY hd
HAVING COUNT(hd) >= 2;

--Задание: 16
--Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

SELECT DISTINCT
  pca.model,
  pcb.model,
  pca.speed,
  pca.ram
FROM pc AS pca
INNER JOIN pc AS pcb
  ON (pca.speed = pcb.speed
  AND pca.ram = pcb.ram
  AND pca.model > pcb.model);

--Задание: 17
--Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
--Вывести: type, model, speed

SELECT DISTINCT
  Product.type,
  Product.model,
  Laptop.speed
FROM Product
INNER JOIN Laptop
  ON Product.model = Laptop.model
WHERE Laptop.speed < ALL (SELECT
  speed
FROM PC);

--Задание: 18
--Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

SELECT DISTINCT
  Product.maker,
  Printer.price
FROM Product
INNER JOIN Printer
  ON Product.model = Printer.model
WHERE Printer.color = 'y'
AND Printer.price IN (SELECT
  MIN(price)
FROM Printer
WHERE color = 'y');

--Задание: 19
--Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
--Вывести: maker, средний размер экрана.

SELECT
  Product.maker,
  AVG(Laptop.screen)
FROM Product
INNER JOIN Laptop
  ON Product.model = Laptop.model
GROUP BY Product.maker;

--Задание: 20
--Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.

SELECT
  maker,
  COUNT(DISTINCT model)
FROM product
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(DISTINCT model) > 2;

--Задание: 21
--Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
--Вывести: maker, максимальная цена.

SELECT
  Product.maker,
  MAX(PC.price)
FROM Product
INNER JOIN PC
  ON PC.model = Product.model
GROUP BY Product.maker;

--Задание: 22
--Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.

SELECT
  speed,
  AVG(price)
FROM PC
WHERE speed > 600
GROUP BY speed;

--Задание: 23
--Найдите производителей, которые производили бы как ПК
--со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
--Вывести: Maker

SELECT
  maker
FROM Product
JOIN PC
  ON Product.model = PC.model
WHERE PC.speed >= 750
INTERSECT
SELECT
  maker
FROM Product
JOIN Laptop
  ON Product.model = Laptop.model
WHERE Laptop.speed >= 750;

--Задание: 24
--Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.

WITH MAX_PRICE
AS (SELECT
  MAX(SQ.price) AS 'price'
FROM (SELECT
  price
FROM pc
UNION
SELECT
  price
FROM laptop
UNION
SELECT
  price
FROM printer) AS SQ)

SELECT
  SQ1.model
FROM (SELECT
  model,
  price
FROM pc
UNION
SELECT
  model,
  price
FROM laptop
UNION
SELECT
  model,
  price
FROM printer) SQ1
INNER JOIN MAX_PRICE SQ2
  ON SQ1.price = SQ2.price;

--Задание: 25
--Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

SELECT DISTINCT
  maker
FROM Product
INNER JOIN PC
  ON PC.model = Product.model
WHERE ram IN (SELECT
  MIN(ram)
FROM PC)
AND speed IN (SELECT
  MAX(speed)
FROM PC
WHERE ram IN (SELECT
  MIN(ram)
FROM PC))
AND maker IN (SELECT
  maker
FROM Product
WHERE type = 'Printer');

--Задание: 26
--Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.

SELECT
  AVG(price)
FROM (SELECT
  price,
  model
FROM pc
UNION ALL
SELECT
  price,
  model
FROM laptop) p
WHERE p.model IN (SELECT
  model
FROM product
WHERE maker = 'A');

--Задание: 27
--Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.

SELECT
  maker,
  AVG(hd) AS avg_hd
FROM Product
INNER JOIN PC
  ON Product.model = PC.model
WHERE maker IN (SELECT
  maker
FROM Product
WHERE type = 'Printer')
GROUP BY maker;

--Задание: 28
--Используя таблицу Product, определить количество производителей, выпускающих по одной модели.

SELECT
  COUNT(*)
FROM (SELECT
  maker
FROM Product
GROUP BY maker
HAVING COUNT(model) = 1) AS A;

--Задание: 29
--В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными данными (пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o.

SELECT
  i.point,
  i.date,
  i.inc,
  o.out
FROM income_o i
LEFT JOIN outcome_o o
  ON i.point = o.point
  AND i.date = o.date
UNION
SELECT
  o.point,
  o.date,
  i.inc,
  o.out
FROM outcome_o o
LEFT JOIN income_o i
  ON o.point = i.point
  AND o.date = i.date;

--Задание: 30
--В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число раз (первичным ключом в таблицах является столбец code), требуется получить таблицу, в которой каждому пункту за каждую дату выполнения операций будет соответствовать одна строка.
--Вывод: point, date, суммарный расход пункта за день (out), суммарный приход пункта за день (inc). Отсутствующие значения считать неопределенными (NULL).

WITH cte_out
AS (SELECT
  point,
  date,
  SUM(out) AS out
FROM outcome
GROUP BY point,
         date),
cte_inc
AS (SELECT
  point,
  date,
  SUM(inc) AS inc
FROM income
GROUP BY point,
         date)

SELECT
  i.point,
  i.date,
  o.out,
  i.inc
FROM cte_inc i
LEFT JOIN cte_out o
  ON i.point = o.point
  AND i.date = o.date
UNION
SELECT
  o.point,
  o.date,
  o.out,
  i.inc
FROM cte_out o
LEFT JOIN cte_inc i
  ON o.point = i.point
  AND o.date = i.date;

--Задание: 31
--Для классов кораблей, калибр орудий которых не менее 16 дюймов, укажите класс и страну.

SELECT
  class,
  country
FROM Classes
WHERE bore >= 16;