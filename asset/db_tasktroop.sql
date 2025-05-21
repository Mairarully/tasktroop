-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 21 Bulan Mei 2025 pada 06.01
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_tasktroop`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `parent_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `daftar_lowongan`
--

CREATE TABLE `daftar_lowongan` (
  `id_lamaran` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `id_lowongan` bigint(20) UNSIGNED NOT NULL,
  `deskripsi_diri` text DEFAULT NULL,
  `portofolio` varchar(255) NOT NULL,
  `penawaran_harga` decimal(12,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status_lamaran` enum('menunggu','diterima','ditolak') DEFAULT 'menunggu'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `daftar_lowongan`
--

INSERT INTO `daftar_lowongan` (`id_lamaran`, `user_id`, `id_lowongan`, `deskripsi_diri`, `portofolio`, `penawaran_harga`, `created_at`, `updated_at`, `status_lamaran`) VALUES
(2, 7, 2, 'yeyeye', 'portfolio_7_1747674044.docx', 1000.00, '2025-05-19 12:00:44', '2025-05-19 17:00:44', 'menunggu'),
(3, 7, 4, 'saya ahli dalam bidang ini', 'portfolio_7_1747674259.docx', 6000.00, '2025-05-19 12:04:19', '2025-05-19 17:04:19', 'menunggu'),
(4, 7, 1, 'saya ahli dalam bidang ini', 'portfolio_7_1747674312.docx', 8000.00, '2025-05-19 12:05:12', '2025-05-19 17:05:12', 'menunggu'),
(5, 7, 5, 'SAYA AHLI DALAM MENGAMBIL DAN MENGEDIT VIDEO HAHAHAH', 'portfolio_7_1747744400.docx', 7000000.00, '2025-05-20 07:33:20', '2025-05-21 02:49:55', 'diterima');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lowongan`
--

CREATE TABLE `lowongan` (
  `id_lowongan` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `jenis_lowongan` varchar(100) DEFAULT NULL,
  `nama_lowongan` varchar(255) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `tanggal_unggah` datetime DEFAULT NULL,
  `tanggal_tutup` datetime DEFAULT NULL,
  `status_lowongan` varchar(50) DEFAULT NULL,
  `limit_pelamar` int(11) DEFAULT NULL,
  `jumlah_pelamar` int(11) DEFAULT 0,
  `harga_jasa` decimal(12,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `lowongan`
--

INSERT INTO `lowongan` (`id_lowongan`, `user_id`, `jenis_lowongan`, `nama_lowongan`, `deskripsi`, `tanggal_unggah`, `tanggal_tutup`, `status_lowongan`, `limit_pelamar`, `jumlah_pelamar`, `harga_jasa`, `created_at`, `updated_at`) VALUES
(1, 7, 'Editor', 'Editor Naskah', 'Editor naskah etc', '2025-05-07 17:53:22', '2025-05-22 00:00:00', 'aktif', 11, 1, 50.00, '0000-00-00 00:00:00', '2025-05-19 17:05:12'),
(2, 6, 'Analisatot', 'Data Analyst', 'deskripsi', '2025-05-07 19:22:21', '2025-05-22 00:00:00', 'aktif', 5, 1, 1000000.00, '0000-00-00 00:00:00', '2025-05-19 17:00:44'),
(3, 6, 'Analisatot', 'Data Analyst', 'deskripsi', '2025-05-07 19:23:39', '2025-05-28 00:00:00', 'tutup', 5, 0, 1000000.00, '0000-00-00 00:00:00', '2025-05-07 19:31:41'),
(4, 7, NULL, NULL, NULL, '2025-05-19 16:05:37', NULL, 'tutup', NULL, 1, NULL, '0000-00-00 00:00:00', '2025-05-20 05:38:52'),
(5, 12, 'Work From Anyware', 'Content Creator', 'Halo saya Yola, seorang HRD di TaskTroop Company. Disini saya sedang mencari ahli dalam pembuatan video content sebagai bahan promosi perusahaan saya.Pekerjaan ini bisa dilakukan dimanapun, baik di rumah, kantor, maupun tempat favorit kalian. Saya sangat menunggu partisipasi dari kalian. Atas waktu dan ketersediaan anda untuk melamar, saya ucapkan terima kasih.', '2025-05-20 13:01:31', '2025-05-31 00:00:00', 'aktif', 10, 1, 5000000.00, '0000-00-00 00:00:00', '2025-05-20 15:05:37');

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `buyer_id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `requirements` text DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `commission_fee` decimal(12,2) NOT NULL,
  `delivery_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `portofolio`
--

CREATE TABLE `portofolio` (
  `id_porto` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `file` varchar(255) NOT NULL,
  `caption` longtext NOT NULL,
  `date_post` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `services`
--

CREATE TABLE `services` (
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `duration` int(11) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `avg_rating` decimal(3,2) DEFAULT 0.00,
  `total_orders` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `is_seller` tinyint(1) DEFAULT 0,
  `rating` decimal(3,2) DEFAULT 0.00,
  `balance` decimal(12,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `full_name`, `phone_number`, `profile_picture`, `bio`, `is_seller`, `rating`, `balance`, `created_at`, `updated_at`) VALUES
(6, 'mairarully12', '239902348@guests.usu.ac.id', '$2y$10$9qcYmGoxvDfCnrIdZnmRu.vM00KR/IJE5hVhLKzncStcoothS/eZC', 'Maira Rully Berliana', '081234567890', '681b0700394e2_Screenshot (100).png', 'none', 0, 0.00, 0.00, '2025-05-07 07:08:48', '2025-05-07 07:08:48'),
(7, 'Viche', 'vichedwy@gmail.com', '$2y$10$MAh22Rt7.Lm30cPfwD8FJuB/9VXp5MDIB2ara6tmjzwr5d/01iR96', 'Viche Dewayantiii', '089012345678', 'smilling.png', 'ya begitulah', 1, 0.00, 0.00, '2025-05-07 07:09:30', '2025-05-20 14:32:40'),
(10, '', '', '$2y$10$E30avxmS4XImqwN4FQEBLeopMCyJA./fgIF6ziCHcxieW6ywQ6qki', '', '', '', '', 0, 0.00, 0.00, '2025-05-19 14:05:51', '2025-05-19 14:05:51'),
(11, 'Yanola', 'yolayanola@gmail.com', '$2y$10$OP/iqkabxmjD1pe2Ti6Zu.jys2pijzXBFqAqK6P79lVx81DHExA4y', 'Yanola Leister', '0861890674', '682c152491c94_ice cream singapore.png', 'saya seorang yang ahli dalam desain', 0, 0.00, 0.00, '2025-05-20 05:37:40', '2025-05-20 05:37:40'),
(12, 'Yola', 'yanolayola@gmail.com', '$2y$10$JkxFdLzR1R8D4ULOMXtD6OP/dvHk0.CNsZu3i3O0K8JZNS7Iv7Mn6', 'Yola Yanolai', '08167945689', 'uploads/682c20a375b94_Orange Beige Potato Chips Food Logo_20241212_141650_0000.png', 'Halo saya Yola, seorang HRD di TaskTroop Company.', 0, 0.00, 0.00, '2025-05-20 06:26:43', '2025-05-20 06:26:43');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `parent_category_id` (`parent_category_id`);

--
-- Indeks untuk tabel `daftar_lowongan`
--
ALTER TABLE `daftar_lowongan`
  ADD PRIMARY KEY (`id_lamaran`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id_lowongan` (`id_lowongan`);

--
-- Indeks untuk tabel `lowongan`
--
ALTER TABLE `lowongan`
  ADD PRIMARY KEY (`id_lowongan`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `buyer_id` (`buyer_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indeks untuk tabel `portofolio`
--
ALTER TABLE `portofolio`
  ADD PRIMARY KEY (`id_porto`),
  ADD KEY `fk_portofolio_user` (`user_id`);

--
-- Indeks untuk tabel `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `seller_id` (`seller_id`,`category_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `daftar_lowongan`
--
ALTER TABLE `daftar_lowongan`
  MODIFY `id_lamaran` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `lowongan`
--
ALTER TABLE `lowongan`
  MODIFY `id_lowongan` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `portofolio`
--
ALTER TABLE `portofolio`
  MODIFY `id_porto` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `services`
--
ALTER TABLE `services`
  MODIFY `service_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `daftar_lowongan`
--
ALTER TABLE `daftar_lowongan`
  ADD CONSTRAINT `daftar_lowongan_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `daftar_lowongan_ibfk_2` FOREIGN KEY (`id_lowongan`) REFERENCES `lowongan` (`id_lowongan`);

--
-- Ketidakleluasaan untuk tabel `lowongan`
--
ALTER TABLE `lowongan`
  ADD CONSTRAINT `lowongan_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`seller_id`) REFERENCES `users` (`user_id`);

--
-- Ketidakleluasaan untuk tabel `portofolio`
--
ALTER TABLE `portofolio`
  ADD CONSTRAINT `fk_portofolio_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `services_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
