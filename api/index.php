<?php
// ============================================================
//  index.php — Main Router
//  Person 1 responsibility
// ============================================================

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-API-KEY");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'config/database.php';
require_once 'controllers/HotelController.php';
require_once 'controllers/BookingController.php';
require_once 'controllers/UserController.php';
require_once 'controllers/PaymentController.php';
require_once 'controllers/AnalyticsController.php';

// ── Check API Key ─────────────────────────────────────────
$apiKeyHeader = $_SERVER['HTTP_X_API_KEY'] ?? '';
$validApiKey  = 'hotel-secret-key-2026';

if ($apiKeyHeader !== $validApiKey) {
    http_response_code(401);
    echo json_encode([
        "success" => false,
        "message" => "Unauthorized: Invalid or missing API Key"
    ]);
    exit();
}

// ── Parse the URL ─────────────────────────────────────────
$requestUri    = $_SERVER['REQUEST_URI'];
$basePath      = '/hotel-api/api';           // adjust if your folder name differs
$path          = str_replace($basePath, '', parse_url($requestUri, PHP_URL_PATH));
$path          = trim($path, '/');
$segments      = explode('/', $path);

$resource      = $segments[0] ?? '';         // e.g. "hotels"
$id            = $segments[1] ?? null;       // e.g. "5"
$method        = $_SERVER['REQUEST_METHOD']; // GET / POST / PUT / DELETE

// ── Route to correct controller ───────────────────────────
switch ($resource) {

    case 'hotels':
        $ctrl = new HotelController();
        if ($method === 'GET'    && !$id)  $ctrl->getAll();
        elseif ($method === 'GET')         $ctrl->getOne($id);
        elseif ($method === 'POST')        $ctrl->create();
        elseif ($method === 'PUT')         $ctrl->update($id);
        elseif ($method === 'DELETE')      $ctrl->delete($id);
        else notFound();
        break;

    case 'bookings':
        $ctrl = new BookingController();
        if ($method === 'GET'    && !$id)  $ctrl->getAll();
        elseif ($method === 'POST' && $id === 'cancel') $ctrl->cancel($segments[2] ?? 0); // bookings/cancel/{id}
        elseif ($method === 'GET')         $ctrl->getOne($id);
        elseif ($method === 'POST')        $ctrl->create();
        elseif ($method === 'PUT')         $ctrl->update($id);
        elseif ($method === 'DELETE')      $ctrl->delete($id);
        else notFound();
        break;

    case 'users':
        $ctrl = new UserController();
        if ($method === 'GET'    && !$id)  $ctrl->getAll();
        elseif ($method === 'POST' && $id === 'login') $ctrl->login();
        elseif ($method === 'GET')         $ctrl->getOne($id);
        elseif ($method === 'POST')        $ctrl->create();
        elseif ($method === 'PUT')         $ctrl->update($id);
        elseif ($method === 'DELETE')      $ctrl->delete($id);
        else notFound();
        break;

    case 'payments':
        $ctrl = new PaymentController();
        if ($method === 'GET'    && !$id)  $ctrl->getAll();
        elseif ($method === 'GET')         $ctrl->getOne($id);
        elseif ($method === 'POST')        $ctrl->create();
        elseif ($method === 'PUT')         $ctrl->update($id);
        elseif ($method === 'DELETE')      $ctrl->delete($id);
        else notFound();
        break;

    case 'analytics':
        $ctrl = new AnalyticsController();
        if ($method === 'GET' && $id === 'overview') $ctrl->getOverview();
        elseif ($method === 'GET' && $id === 'availability') $ctrl->getAvailability();
        elseif ($method === 'GET' && $id === 'activity') $ctrl->getUserActivity();
        else notFound();
        break;

    case 'upload':
        if ($method === 'POST') {
            if (!isset($_FILES['image'])) {
                http_response_code(400);
                echo json_encode(["success" => false, "message" => "No image uploaded"]);
                break;
            }
            $file = $_FILES['image'];
            $ext = pathinfo($file['name'], PATHINFO_EXTENSION);
            $newName = time() . '_' . uniqid() . '.' . $ext;
            $target = 'uploads/' . $newName;
            
            if (move_uploaded_file($file['tmp_tmp_name'] ?? $file['tmp_name'], $target)) {
                echo json_encode(["success" => true, "url" => "/hotel-api/api/" . $target]);
            } else {
                http_response_code(500);
                echo json_encode(["success" => false, "message" => "Upload failed"]);
            }
        } else notFound();
        break;

    default:
        notFound();
        break;
}

// ── 404 helper ────────────────────────────────────────────
function notFound() {
    http_response_code(404);
    echo json_encode([
        "success" => false,
        "message" => "Endpoint not found"
    ]);
}