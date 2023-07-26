<?php
// Получаем значение параметра city из запроса
$city = isset($_GET["city"]) ? $_GET["city"] : "";

// В зависимости от значения параметра city, выводим местное время
if ($city === "nsk") {
    include "nsk.php";
} elseif ($city === "l-a") {
    include "l-a.php";
} else {
   include "nsk.php";
}
?>
