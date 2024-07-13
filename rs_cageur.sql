-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 13 Jul 2024 pada 10.38
-- Versi server: 10.4.11-MariaDB
-- Versi PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rs_cageur`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cek_umur_pasien` (IN `p_id_pasien` INT)  BEGIN
DECLARE umur INT;
SELECT TIMESTAMPDIFF(YEAR, tanggal_lahir, CURDATE()) INTO umur
FROM Pasien
WHERE id_pasien = p_id_pasien
LIMIT 1;
IF umur >= 18 THEN
SELECT 'Dewasa' AS Kategori;
ELSE
SELECT 'Anak-anak' AS Kategori;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `daftar_pasien` ()  BEGIN
SELECT * FROM Pasien;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_alamat_pasien` (`id_pasien` INT, `alamat_baru` VARCHAR(200))  BEGIN
UPDATE Pasien SET alamat = alamat_baru WHERE id_pasien = id_pasien;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_diagnosa` (`id_pasien` INT, `id_dokter` INT) RETURNS VARCHAR(255) CHARSET utf8mb4 BEGIN
DECLARE diagnosa VARCHAR(255);
SELECT diagnosa INTO diagnosa
FROM Kunjungan
WHERE id_pasien = id_pasien AND id_dokter = id_dokter
LIMIT 1;
RETURN diagnosa;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_total_pasien` () RETURNS INT(11) BEGIN
DECLARE total INT;
 SELECT COUNT(*) INTO total FROM Pasien;
RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokter`
--

