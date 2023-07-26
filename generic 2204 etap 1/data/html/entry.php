<?php
// Получаем значение параметра city из запроса
$city = isset($_GET['city']) ? $_GET['city'] : '';

// В зависимости от значения параметра city, выводим местное время
if ($city === 'nsk') {
    // date_default_timezone_set('Asia/Novosibirsk');
    // echo 'Местное время в Новосибирске: ' . date('Y-m-d H:i:s');
    include "nsk.php";
} elseif ($city === 'l-a') {
    // date_default_timezone_set('America/Los_Angeles');
    // echo 'Местное время в Лос-Анджелесе: ' . date('Y-m-d H:i:s');
    include "l-a.php";
} else {
    // Если параметр city не задан или имеет некорректное значение,
    // выводим местное время в Новосибирске по умолчанию
    date_default_timezone_set('Asia/Novosibirsk');
    echo 'Местное время в Новосибирске: ' . date('Y-m-d H:i:s');
}
?>
