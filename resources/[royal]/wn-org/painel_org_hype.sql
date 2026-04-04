-- Tabela de membros
CREATE TABLE IF NOT EXISTS `wn_org_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `passport` int(11) NOT NULL,
  `org` varchar(50) NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `hired_date` bigint(20) NOT NULL,
  `hired_by` int(11) NOT NULL,
  `last_login` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `passport_org` (`passport`, `org`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de banco
CREATE TABLE IF NOT EXISTS `wn_org_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org` varchar(50) NOT NULL,
  `balance` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `org` (`org`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de transações
CREATE TABLE IF NOT EXISTS `wn_org_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `amount` bigint(20) NOT NULL,
  `passport` int(11) NOT NULL,
  `description` text NOT NULL,
  `date` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de blacklist
CREATE TABLE IF NOT EXISTS `wn_org_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `passport` int(11) NOT NULL,
  `org` varchar(50) NOT NULL,
  `reason` text NOT NULL,
  `added_by` int(11) NOT NULL,
  `expire_date` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `passport` (`passport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de logs do baú
CREATE TABLE IF NOT EXISTS `wn_org_chest_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org` varchar(50) NOT NULL,
  `passport` int(11) NOT NULL,
  `chest_type` varchar(20) NOT NULL DEFAULT 'Normal',
  `action` varchar(10) NOT NULL,
  `item` varchar(100) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `amount` int(11) NOT NULL,
  `date` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `org` (`org`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de estatísticas de membros
CREATE TABLE IF NOT EXISTS `wn_org_member_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `passport` int(11) NOT NULL,
  `org` varchar(50) NOT NULL,
  `farm_progress` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `passport_org` (`passport`, `org`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de tempo jogado
CREATE TABLE IF NOT EXISTS `wn_org_playtime` (
  `passport` int(11) NOT NULL,
  `total_seconds` bigint(20) NOT NULL DEFAULT 0,
  `last_update` bigint(20) NOT NULL,
  PRIMARY KEY (`passport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela de uniformes das organizações
CREATE TABLE IF NOT EXISTS `wn_org_uniforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org` varchar(50) NOT NULL,
  `customization` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `org` (`org`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Inserir bancos iniciais para as organizações
INSERT INTO `wn_org_bank` (`org`, `balance`) VALUES
('Policia', 0),
('Hospital', 0),
('Mecanica', 0);
