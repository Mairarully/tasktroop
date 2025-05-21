<?php
session_start();
include('connection_db.php');

// Pastikan user sudah login
if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit;
}

// Ambil data seller
$sql = "SELECT * FROM users WHERE is_seller = 1 AND username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $_SESSION['username']);
$stmt->execute();
$result = $stmt->get_result();
$seller = $result->fetch_assoc();
$stmt->close();

// Jika tidak ditemukan
if (!$seller) {
    echo "Akun seller tidak ditemukan.";
    exit;
}

// Data
$full_name = $seller['full_name'];
$username = $seller['username'];
$email = $seller['email'];
$phone_number = $seller['phone_number'];
$profile_picture = $seller['profile_picture'];
$bio = $seller['bio'];
?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Profil Seller</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    .card {
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      border-radius: 10px;
    }
    .card-header {
      background-color: #0d6efd;
      color: white;
      font-weight: bold;
      border-radius: 10px 10px 0 0 !important;
    }
  </style>
</head>
<body>
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-md-8">

        <!-- Kartu Profil -->
        <div class="card">
          <div class="card-header">
            <h3 class="mb-0"><i class="fas fa-user-circle me-2"></i>Profil Seller</h3>
          </div>
          <div class="card-body">
            <div class="text-center mb-4">
              <img src="<?= htmlspecialchars($profile_picture ?: 'assets/img/default-avatar.png') ?>" 
                   alt="Foto Profil" class="rounded-circle img-thumbnail" style="width: 150px; height: 150px; object-fit: cover;">
            </div>

            <div class="mb-3"><strong><i class="fas fa-user me-2"></i>Nama:</strong> <?= htmlspecialchars($full_name) ?></div>
            <div class="mb-3"><strong><i class="fas fa-user-tag me-2"></i>Username:</strong> <?= htmlspecialchars($username) ?></div>
            <div class="mb-3"><strong><i class="fas fa-envelope me-2"></i>Email:</strong> <?= htmlspecialchars($email) ?></div>
            <div class="mb-3"><strong><i class="fas fa-phone me-2"></i>Telepon:</strong> <?= htmlspecialchars($phone_number) ?></div>

            <hr>

            <h5><i class="fas fa-info-circle me-2"></i>Deskripsi Diri</h5>
            <p><?= nl2br(htmlspecialchars($bio)) ?></p>

            <div class="text-center mt-4">
              <a href="edit_profile_seller.php" class="btn btn-primary">
                <i class="fas fa-edit me-2"></i>Edit Profil
              </a>
            </div>
          </div>
        </div>

        <div class="text-center mt-4">
          <a href="index_seller.php" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-2"></i>Kembali ke Dashboard
          </a>
        </div>

      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
