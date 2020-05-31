CREATE TABLE `players` (
	`id` VARCHAR(17) NOT NULL,
	`name` VARCHAR(150) NOT NULL,
	`loyalty` INT NOT NULL DEFAULT 0,
	`cavbucks` INT NOT NULL DEFAULT 0,
	`curator_type` VARCHAR(2) NULL,
	`last_login` TIMESTAMP NOT NULL DEFAULT NOW(),
	`created_at` TIMESTAMP NOT NULL DEFAULT NOW(),
	`updated_at` TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	PRIMARY KEY (`id`)
) COLLATE='latin1_spanish_ci';

CREATE TABLE `settings` (
	`id` VARCHAR(100) NOT NULL,
	`setting` TEXT NOT NULL,
	PRIMARY KEY (`id`)
) COLLATE='latin1_spanish_ci';