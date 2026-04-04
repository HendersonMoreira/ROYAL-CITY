-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.14.0.7169
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para baseroyal
CREATE DATABASE IF NOT EXISTS `baseroyal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `baseroyal`;

-- Copiando estrutura para tabela baseroyal.police_tablet_articles
CREATE TABLE IF NOT EXISTS `police_tablet_articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police_id` varchar(50) DEFAULT NULL,
  `code` varchar(30) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `fine_value` bigint(20) NOT NULL DEFAULT 0,
  `jail_time` int(11) NOT NULL DEFAULT 0,
  `created_by` int(11) NOT NULL,
  `is_global` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_article_police` (`police_id`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseroyal.police_tablet_articles: ~3 rows (aproximadamente)
REPLACE INTO `police_tablet_articles` (`id`, `police_id`, `code`, `title`, `description`, `fine_value`, `jail_time`, `created_by`, `is_global`, `created_at`) VALUES
	(1, 'LSPD', '157', 'MATAR', '---', 5000, 10, 1, 0, '2026-03-30 23:47:08'),
	(23, 'pm', '39', 'tráfico de drogas', 'Importar, exportar, remeter, preparar, produzir, fabricar, adquirir, vender, expor à venda, oferecer, ter em depósito, transportar, trazer consigo, guardar, prescrever, ministrar, entregar a consumo ou fornecer drogas, ainda que gratuitamente.', 15000, 150, 1, 0, '2026-04-03 00:57:55'),
	(25, 'pm', '121', 'Homicídio Simples', 'Matar alguém', 2500, 150, 1, 0, '2026-04-03 01:00:21');

-- Copiando estrutura para tabela baseroyal.police_tablet_bank_transactions
CREATE TABLE IF NOT EXISTS `police_tablet_bank_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police_id` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `amount` bigint(20) NOT NULL DEFAULT 0,
  `description` varchar(255) DEFAULT NULL,
  `actor_passport` int(11) NOT NULL,
  `actor_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_police_created` (`police_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseroyal.police_tablet_bank_transactions: ~26 rows (aproximadamente)
REPLACE INTO `police_tablet_bank_transactions` (`id`, `police_id`, `type`, `amount`, `description`, `actor_passport`, `actor_name`, `created_at`) VALUES
	(1, 'LSPD', 'deposit', 1000, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-03-30 23:48:40'),
	(2, 'LSPD', 'deposit', 1000, 'SD', 1, 'japa dev', '2026-03-30 23:48:45'),
	(3, 'LSPD', 'deposit', 1000, 'SD', 1, 'japa dev', '2026-03-30 23:49:17'),
	(4, 'LSPD', 'withdraw', 10, 'Saque do caixa da corporação', 1, 'japa dev', '2026-03-31 02:35:29'),
	(5, 'LSPD', 'deposit', 20000, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-03-31 02:50:27'),
	(6, 'pm', 'deposit', 1, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 17:39:37'),
	(7, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 17:39:42'),
	(8, 'pm', 'transfer', 100, 'Transferência para passaporte 1', 1, 'japa dev', '2026-04-02 17:40:06'),
	(9, 'pm', 'deposit', 10000, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:04:30'),
	(10, 'pm', 'withdraw', 1000, 'Saque do caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:02'),
	(11, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:11'),
	(12, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:12'),
	(13, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:12'),
	(14, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:13'),
	(15, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:13'),
	(16, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:13'),
	(17, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:13'),
	(18, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:13'),
	(19, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:14'),
	(20, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:14'),
	(21, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 1, 'japa dev', '2026-04-02 18:05:14'),
	(22, 'pm', 'withdraw', 150, 'Saque do caixa da corporação', 1, 'japa dev', '2026-04-02 19:16:14'),
	(23, 'pm', 'deposit', 100, 'proprina', 1, 'japa dev', '2026-04-02 19:51:39'),
	(24, 'pm', 'deposit', 1, 'Depósito no caixa da corporação', 2, 'italo lana', '2026-04-03 19:56:25'),
	(25, 'pm', 'deposit', 100000000000000000, 'Depósito no caixa da corporação', 2, 'italo lana', '2026-04-03 19:58:34'),
	(26, 'pm', 'deposit', 100, 'Depósito no caixa da corporação', 4, 'tiofiu dev', '2026-04-03 22:08:11');

-- Copiando estrutura para tabela baseroyal.police_tablet_banks
CREATE TABLE IF NOT EXISTS `police_tablet_banks` (
  `police_id` varchar(50) NOT NULL,
  `balance` bigint(20) NOT NULL DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`police_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseroyal.police_tablet_banks: ~4 rows (aproximadamente)
REPLACE INTO `police_tablet_banks` (`police_id`, `balance`, `updated_at`) VALUES
	('LSPD', 22990, '2026-03-31 02:50:27'),
	('pc', 0, '2026-03-30 21:57:12'),
	('pm', 10000, '2026-04-03 22:09:13'),
	('prf', 0, '2026-03-30 21:57:12');

-- Copiando estrutura para tabela baseroyal.police_tablet_boletins
CREATE TABLE IF NOT EXISTS `police_tablet_boletins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police_id` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `involved` longtext DEFAULT NULL,
  `officers_involved` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `officer_passport` int(11) DEFAULT NULL,
  `officer_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseroyal.police_tablet_boletins: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseroyal.police_tablet_members
CREATE TABLE IF NOT EXISTS `police_tablet_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police_id` varchar(50) NOT NULL,
  `passport` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `role` varchar(100) NOT NULL,
  `hierarchy` int(11) NOT NULL DEFAULT 99,
  `badge` varchar(50) DEFAULT NULL,
  `last_seen` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_police_member` (`police_id`,`passport`),
  KEY `idx_police_hierarchy` (`police_id`,`hierarchy`)
) ENGINE=InnoDB AUTO_INCREMENT=886 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseroyal.police_tablet_members: ~2 rows (aproximadamente)
REPLACE INTO `police_tablet_members` (`id`, `police_id`, `passport`, `name`, `role`, `hierarchy`, `badge`, `last_seen`) VALUES
	(233, 'pm', 1, 'japa dev', 'MINISTRO DA DEFESA', 1, NULL, '2026-04-03 22:18:34'),
	(767, 'pm', 4, 'tiofiu dev', 'TENENTE CORONEL', 7, NULL, '2026-04-03 22:18:34');

-- Copiando estrutura para tabela baseroyal.police_tablet_notices
CREATE TABLE IF NOT EXISTS `police_tablet_notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police_id` varchar(50) NOT NULL,
  `title` varchar(120) NOT NULL,
  `content` text NOT NULL,
  `author_passport` int(11) NOT NULL,
  `author_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_notice_police` (`police_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseroyal.police_tablet_notices: ~3 rows (aproximadamente)
REPLACE INTO `police_tablet_notices` (`id`, `police_id`, `title`, `content`, `author_passport`, `author_name`, `created_at`) VALUES
	(1, 'LSPD', 'REUNIAO ', 'BAN DA FAC', 1, 'japa dev', '2026-03-30 23:48:06'),
	(2, 'pm', 'fas', 'dfsdf', 1, 'japa dev', '2026-04-03 20:00:14'),
	(3, 'pm', 'teste', 'teste', 1, 'japa dev', '2026-04-03 20:53:54');

-- Copiando estrutura para tabela baseroyal.police_tablet_occurrences
CREATE TABLE IF NOT EXISTS `police_tablet_occurrences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police_id` varchar(50) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `suspect_name` varchar(100) DEFAULT NULL,
  `suspect_passport` int(11) DEFAULT NULL,
  `officer_passport` int(11) NOT NULL,
  `officer_name` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Aberta',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_occurrence_police` (`police_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseroyal.police_tablet_occurrences: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseroyal.police_tablet_prison_history
CREATE TABLE IF NOT EXISTS `police_tablet_prison_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police_id` varchar(50) DEFAULT NULL,
  `officer_passport` int(11) DEFAULT NULL,
  `officer_name` varchar(100) DEFAULT NULL,
  `suspect_passport` int(11) DEFAULT NULL,
  `suspect_name` varchar(100) DEFAULT NULL,
  `articles` longtext DEFAULT NULL,
  `article_codes` text DEFAULT NULL,
  `article_titles` text DEFAULT NULL,
  `total_fine` int(11) DEFAULT NULL,
  `total_prison` int(11) DEFAULT NULL,
  `additional_fine` int(11) DEFAULT NULL,
  `additional_prison` int(11) DEFAULT NULL,
  `observation` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseroyal.police_tablet_prison_history: ~8 rows (aproximadamente)
REPLACE INTO `police_tablet_prison_history` (`id`, `police_id`, `officer_passport`, `officer_name`, `suspect_passport`, `suspect_name`, `articles`, `article_codes`, `article_titles`, `total_fine`, `total_prison`, `additional_fine`, `additional_prison`, `observation`, `created_at`) VALUES
	(1, 'pm', 1, 'japa dev', 1, 'japa dev', '[{"description":"mata alhem","code":"175","title":"mata","jail_time":25,"id":2,"fine_value":150,"created_at":1775159608000.0},{"description":"mata alhem sad  asda  asd as dasd d asd ad asd asd adasda dasd ada sd ad ada ","code":"175","title":"mata","jail_time":25,"id":3,"fine_value":150,"created_at":1775159626000.0}]', '175, 175', 'mata, mata', 300, 50, 0, 0, '---', '2026-04-03 00:37:11'),
	(2, 'pm', 1, 'japa dev', 1, 'japa dev', '[]', '', '', 150, 0, 150, 0, 'ser preto', '2026-04-03 00:48:26'),
	(3, 'pm', 1, 'japa dev', 1, 'japa dev', '[{"title":"Homicídio Simples","code":"121","description":"Matar alguém","created_at":1775178021000.0,"id":25,"jail_time":150,"fine_value":2500}]', '121', 'Homicídio Simples', 2500, 150, 0, 0, '---', '2026-04-03 01:03:32'),
	(4, 'pm', 1, 'japa dev', 1, 'japa dev', '[{"created_at":1775178021000.0,"title":"Homicídio Simples","id":25,"code":"121","jail_time":150,"description":"Matar alguém","fine_value":2500}]', '121', 'Homicídio Simples', 2500, 170, 0, 20, '---', '2026-04-03 01:10:31'),
	(5, 'pm', 1, 'japa dev', 1, 'japa dev', '[]', '', '', 0, 0, 0, 0, '---', '2026-04-03 01:22:02'),
	(6, 'pm', 1, 'japa dev', 1, 'japa dev', '[]', '', '', 10, 10, 10, 10, '---', '2026-04-03 02:07:38'),
	(7, 'pm', 1, 'japa dev', 2, 'italo lana', '[{"title":"Homicídio Simples","id":25,"description":"Matar alguém","created_at":1775178021000.0,"jail_time":150,"fine_value":2500,"code":"121"},{"title":"tráfico de drogas","id":23,"description":"Importar, exportar, remeter, preparar, produzir, fabricar, adquirir, vender, expor à venda, oferecer, ter em depósito, transportar, trazer consigo, guardar, prescrever, ministrar, entregar a consumo ou fornecer drogas, ainda que gratuitamente.","created_at":1775177875000.0,"jail_time":150,"fine_value":15000,"code":"39"}]', '121, 39', 'Homicídio Simples, tráfico de drogas', 17500, 300, 0, 0, '---', '2026-04-03 19:40:57'),
	(8, 'pm', 1, 'japa dev', 3, 'R WRWR RW R', '[{"jail_time":150,"fine_value":2500,"description":"Matar alguém","created_at":1775178021000.0,"title":"Homicídio Simples","id":25,"code":"121"},{"jail_time":150,"fine_value":15000,"description":"Importar, exportar, remeter, preparar, produzir, fabricar, adquirir, vender, expor à venda, oferecer, ter em depósito, transportar, trazer consigo, guardar, prescrever, ministrar, entregar a consumo ou fornecer drogas, ainda que gratuitamente.","created_at":1775177875000.0,"title":"tráfico de drogas","id":23,"code":"39"}]', '121, 39', 'Homicídio Simples, tráfico de drogas', 17500, 300, 0, 0, '---', '2026-04-03 20:04:58');

-- Copiando estrutura para tabela baseroyal.police_tablet_procurados
CREATE TABLE IF NOT EXISTS `police_tablet_procurados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police_id` varchar(50) NOT NULL,
  `suspect_passport` int(11) NOT NULL,
  `suspect_name` varchar(100) NOT NULL,
  `suspect_age` int(11) DEFAULT NULL,
  `suspect_sex` varchar(20) DEFAULT NULL,
  `suspect_phone` varchar(50) DEFAULT NULL,
  `danger_level` int(11) NOT NULL DEFAULT 1,
  `reason` longtext DEFAULT NULL,
  `photo_url` longtext DEFAULT NULL,
  `officer_passport` int(11) DEFAULT NULL,
  `officer_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseroyal.police_tablet_procurados: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseroyal.police_tablet_seizure_history
CREATE TABLE IF NOT EXISTS `police_tablet_seizure_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `police_id` varchar(50) DEFAULT NULL,
  `officer_passport` int(11) DEFAULT NULL,
  `officer_name` varchar(100) DEFAULT NULL,
  `suspect_passport` int(11) DEFAULT NULL,
  `suspect_name` varchar(100) DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `item_amount` int(11) DEFAULT NULL,
  `observation` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseroyal.police_tablet_seizure_history: ~4 rows (aproximadamente)
REPLACE INTO `police_tablet_seizure_history` (`id`, `police_id`, `officer_passport`, `officer_name`, `suspect_passport`, `suspect_name`, `item_name`, `item_amount`, `observation`, `created_at`) VALUES
	(1, 'pm', 1, 'japa dev', 1, 'japa dev', 'Não informado', 0, 'ser preto', '2026-04-03 00:49:02'),
	(2, 'pm', 1, 'japa dev', 1, 'japa dev', 'glock ,muni', 1, '---', '2026-04-03 01:21:57'),
	(3, 'pm', 1, 'japa dev', 1, 'japa dev', 'glock ,muni', 1, '---', '2026-04-03 01:25:41'),
	(4, 'pm', 1, 'japa dev', 1, 'japa dev', 'arma', 1, '---', '2026-04-03 02:16:34');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
