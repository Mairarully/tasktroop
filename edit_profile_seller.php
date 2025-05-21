<?php
include('connection_db.php');
session_start();

if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit;
}

// Ambil data user
$sql = "SELECT * FROM users WHERE username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $_SESSION['username']);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $full_name = $_POST['full_name'];
    $email = $_POST['email'];
    $phone_number = $_POST['phone_number'];
    $bio = $_POST['bio'];

    // File upload optional
    $profile_picture = $user['profile_picture'];
    if (!empty($_FILES['profile_picture']['name'])) {
        $profile_picture = $_FILES['profile_picture']['name'];
        $target_path = 'uploads/' . $profile_picture;
        move_uploaded_file($_FILES['profile_picture']['tmp_name'], $target_path);
    }

    $update_sql = "UPDATE users SET full_name=?, email=?, phone_number=?, bio=?, profile_picture=?, updated_at=NOW() WHERE username=?";
    $update_stmt = $conn->prepare($update_sql);
    $update_stmt->bind_param("ssssss", $full_name, $email, $phone_number, $bio, $profile_picture, $_SESSION['username']);

    if ($update_stmt->execute()) {
        header("Location: profil_seller.php");
        exit;
    } else {
        echo "Gagal memperbarui profil: " . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Edit Profil Seller</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #f8f9fa;">

<!-- HEADER -->
<nav class="navbar navbar-light bg-white px-4 shadow-sm">
    <a class="navbar-brand" href="index_seller.php">
        <img src="asset/img/logo1.png" alt="Logo" height="60">
    </a>
    <div>
        <a href="profil_seller.php" class="btn btn-outline-primary me-2">Profil</a>
        <a href="logout.php" class="btn btn-outline-danger">Keluar</a>
    </div>
</nav>

<!-- FORM EDIT PROFIL -->
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="text-center text-primary mb-4">Edit Profil Anda</h3>
                    <form method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label">Nama Lengkap</label>
                            <input type="text" name="full_name" class="form-control" value="<?php echo htmlspecialchars($user['full_name']); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-control" value="<?php echo htmlspecialchars($user['email']); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">No. Telepon</label>
                            <input type="text" name="phone_number" class="form-control" value="<?php echo htmlspecialchars($user['phone_number']); ?>" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Bio</label>
                            <textarea name="bio" class="form-control" rows="3"><?php echo htmlspecialchars($user['bio']); ?></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Foto Profil (Opsional)</label>
                            <input type="file" name="profile_picture" class="form-control">
                            <?php if ($user['profile_picture']): ?>
                                <div class="mt-2">
                                    <img src="uploads/<?php echo $user['profile_picture']; ?>" alt="Foto Profil" width="80" class="rounded">
                                </div>
                            <?php endif; ?>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Simpan Perubahan</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="bg-dark text-white text-center py-3 mt-5">
    <p class="mb-0">&copy; 2025 TaskTroop. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
