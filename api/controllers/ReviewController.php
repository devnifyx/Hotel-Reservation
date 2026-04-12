<?php
require_once __DIR__ . '/../config/database.php';

class ReviewController {
    private $conn;
    public function __construct() { $this->conn = getConnection(); }

    public function getHotelReviews($hotelId) {
        $stmt = $this->conn->prepare("SELECT r.*, u.name as user_name FROM reviews r JOIN users u ON r.user_id = u.id WHERE r.hotel_id = ? ORDER BY r.created_at DESC");
        $stmt->bind_param("i", $hotelId);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = []; 
        while($row = $result->fetch_assoc()) { $data[] = $row; }
        echo json_encode(["success" => true, "data" => $data]);
    }

    public function addReview() {
        $data = json_decode(file_get_contents("php://input"), true);
        $stmt = $this->conn->prepare("INSERT INTO reviews (user_id, hotel_id, rating, comment) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("iiis", $data['user_id'], $data['hotel_id'], $data['rating'], $data['comment']);
        
        if ($stmt->execute()) {
            echo json_encode(["success" => true]);
        } else {
            echo json_encode(["success" => false, "message" => "Gagal simpan ulasan"]);
        }
    }
}