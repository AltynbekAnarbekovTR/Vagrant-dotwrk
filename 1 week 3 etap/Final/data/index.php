

<?php
$api_key = 'INSERT_YOUR_API_KEY';
$url = $_GET['city'] ?? 'nsk';

if ($url === 'l-a') {
    include 'l-a.php';
} else {
    include 'nsk.php';
}
?>
