<?php
// ============================================================
//  database.php — DB connection
// ============================================================

define('DB_HOST', 'localhost');
define('DB_NAME', 'hotel_reservation'); 
define('DB_USER', 'root');
define('DB_PASS', '');          // Biarkan kosong jika XAMPP default

function getConnection() {
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

    if ($conn->connect_error) {
        http_response_code(500);
        echo json_encode([
            "success" => false,
            "message" => "Database connection failed: " . $conn->connect_error
        ]);
        exit();
    }

    $conn->set_charset("utf8");
    return $conn;
}
?>