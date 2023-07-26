<?php 
function get_time_and_weather($city) {
    switch($city) {
        case 'Los Angeles':
        date_default_timezone_set('America/Los_Angeles');
        $city = 'Los Angeles';
        break;

        case 'Novosibirsk':
        date_default_timezone_set('Asia/Novosibirsk');
        $city = 'Novosibirsk';
        break;

        default:
        date_default_timezone_set('Asia/Novosibirsk');
        $city = 'Novosibirsk';
        break;
    }
    
    $current_time = date('Y-m-d H:i:s');
    $api_key = 'd47c9fb4b669d53f6a92822be8538a1a';
    $weather_url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api_key&units=metric";
    $weather_data = json_decode(file_get_contents($weather_url), true);
    
    echo 'City: ' . $city . '<br>';
    echo 'Current time: ' . $current_time . '<br>';
    
    if ($weather_data) {
        echo "Weather: " . $weather_data['weather'][0]['description'] . "<br>";
        echo "Temperature: " . $weather_data['main']['temp'] . "°C<br>";
    } else {
        echo "Failed to fetch weather data.";
    }
}

