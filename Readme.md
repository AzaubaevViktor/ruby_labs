### 1. 👌
**Язык**: Ruby  
**Условие**  
Задан набор символов и число n. 
Опишите функцию, которая возвращает список всех строк длины n, 
состоящих из этих символов и не содержащих двух одинаковых символов, 
идущих подряд.  
**Ограничения**  
решение должны быть выражено через map/reduce/select/reject 
и элементарные операции над строками и списками/массивами  
**Пример**  
Для символов 'а', 'b', 'c' и n=2 результат должен быть 
("ab" "ac" "ba" "bc" "ca" "cb") с точностью до перестановки.  

### 2.
**Язык**: Ruby  
**Условие**
Реализуйте класс, аналогичный Array, с многопоточной реализацией итераторов: 
map, any?, all?, select. 
Объясните, можно ли таким образом реализовать итератор inject?  
**Ограничения**
- решение должны быть выражено через базовые итераторы и операции над коллекциями и потоками (threads)
- вся логика работы с потоками должны быть вынесена в отдельный метод, общий для всех итераторов.

### 3.
**Язык**: Ruby  
**Условие**  
Варианты:
1. Написать программу, разбирающую журнал событий (например, журнал web-сервера, syslog и т.д.) и вычисляющий ежемесячную статистику в зависимости от содержимого выбранного журнала (например, обращения с различных IP-адресов, ошибки различных типов, аутентификацию пользователей и т.д.)
2. По детализации звонков (предварительно преобразованным в текстовый формат) своего сотового оператора за несколько месяцев сделать расчет финансовых затрат по нескольким различным тарифам. Допускается использовать не все параметры тарифа, только наиболее важные (например, абонентская плата, стоимость звонков, дифференцированная по различным видам номеров).
3. Предложите свою постановку задачи и обсудите ее с преподавателем. При решении должны быть использованы регулярные выражения с 3-4 нетривиальными группами.

**Ограничения**  
Необходимо использовать расширенные рег. выражения с комментариями

### 4.
**Язык**: Clojure  
**Условие**  
Реализовать решение 1 на языке Clojure.  
Демонстрацию работоспособности обеспечить с помощью модульных тестов. 
Данное требование относится ко всем последующим задачам.

### 5.
**Язык**: Clojure  
**Условие**  
Реализовать функцию (оператор), 
принимающую аргументом функцию от одной переменной f 
и возвращающую функцию одной переменной, вычисляющую (численно) выражение:

![](http://ccfit.nsu.ru/~shadow/DT6/pic/clojure2_int.png)  
Оптимизировать с использованием мемоизации для задач типа построения графиков (т.е. многократный вызов функции в разных точках)

Использовать метод трапеций с постоянным шагом.

Показать прирост производительности с помощью time.

Обеспечить покрытие тестами.

### 6-1.
**Язык**: Clojure  
**Условие**  
Модифицировать решение задачи Clojure2 таким образом, 
чтобы вместо мемоизации использовались потоки 
(streams, технически - бесконечные списки).
Показать прирост производительности с помощью time.

Обеспечить покрытие тестами.

### 6-2.
**Язык**: Clojure  
**Условие**  
Реализовать параллельный вариант filter с помощью future. 
Каждый объект future должен обрабатывать заданное константой количество элементов
(>1), уровень параллелизма также задается константой. 
Должна поддерживаться обработка как конечных, так и бесконечных последовательностей.

Показать прирост производительности за счет многопоточности с помощью time.

Обеспечить покрытие функциональными тестами.

### 7.
**Язык**: Clojure  
**Условие**  
По аналогии с задачей дифференцирования реализовать представление символьных
булевых выражений с операциями конъюнкции, дизъюнкции отрицания, импликации. 
Выражения могут включать как булевы константы, так и переменные. 
Реализовать подстановку значения переменной в выражение с его приведением к ДНФ.

Код должен быть покрыт тестами, API документирован.