

<?php
$api_key = 'd47c9fb4b669d53f6a92822be8538a1a';

$url = $_GET['city'] ?? 'nsk';

if ($url === 'l-a') {
    include 'l-a.php';
} else {
    include 'nsk.php';
}
?>
