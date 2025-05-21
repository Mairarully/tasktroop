<?php
session_start();
include 'connection_db.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

if (!isset($_GET['id_lowongan'])) {
    header("Location: index_poster.php");
    exit();
}

$id_lowongan = $_GET['id_lowongan'];

// Validasi lowongan milik user
$sql_check = "SELECT * FROM lowongan WHERE id_lowongan = ? AND user_id = ?";
$stmt_check = $conn->prepare($sql_check);
$stmt_check->bind_param("ii", $id_lowongan, $_SESSION['user_id']);
$stmt_check->execute();
$result_check = $stmt_check->get_result();

if ($result_check->num_rows === 0) {
    header("Location: index_poster.php");
    exit();
}

// Ambil data pelamar
$sql = "SELECT dl.id_lamaran, u.full_name, u.email, dl.deskripsi_diri, dl.penawaran_harga, dl.status_lamaran, dl.portofolio
        FROM daftar_lowongan dl
        JOIN users u ON dl.user_id = u.user_id
        WHERE dl.id_lowongan = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id_lowongan);
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Daftar Pelamar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1e56a0;
            --accent-color: #4DA6FF;
            --light-bg: #f8fbfd;
            --border-radius: 12px;
            --box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .hero-section {
            background-color: var(--primary-color);
            padding: 60px 0;
            color: white;
            text-align: center;
        }

        .card {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 30px;
        }

        .badge {
            padding: 6px 12px;
            font-size: 0.8rem;
            font-weight: 500;
            border-radius: 20px;
        }

        .status-pending { background-color: #FFF3CD; color: #856404; }
        .status-accepted { background-color: #D4EDDA; color: #155724; }
        .status-rejected { background-color: #F8D7DA; color: #721C24; }

        .portofolio-link {
            color: var(--accent-color);
            font-weight: 500;
        }

        .portofolio-link:hover {
            color: var(--primary-color);
            text-decoration: underline;
        }

        .btn-sm { margin: 2px; }

        .submission-date {
            font-size: 0.85rem;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="hero-section">
        <div class="container">
            <h1 class="display-5 fw-bold">Daftar Pelamar</h1>
            <p class="lead">Lihat semua pelamar untuk lowongan ini</p>
        </div>
    </div>

    <div class="container py-4">
        <?php if ($result->num_rows > 0): ?>
            <div class="row">
                <?php while ($row = $result->fetch_assoc()): ?>
                    <?php
                        $status = $row['status_lamaran'] ?? 'menunggu';
                        $badgeClass = 'status-pending';
                        $statusText = 'Menunggu';

                        if ($status === 'diterima') {
                            $badgeClass = 'status-accepted';
                            $statusText = 'Diterima';
                        } elseif ($status === 'ditolak') {
                            $badgeClass = 'status-rejected';
                            $statusText = 'Ditolak';
                        }

                        $portofolio_path = 'asset/portofolio/' . $row['portofolio'];
                    ?>
                    <div class="col-md-6">
                        <div class="card p-3">
                            <div class="card-body">
                                <span class="badge <?= $badgeClass ?>"><?= $statusText ?></span>
                                <h5 class="card-title mt-2"><?= htmlspecialchars($row['full_name']) ?></h5>
                                <h6 class="text-muted mb-2"><i class="fa-solid fa-envelope me-1"></i> <?= htmlspecialchars($row['email']) ?></h6>

                                <p class="mb-2"><strong>Deskripsi Diri:</strong><br><?= nl2br(htmlspecialchars($row['deskripsi_diri'])) ?></p>
                                <p><strong>Penawaran Harga:</strong> Rp <?= number_format($row['penawaran_harga'], 0, ',', '.') ?></p>

                                <?php if (!empty($row['portofolio']) && file_exists($portofolio_path)): ?>
                                    <p>
                                        <strong>Portofolio:</strong><br>
                                        <a href="<?= $portofolio_path ?>" class="portofolio-link" target="_blank">Lihat</a> |
                                        <a href="<?= $portofolio_path ?>" download class="portofolio-link">Unduh</a>
                                    </p>
                                <?php else: ?>
                                    <p><strong>Portofolio:</strong> <em class="text-muted">Tidak tersedia</em></p>
                                <?php endif; ?>

                                <div class="d-flex gap-2 mt-3">
                                    <?php if ($status === 'menunggu'): ?>
                                        <a href="riwayat_unggah.php?action=accept&id_pelamar=<?= $row['id_lamaran'] ?>&id_lowongan=<?= $id_lowongan ?>" class="btn btn-success btn-sm">Terima</a>
                                        <a href="riwayat_unggah.php?action=reject&id_pelamar=<?= $row['id_lamaran'] ?>&id_lowongan=<?= $id_lowongan ?>" class="btn btn-danger btn-sm">Tolak</a>
                                    <?php else: ?>
                                        <span class="text-muted"><em>Aksi tidak tersedia</em></span>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php endwhile; ?>
            </div>
        <?php else: ?>
            <div class="alert alert-warning">Belum ada pelamar untuk lowongan ini.</div>
        <?php endif; ?>

        <a href="index_poster.php" class="btn btn-outline-primary mt-4"><i class="fa-solid fa-arrow-left me-1"></i> Kembali ke Dashboard</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
