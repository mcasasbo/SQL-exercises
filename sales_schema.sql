CREATE SCHEMA Sales_;

CREATE TABLE `customers` (
	`id_customer` INT(11) NOT NULL,
	`name` VARCHAR (50) DEFAULT NULL,
    `first_name` VARCHAR (50) DEFAULT NULL, 
    PRIMARY KEY (`id_customer`)
    ) ENGINE = InnoDB DEFAULT CHARSET = latin1;
    
CREATE TABLE `office` (
	`id_office` INT(11) NOT NULL,
    description VARCHAR (50) DEFAULT NULL,
	PRIMARY KEY (`id_customer`)
    ) ENGINE = InnoDB DEFAULT CHARSET = latin1;
    
CREATE TABLE `products` (
	`id_product` INT(11) NOT NULL,
	`descripcion` VARCHAR(225) DEFAULT NULL,
	`net_margin` DECIMAL(10,2) DEFAULT NULL,
	PRIMARY KEY (`id_product`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `staff` (
	`id_employee` INT(11) NOT NULL,
	`name` VARCHAR(225) DEFAULT NULL,
	`first_name` VARCHAR(225) DEFAULT NULL,
    `birthday` DATE DEFAULT NULL,
    `id_office` INT(11) DEFAULT NULL,
	PRIMARY KEY (`id_employee`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `sales` (
	`id_customer` INT(11) DEFAULT NULL,
	`id_employee` INT(11) DEFAULT NULL,
	`id_product` INT(11) DEFAULT NULL,
	`date` DATE DEFAULT NULL,
	`id_sale` VARCHAR(50) NOT NULL,
	PRIMARY KEY (`id_sale`),
	KEY `id_customer` (`id_customer`),
	KEY `id_employee` (`id_employee`),
	KEY `id_product` (`id_product`),
		CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id_customer`),
		CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`id_employee`) REFERENCES `staff` (`id_employee`),
		CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`id_product`) REFERENCES `products` (`id_product`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