CREATE TABLE `dokter` (
  `id_dokter` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `spesialisasi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `dokter`
--

INSERT INTO `dokter` (`id_dokter`, `nama`, `spesialisasi`) VALUES
(1, 'Dr. House', 'New Specialization'),
(4, 'Dr. McCoy', 'Surgery'),
(3, 'Dr. Strange', 'Neurology'),
(5, 'Dr. Watson', 'Cardiology'),
(2, 'Dr. Who', 'General Practice');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `horizontal_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `horizontal_view` (
`id_pasien` int(11)
,`nama` varchar(100)
,`alamat` varchar(200)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `indexedtable`
--

CREATE TABLE `indexedtable` (
  `id` int(11) NOT NULL,
  `column1` varchar(100) DEFAULT NULL,
  `column2` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `inner_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `inner_view` (
`id_kunjungan` int(11)
,`id_pasien` int(11)
,`diagnosa` varchar(255)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kunjungan`
--

CREATE TABLE `kunjungan` (
  `id_kunjungan` int(11) NOT NULL,
  `id_pasien` int(11) DEFAULT NULL,
  `id_dokter` int(11) DEFAULT NULL,
  `tanggal_kunjungan` date DEFAULT NULL,
  `diagnosa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kunjungan`
--

INSERT INTO `kunjungan` (`id_kunjungan`, `id_pasien`, `id_dokter`, `tanggal_kunjungan`, `diagnosa`) VALUES
(2, 2, 2, '2023-02-02', 'Cough'),
(3, 3, 3, '2023-03-03', 'Headache'),
(4, 4, 4, '2023-04-04', 'Fracture'),
(5, 5, 5, '2023-05-05', 'Chest Pain');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log`
--

CREATE TABLE `log` (
  `id_log` int(11) NOT NULL,
  `log_message` varchar(255) DEFAULT NULL,
  `log_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `log`
--

INSERT INTO `log` (`id_log`, `log_message`, `log_date`) VALUES
(22, 'Insert on Pasien: Test Trigger', '2024-07-11 05:52:16'),
(23, 'After Insert on Pasien: Test Trigger', '2024-07-11 05:52:16'),
(24, 'Update on Pasien: Jhon Doe to Trigger Updated', '2024-07-11 05:52:24'),
(25, 'After Update on Pasien: Jhon Doe to Trigger Updated', '2024-07-11 05:52:24'),
(27, 'Delete on Pasien: Trigger Updated', '2024-07-11 05:53:55'),
(28, 'After Delete on Pasien: Trigger Updated', '2024-07-11 05:53:55'),
(29, 'Insert on Pasien: New Patient', '2024-07-11 06:24:51'),
(30, 'After Insert on Pasien: New Patient', '2024-07-11 06:24:51'),
(31, 'Update on Pasien: Jane Smith to Jane Smith', '2024-07-11 14:53:22'),
(32, 'After Update on Pasien: Jane Smith to Jane Smith', '2024-07-11 14:53:22'),
(33, 'Update on Pasien: Alice Johnson to Alice Johnson', '2024-07-11 14:53:22'),
(34, 'After Update on Pasien: Alice Johnson to Alice Johnson', '2024-07-11 14:53:22'),
(35, 'Update on Pasien: Bob Brown to Bob Brown', '2024-07-11 14:53:22'),
(36, 'After Update on Pasien: Bob Brown to Bob Brown', '2024-07-11 14:53:22'),
(37, 'Update on Pasien: Charlie Davis to Charlie Davis', '2024-07-11 14:53:22'),
(38, 'After Update on Pasien: Charlie Davis to Charlie Davis', '2024-07-11 14:53:22'),
(39, 'Update on Pasien: New Patient to New Patient', '2024-07-11 14:53:22'),
(40, 'After Update on Pasien: New Patient to New Patient', '2024-07-11 14:53:22'),
(41, 'Update on Pasien: Test Trigger to Test Trigger', '2024-07-11 14:53:22'),
(42, 'After Update on Pasien: Test Trigger to Test Trigger', '2024-07-11 14:53:22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `obat`
--

CREATE TABLE `obat` (
  `id_obat` int(11) NOT NULL,
  `nama_obat` varchar(100) DEFAULT NULL,
  `jenis_obat` varchar(50) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `obat`
--

INSERT INTO `obat` (`id_obat`, `nama_obat`, `jenis_obat`, `harga`) VALUES
(1, 'Paracetamol', 'Analgesic', '5000.00'),
(2, 'Amoxicillin', 'Antibiotic', '15000.00'),
(3, 'Ibuprofen', 'Anti-inflammatory', '10000.00'),
(4, 'Cough Syrup', 'Antitussive', '20000.00'),
(5, 'Aspirin', 'Analgesic', '8000.00');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `outer_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `outer_view` (
`id_kunjungan` int(11)
,`nama` varchar(100)
,`diagnosa` varchar(255)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pasien`
--

CREATE TABLE `pasien` (
  `id_pasien` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pasien`
--

INSERT INTO `pasien` (`id_pasien`, `nama`, `alamat`, `tanggal_lahir`, `jenis_kelamin`) VALUES
(2, 'Jane Smith', 'JL New', '1990-02-02', 'Perempuan'),
(3, 'Alice Johnson', 'JL New', '1975-03-03', 'Perempuan'),
(4, 'Bob Brown', 'JL New', '1985-04-04', 'Laki-laki'),
(5, 'Charlie Davis', 'JL New', '2000-05-05', 'Laki-laki'),
(6, 'New Patient', 'JL New', NULL, NULL),
(10, 'Test Trigger', 'JL New', '2000-01-01', 'Laki-laki');

--
-- Trigger `pasien`
--
DELIMITER $$
CREATE TRIGGER `after_delete_pasien` AFTER DELETE ON `pasien` FOR EACH ROW BEGIN
INSERT INTO Log (log_message) VALUES (CONCAT('After Delete on Pasien: ', OLD.nama));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_pasien` AFTER INSERT ON `pasien` FOR EACH ROW BEGIN
INSERT INTO Log (log_message) VALUES (CONCAT('After Insert on Pasien: ', NEW.nama));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_pasien` AFTER UPDATE ON `pasien` FOR EACH ROW BEGIN
INSERT INTO Log (log_message) VALUES (CONCAT('After Update on Pasien: ', OLD.nama, ' to ', NEW.nama));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete_pasien` BEFORE DELETE ON `pasien` FOR EACH ROW INSERT INTO Log (log_message) VALUES (CONCAT('Delete on Pasien: ', OLD.nama));
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_pasien` BEFORE INSERT ON `pasien` FOR EACH ROW BEGIN
INSERT INTO Log (log_message) VALUES (CONCAT('Insert on Pasien: ', NEW.nama));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_pasien` BEFORE UPDATE ON `pasien` FOR EACH ROW BEGIN
INSERT INTO Log (log_message) VALUES (CONCAT('Update on Pasien: ', OLD.nama, ' to ', NEW.nama));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `resep`
--

CREATE TABLE `resep` (
  `id_resep` int(11) NOT NULL,
  `id_kunjungan` int(11) DEFAULT NULL,
  `id_obat` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `resep`
--

INSERT INTO `resep` (`id_resep`, `id_kunjungan`, `id_obat`, `jumlah`) VALUES
(2, 2, 2, 5),
(3, 3, 3, 15),
(4, 4, 4, 1),
(5, 5, 5, 20);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `vertical_view`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `vertical_view` (
`nama` varchar(100)
,`spesialisasi` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktur untuk view `horizontal_view`
--
DROP TABLE IF EXISTS `horizontal_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontal_view`  AS  select `pasien`.`id_pasien` AS `id_pasien`,`pasien`.`nama` AS `nama`,`pasien`.`alamat` AS `alamat` from `pasien` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `inner_view`
--
DROP TABLE IF EXISTS `inner_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inner_view`  AS  select `kunjungan`.`id_kunjungan` AS `id_kunjungan`,`kunjungan`.`id_pasien` AS `id_pasien`,`kunjungan`.`diagnosa` AS `diagnosa` from `kunjungan` where `kunjungan`.`id_pasien` = 1 ;

-- --------------------------------------------------------

--
-- Struktur untuk view `outer_view`
--
DROP TABLE IF EXISTS `outer_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `outer_view`  AS  select `iv`.`id_kunjungan` AS `id_kunjungan`,`p`.`nama` AS `nama`,`iv`.`diagnosa` AS `diagnosa` from (`inner_view` `iv` join `pasien` `p` on(`iv`.`id_pasien` = `p`.`id_pasien`)) WITH CASCADED CHECK OPTION ;

-- --------------------------------------------------------

--
-- Struktur untuk view `vertical_view`
--
DROP TABLE IF EXISTS `vertical_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vertical_view`  AS  select `dokter`.`nama` AS `nama`,`dokter`.`spesialisasi` AS `spesialisasi` from `dokter` ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id_dokter`),
  ADD KEY `idx_dokter_spesialisasi` (`nama`,`spesialisasi`);

--
-- Indeks untuk tabel `indexedtable`
--
ALTER TABLE `indexedtable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_composite` (`column1`,`column2`);

--
-- Indeks untuk tabel `kunjungan`
--
ALTER TABLE `kunjungan`
  ADD PRIMARY KEY (`id_kunjungan`),
  ADD KEY `id_dokter` (`id_dokter`),
  ADD KEY `kunjungan_ibfk_1` (`id_pasien`);

--
-- Indeks untuk tabel `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indeks untuk tabel `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id_obat`);

--
-- Indeks untuk tabel `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id_pasien`),
  ADD KEY `idx_pasien_nama_alamat` (`nama`,`alamat`);

--
-- Indeks untuk tabel `resep`
--
ALTER TABLE `resep`
  ADD PRIMARY KEY (`id_resep`),
  ADD KEY `id_obat` (`id_obat`),
  ADD KEY `resep_ibfk_1` (`id_kunjungan`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id_dokter` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `kunjungan`
--
ALTER TABLE `kunjungan`
  MODIFY `id_kunjungan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `log`
--
ALTER TABLE `log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT untuk tabel `obat`
--
ALTER TABLE `obat`
  MODIFY `id_obat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id_pasien` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `resep`
--
ALTER TABLE `resep`
  MODIFY `id_resep` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `kunjungan`
--
ALTER TABLE `kunjungan`
  ADD CONSTRAINT `kunjungan_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`) ON DELETE CASCADE,
  ADD CONSTRAINT `kunjungan_ibfk_2` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`);

--
-- Ketidakleluasaan untuk tabel `resep`
--
ALTER TABLE `resep`
  ADD CONSTRAINT `resep_ibfk_1` FOREIGN KEY (`id_kunjungan`) REFERENCES `kunjungan` (`id_kunjungan`) ON DELETE CASCADE,
  ADD CONSTRAINT `resep_ibfk_2` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
