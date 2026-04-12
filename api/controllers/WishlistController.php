<?php
require_once __DIR__ . '/../config/database.php';

class WishlistController {
    private $conn;
    public function __construct() { $this->conn = getConnection(); }

    public function getUserWishlist($userId) {
        // Query yang lebih selamat dan laju
        $stmt = $this->conn->prepare("SELECT hotel_id FROM wishlists WHERE user_id = ?");
        $stmt->bind_param("i", $userId);
        $stmt->execute();
        $result = $stmt->get_result();
        
        $data = [];
        while($row = $result->fetch_assoc()) { 
            // PAKSA format data menjadi Nombor Integer
            $data[] = (int)$row['hotel_id']; 
        }
        echo json_encode(["success" => true, "data" => $data]);
    }

    public function toggle() {
        $data = json_decode(file_get_contents("php://input"), true);
        $user_id = $data['user_id'];
        $hotel_id = $data['hotel_id'];

        $check = $this->conn->prepare("SELECT id FROM wishlists WHERE user_id = ? AND hotel_id = ?");
        $check->bind_param("ii", $user_id, $hotel_id);
        $check->execute();
        
        if ($check->get_result()->num_rows > 0) {
            $del = $this->conn->prepare("DELETE FROM wishlists WHERE user_id = ? AND hotel_id = ?");
            $del->bind_param("ii", $user_id, $hotel_id);
            $del->execute();
            echo json_encode(["success" => true, "action" => "removed"]);
        } else {
            $add = $this->conn->prepare("INSERT INTO wishlists (user_id, hotel_id) VALUES (?, ?)");
            $add->bind_param("ii", $user_id, $hotel_id);
            $add->execute();
            echo json_encode(["success" => true, "action" => "added"]);
        }
    }
}