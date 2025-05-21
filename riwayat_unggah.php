<?php
session_start();
include 'connection_db.php';

if (!isset($_SESSION['user_id'])) {
    $_SESSION['error_message'] = "Anda harus login terlebih dahulu.";
    header("Location: login.php");
    exit();
}

if (!isset($_GET['id_pelamar']) || !isset($_GET['action']) || !isset($_GET['id_lowongan'])) {
    $_SESSION['error_message'] = "Parameter tidak lengkap.";
    header("Location: index_poster.php");
    exit();
}

$id_lamaran = $_GET['id_pelamar']; // ini id_lamaran dari daftar_lowongan
$action = $_GET['action'];
$id_lowongan = $_GET['id_lowongan'];

if ($action !== 'accept' && $action !== 'reject') {
    $_SESSION['error_message'] = "Tindakan tidak valid.";
    header("Location: view_applicants.php?id_lowongan=$id_lowongan");
    exit();
}

// Pastikan lowongan milik user
$sql_check = "SELECT * FROM lowongan 
              WHERE id_lowongan = ? AND user_id = ? AND status_lowongan = 'aktif'";
$stmt_check = $conn->prepare($sql_check);
$stmt_check->bind_param("ii", $id_lowongan, $_SESSION['user_id']);
$stmt_check->execute();
$result_check = $stmt_check->get_result();

if ($result_check->num_rows === 0) {
    $_SESSION['error_message'] = "Lowongan tidak ditemukan atau bukan milik Anda.";
    header("Location: index_poster.php");
    exit();
}

// Set status lamaran
$new_status = ($action === 'accept') ? 'diterima' : 'ditolak';

$sql_update = "UPDATE daftar_lowongan 
               SET status_lamaran = ? 
               WHERE id_lamaran = ? AND id_lowongan = ?";
$stmt_update = $conn->prepare($sql_update);
$stmt_update->bind_param("sii", $new_status, $id_lamaran, $id_lowongan);

if ($stmt_update->execute()) {
    $_SESSION['success_message'] = "Status pelamar berhasil diperbarui.";
} else {
    $_SESSION['error_message'] = "Gagal memperbarui status: " . $conn->error;
}

header("Location: view_applicants.php?id_lowongan=$id_lowongan");
exit();
?>
