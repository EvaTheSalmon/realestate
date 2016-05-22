--
-- Скрипт сгенерирован Devart dbForge Studio for MySQL, Версия 7.1.13.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 22.05.2016 4:17:16
-- Версия сервера: 5.6.28
-- Версия клиента: 4.1
--


-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

--
-- Описание для таблицы `settlement-type`
--
DROP TABLE IF EXISTS `settlement-type`;
CREATE TABLE `settlement-type` (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы district
--
DROP TABLE IF EXISTS district;
CREATE TABLE district (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 42
AVG_ROW_LENGTH = 455
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы people
--
DROP TABLE IF EXISTS people;
CREATE TABLE people (
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(255) NOT NULL,
  `middle-name` VARCHAR(50) DEFAULT NULL,
  `filial-id` INT(11) DEFAULT 0,
  passport VARCHAR(255) DEFAULT NULL,
  email VARCHAR(50) NOT NULL,
  id INT(11) NOT NULL AUTO_INCREMENT,
  pass_hash VARCHAR(255) NOT NULL,
  phonenumb VARCHAR(255) DEFAULT NULL,
  email_hash VARCHAR(255) DEFAULT NULL,
  `limit` INT(11) DEFAULT 5,
  PRIMARY KEY (id),
  UNIQUE INDEX hash (pass_hash),
  UNIQUE INDEX passport (passport),
  UNIQUE INDEX phonenumb (phonenumb)
)
ENGINE = INNODB
AUTO_INCREMENT = 107
AVG_ROW_LENGTH = 618
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы street
--
DROP TABLE IF EXISTS street;
CREATE TABLE street (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX name (name)
)
ENGINE = INNODB
AUTO_INCREMENT = 735
AVG_ROW_LENGTH = 91
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы type
--
DROP TABLE IF EXISTS type;
CREATE TABLE type (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы settling
--
DROP TABLE IF EXISTS settling;
CREATE TABLE settling (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  `settlement-type-id` INT(11) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX name (name),
  CONSTRAINT `FK_settling_settlement-type_id` FOREIGN KEY (`settlement-type-id`)
    REFERENCES `settlement-type`(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 13
AVG_ROW_LENGTH = 1638
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы firm
--
DROP TABLE IF EXISTS firm;
CREATE TABLE firm (
  id INT(11) NOT NULL AUTO_INCREMENT,
  `schet-number` VARCHAR(255) NOT NULL,
  house INT(11) NOT NULL,
  `street-id` INT(11) NOT NULL,
  `district-id` INT(11) NOT NULL,
  `settling-id` INT(11) NOT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX name (name),
  UNIQUE INDEX `schet-number` (`schet-number`),
  UNIQUE INDEX `UK_firm_schet-number` (`schet-number`),
  UNIQUE INDEX UK_firm_unic_adress (house, `street-id`, `district-id`, `settling-id`),
  CONSTRAINT FK_firm_district_id FOREIGN KEY (`district-id`)
    REFERENCES district(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_firm_settling_id FOREIGN KEY (`settling-id`)
    REFERENCES settling(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_firm_street_id FOREIGN KEY (`street-id`)
    REFERENCES street(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы object
--
DROP TABLE IF EXISTS object;
CREATE TABLE object (
  id INT(11) NOT NULL AUTO_INCREMENT,
  `agent-id` INT(11) NOT NULL,
  `seller-id` INT(11) NOT NULL,
  title VARCHAR(255) NOT NULL,
  cost DECIMAL(19, 2) NOT NULL,
  number INT(11) NOT NULL,
  `room-count` INT(3) DEFAULT NULL,
  `type-id` INT(11) NOT NULL,
  `offer-date` DATETIME NOT NULL,
  description VARCHAR(1024) DEFAULT NULL,
  house INT(11) NOT NULL,
  `street-id` INT(11) NOT NULL,
  `district-id` INT(11) NOT NULL,
  `settling-id` INT(11) NOT NULL,
  customer INT(11) DEFAULT NULL,
  sold TINYINT(1) DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE INDEX number (number),
  UNIQUE INDEX UK_object_unic_adress (house, `street-id`, `district-id`, `settling-id`),
  CONSTRAINT FK_object_agent_id FOREIGN KEY (`agent-id`)
    REFERENCES people(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_object_district_id FOREIGN KEY (`district-id`)
    REFERENCES district(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_object_people_id FOREIGN KEY (customer)
    REFERENCES people(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_object_seller_id FOREIGN KEY (`seller-id`)
    REFERENCES people(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_object_settling_id FOREIGN KEY (`settling-id`)
    REFERENCES settling(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_object_street_id FOREIGN KEY (`street-id`)
    REFERENCES street(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_object_type_id FOREIGN KEY (`type-id`)
    REFERENCES type(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 37
AVG_ROW_LENGTH = 630
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы filials
--
DROP TABLE IF EXISTS filials;
CREATE TABLE filials (
  id INT(11) NOT NULL AUTO_INCREMENT,
  phone INT(11) NOT NULL,
  fax INT(11) DEFAULT NULL,
  `graph-work` VARCHAR(255) NOT NULL,
  `director-id` INT(11) NOT NULL,
  `firm-id` INT(11) NOT NULL,
  house INT(11) NOT NULL,
  `street-id` INT(11) NOT NULL,
  `district-id` INT(11) NOT NULL,
  `settling-id` INT(11) NOT NULL,
  number VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX `director-id` (`director-id`),
  UNIQUE INDEX number (number),
  UNIQUE INDEX UK_filials_unic_adress (house, `street-id`, `district-id`, `settling-id`),
  CONSTRAINT FK_filials_director_id FOREIGN KEY (`director-id`)
    REFERENCES people(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_filials_district_id FOREIGN KEY (`district-id`)
    REFERENCES district(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_filials_firm_id FOREIGN KEY (`firm-id`)
    REFERENCES firm(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_filials_settling_id FOREIGN KEY (`settling-id`)
    REFERENCES settling(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_filials_street_id FOREIGN KEY (`street-id`)
    REFERENCES street(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 21
AVG_ROW_LENGTH = 862
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы reviews
--
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  id INT(11) NOT NULL AUTO_INCREMENT,
  author INT(11) NOT NULL,
  text LONGTEXT NOT NULL,
  object INT(11) NOT NULL,
  date DATETIME NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_reviews_object_id FOREIGN KEY (object)
    REFERENCES object(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT FK_reviews_people_id FOREIGN KEY (author)
    REFERENCES people(id) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'отзывы';

--
-- Описание для таблицы transaction
--
DROP TABLE IF EXISTS transaction;
CREATE TABLE transaction (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number INT(11) NOT NULL,
  date DATETIME NOT NULL,
  `object-id` INT(11) NOT NULL,
  `customer-id` INT(11) NOT NULL,
  `agents-id` INT(11) NOT NULL,
  `seller-id` INT(11) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX number (number),
  CONSTRAINT FK_transaction_agent_id FOREIGN KEY (`agents-id`)
    REFERENCES people(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_transaction_customer_id FOREIGN KEY (`customer-id`)
    REFERENCES people(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_transaction_object_id FOREIGN KEY (`object-id`)
    REFERENCES object(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_transaction_seller_id FOREIGN KEY (`seller-id`)
    REFERENCES people(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 21
AVG_ROW_LENGTH = 819
CHARACTER SET utf8
COLLATE utf8_general_ci;

DELIMITER $$

--
-- Описание для процедуры pr
--
DROP PROCEDURE IF EXISTS pr$$
CREATE PROCEDURE pr()
BEGIN 
  DECLARE i integer DEFAULT 0;
  UPDATE realestate.filials SET `graph-work`='Понедельник - Пятница' WHERE `firm-id`=1 ORDER BY `id`;
  END
$$

--
-- Описание для процедуры upd
--
DROP PROCEDURE IF EXISTS upd$$
CREATE PROCEDURE upd()
BEGIN 
  DECLARE i integer DEFAULT 0;
  DECLARE b integer DEFAULT 0;
  select COUNT(*) from object o INTO b;
  WHILE i<=b do
  UPDATE realestate.people p SET p.phonenumb=CONCAT(8,ROUND(RAND()*10000000000)) ORDER BY `id`;
  END WHILE;
  END
$$

--
-- Описание для процедуры upd1
--
DROP PROCEDURE IF EXISTS upd1$$
CREATE PROCEDURE upd1()
BEGIN 
  DECLARE i integer DEFAULT 0;
  DECLARE b integer DEFAULT 0;
  select COUNT(*) from people p INTO b;
  WHILE i<=b do
  UPDATE realestate.people p SET `p`.`filial-id`='0' ORDER BY `p`.`name` LIMIT 80;
  END WHILE;
  END
$$

DELIMITER ;

-- 
-- Вывод данных для таблицы `settlement-type`
--
INSERT INTO `settlement-type` VALUES
(1, 'Город'),
(2, 'Посёлок'),
(3, 'Деревня');

-- 
-- Вывод данных для таблицы district
--
INSERT INTO district VALUES
(1, 'Адмиралтейский'),
(2, 'Василеостровский'),
(3, 'Выборгский'),
(4, 'Калининский'),
(5, 'Кировский'),
(6, 'Колпинский'),
(7, 'Красногвардейский'),
(8, 'Красносельский'),
(9, 'Кронштадтский'),
(10, 'Курортный'),
(11, 'Московский'),
(12, 'Невский'),
(13, 'Петроградский'),
(14, 'Петродворцовый'),
(15, 'Приморский'),
(16, 'Пушкинский'),
(17, 'Фрунзенский'),
(18, 'Центральный'),
(19, ''),
(20, 'Калининский'),
(21, 'Калининский'),
(22, 'Калининский'),
(23, 'Калининский'),
(24, 'Калиниский'),
(25, 'Калиниский'),
(26, 'Калиниский'),
(27, 'Калиниский'),
(28, 'Калиниский'),
(29, 'Калиниский'),
(30, 'Калининский'),
(31, 'Калининский'),
(32, ''),
(33, 'Автозаводский'),
(34, 'Автозаводский'),
(35, 'Автозаводский'),
(36, 'Автозаводский'),
(37, 'Автозаводский'),
(38, 'Автозаводский'),
(39, 'Автозаводский'),
(40, ''),
(41, 'Автозаводский');

-- 
-- Вывод данных для таблицы people
--
INSERT INTO people VALUES
('Алексей ', 'Гаврилов ', 'Аркадьевич ', 0, '2147483647', 'jftf@b-d-un.com', 1, '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', '84685690882', '20817951010594294b15a08cb86b015493f5857df2852744c85c763495576e81', 5),
('Роберт ', 'Соболев ', 'Борисович ', 0, '1794325686', 'pvgg7@---k--.net', 2, 'd4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35', '88296537016', '5b26c86628bd0e501930281c8f378907cba4c4e6665ce62b55761b822deab719', 5),
('Глеб ', 'Журавлёв ', 'Георгиевич ', 0, '1694867625', 'mbgz@-o--yq.org', 3, '4e07408562bedb8b60ce05c1decfe3ad16b72230967de01f640b7e4729b49fce', '87425612740', 'e636d70d7b7919c658f9755311cc8d078904d16bf8b0db71110f7edf2e483862', 5),
('Марат ', 'Константинов ', 'Витальевич ', 0, '1361442462', 'jctg@-m-v--.org', 4, '4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a', '82238452958', '8623e49f3081a8fa1cd2f59d9c556e36608ca178a2c2d2990614438f5411b0d1', 5),
('Эрик ', 'Пономарёв ', 'Васильевич ', 5, '2128906116', 'pbgw@-ork-w.org', 5, 'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d', '88915426879', '0f731317fa8ee78f4cdb512870b391d4ad4bcd04c604cac3dd8e8b5106987f65', 5),
('Виталий ', 'Морозов ', 'Степанович ', 0, '1306963308', 'lllq@x-bvg-.net', 6, 'e7f6c011776e8db7cd330b54174fd76f7d0216b612387a5ffcfb81e6f0919683', '87861775828', 'd1bb59942dd89caf0fa39be0a46108dfd7f7a97982fd2de40a32f1176c5e6a1e', 5),
('Богдан ', 'Мясников ', 'Владимирович ', 0, '1345986233', 'nnni694@g-ifw-.com', 7, '7902699be42c8a8e46fbbb4501726517e86b22c56a189f7625a6da49081b2451', '82562598812', '9caf6da02c662e8b973ebab92ea8104e359eb1e30d072ce5a92062f97301d0fe', 5),
('Антон ', 'Романов ', 'Степанович ', 0, '1824531536', 'kpptg383@--mnpb.org', 8, '2c624232cdd221771294dfbb310aca000a0df6ac8b66b696d90ef06fdefb64a3', '89227666882', '646d897c9dca0bb9141d342ba7134733e0dc2cf003d147024100bbd5a527b723', 5),
('Марсель ', 'Смирнов', 'Тарасович ', 0, '1254753613', 'tkjo@a-sqmv.com', 9, '19581e27de7ced00ff1ce50b2047e7a567c76b1cbaebabe5ef03f7c3017bb5b7', '88450538282', '22e940e4e71dcfa2cb72194e5a6edfd1327c2c7005c317487d4d549ba88a05f5', 5),
('Алан ', 'Субботин ', 'Егорович ', 0, '1070691183', 'fied.qzsx@-wz-ft.org', 10, '4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade6af1dd5', '84569691070', '73160f139c1abb11726deaf6aae429b25d9299f55d68d88e46c475f767398892', 5),
('Герман ', 'Осипов ', 'Игоревич ', 0, '1052937473', 'uylr@-fcf--.org', 11, '4fc82b26aecb47d2868c4efbe3581732a3e7cbcc6c2efb32062c08170a05eeb8', '87496840812', '68498f2b18cdae856304282958925edfe6deb1688437d86548462288f5b0fa3f', 5),
('Руслан ', 'Крюков ', 'Львович ', 3, '1134029156', 'mqpy79@-m-mqz.org', 12, '6b51d431df5d7f141cbececcf79edf3dd861c3b4069f0b11661a3eefacbba918', '83775131156', 'e361e24d68965e4a58c4e8d7c3a161bb989979b8b5aaf3f788b97b8bc2b8e9d9', 5),
('Савелий ', 'Терентьев ', 'Евгеньевич ', 3, '1619862308', 'vpvv.tely@k-c--j.com', 13, '3fdba35f04dc8c462986c992bcf875546257113072a909c162f7e470e581e278', '86385133654', '2245f4daaa9e14182c826d10ac5648592cb1dc42ab25793cae1664a323a3342e', 5),
('Владимир ', 'Русаков ', 'Борисович ', 8, '1743479276', 'umgis@v-wv-u.net', 14, '8527a891e224136950ff32ca212b45bc93f69fbb801c3b1ebedac52775f99e61', '86002751039', '7fb040345a7d42d5339572a3ff97484e8d6f2c7b86efab8469910a0e5ba000fd', 5),
('Роман ', 'Гуляев ', 'Владимирович ', 1, '1249438694', 'imts@-----s.net', 15, 'e629fa6598d732768f7c726b4b621285f9c3b85303900aa912017db7617d8bdb', '83845974890', '583071cda507e35a7a760a3ef8039118ff2d72cdb5a688f358719475a782b372', 5),
('Никита ', 'Зайцев ', 'Иванович ', 0, '1554619843', 'qxoj.wmjc@--b---.net', 16, 'b17ef6d19c7a5b1ee83b907c595526dcb1eb06db8227d650d5dda0a9f4ce8cd9', '87429049432', 'aef6380a76de7083068fe6d528d4eb5eecf577e4ba21e090931ff22cd639087b', 5),
('Олег ', 'Максимов ', 'Данилович ', 0, '2006257610', 'kmgv@lg--ly.com', 17, '4523540f1504cd17100c4835e85b7eefd49911580f8efff0599a8f283be6b9e3', '85607322795', '7244fc2490dc71e10a5717f670e9861b64c1d851e32d36b80edb7a45c3592939', 5),
('Алексей ', 'Чернов ', 'Алексеевич ', 3, '2078283128', 'xhvh.rkzad@s-----.com', 18, '4ec9599fc203d176a301536c2e091a19bc852759b255bd6818810a42c5fed14a', '85749465987', 'f81509139089f16fcbbcafa3bb44c18526f638fe718891a30e036dabcf166cce', 5),
('Эмиль ', 'Никонов ', 'Михайлович ', 9, '1884050567', 'popz.vpvehk@m--bl-.net', 19, '9400f1b21cb527d7fa3d3eabba93557a18ebe7a2ca4e471cfe5e4c5b4ca7f767', '81925361857', 'fd009d1fdeae824fdd3429f03d2744f23112ab83d640516ea233c331ec2ba785', 5),
('Богдан ', 'Яковлев ', 'Игоревич ', 0, '1308235899', 'msjy@m----m.com', 20, 'f5ca38f748a1d6eaf726b8a42fb575c3c71f1864a8143301782de13da2d9202b', '82378411631', '3b87324dcd604030e7514c23798320dd130be9f6d957efa63b52c7b3c1fc3a68', 5),
('Константин ', 'Ефимов ', 'Владиславович ', 0, '1560258265', 'xrto92@--jopi.com', 21, '6f4b6612125fb3a0daecd2799dfd6c9c299424fd920f9b308110a2c1fbd8f443', '86115972890', 'ffdc5febfc0a9f6cc1aac9e11f4127d7558e2915daad21a00aa020cc4d9f35f9', 5),
('Игорь ', 'Самойлов ', 'Олегович ', 0, '2128012196', 'enqlbqcu@-o----.com', 22, '785f3ec7eb32f30b90cd0fcf3657d388b5ff4297f2f9716ff66e9b69c05ddd09', '83444629864', '6bba770cfcad0e8e69437818c150f6705a1a1abd1707c756c19b19f25778b8c3', 5),
('Богдан ', 'Игнатьев ', 'Аркадьевич ', 0, '1872290114', 'dafs.cflv@-y--s-.org', 23, '535fa30d7e25dd8a49f1536779734ec8286108d115da5045d77f3b4185d8f790', '88875230960', 'e46665b3003a77f1b718d43cbf7fbc85c6b82f6a2efc2de0b47b39c44204bffc', 5),
('Владимир ', 'Филатов ', 'Романович ', 0, '1138724313', 'vlmk.nrup@---fht.net', 24, 'c2356069e9d1e79ca924378153cfbbfb4d4416b1f99d41a2940bfdb66c5319db', '84042265512', '1276037f98392ead073d5cc57dd1c2f26ea2d3d187c064fecb1caa9391438d81', 5),
('Станислав ', 'Гуляев ', 'Кириллович ', 7, '1299494471', 'ypvcjb@----du.org', 25, 'b7a56873cd771f2c446d369b649430b65a756ba278ff97ec81bb6f55b2e73569', '83585634989', '42f9794a478b15547465fc64dad50dc000b3a10abdba7fbabb0bdeb662b3c132', 5),
('Геннадий ', 'Сафонов ', 'Антонович ', 0, '2140014308', 'qotv0@s-i--d.com', 26, '5f9c4ab08cac7457e9111a30e4664920607ea2c115a1433d7be98e97e64244ca', '85801378717', '50ecee2e0e7aefb0952509f08c6635846ceac41b2a0792ee1900353153e3cf10', 5),
('Игорь ', 'Кулаков ', 'Богданович ', 0, '2005285017', 'igpks@------.org', 27, '670671cd97404156226e507973f2ab8330d3022ca96e0c93bdbdb320c41adcaf', '88249988927', '86e8db0c3b933de3dddea0762ae52b306005c90fadf6a45ee5648bd4d67310ff', 5),
('Сергей ', 'Шестаков ', 'Леонидович ', 6, '1714913951', 'vgtblz202@wr-ml-.net', 28, '59e19706d51d39f66711c2653cd7eb1291c94d9b55eb14bda74ce4dc636d015a', '83845808789', 'b3201ad48da3b51623dffec4611276f66938000cde6e78cbf87611d8ab8355ca', 5),
('Леонид ', 'Фомин ', 'Ефимович ', 0, '1168746584', 'hueb223@fhym.km-dfk.com', 29, '35135aaa6cc23891b40cb3f378c53a17a1127210ce60e125ccf03efcfdaec458', '84479077472', '818150a04ea957bfee164b79399bc8f5e19f575bac53cc858200e04233caec2b', 5),
('Артем ', 'Алексеев ', 'Антонович ', 6, '1396225312', 'msxe@siuc--.net', 30, '624b60c58c9d8bfb6ff1886c2fd605d2adeb6ea4da576068201b6c6958ce93f4', '88579613020', '43f2572d8b081de984bdb47eace74228fe3f8d90abc31421ecbac8461d8931d9', 5),
('Дмитрий ', 'Владимиров ', 'Егорович ', 0, '1980350689', 'obft@-----q.org', 31, 'eb1e33e8a81b697b75855af6bfcdbcbf7cbbde9f94962ceaec1ed8af21f5a50f', '88525743910', '27548b2abb2bf8cf53757cade891c25e397524db528c5169075f1e0811702d16', 5),
('Антон ', 'Уваров ', 'Павлович ', 0, '1199853430', 'yqwc.rvrilg@u-----.net', 32, 'e29c9c180c6279b0b02abd6a1801c7c04082cf486ec027aa13515e4f3884bb6b', '81688988359', '2f92b7b597b9a68cafee0a23ca345d2ceef155ca2aa8a9ec6d463e340211711d', 5),
('Альберт ', 'Лыткин ', 'Валерьевич ', 0, '1197262406', 'gsaa@-o-tn-.com', 33, 'c6f3ac57944a531490cd39902d0f777715fd005efac9a30622d5f5205e7f6894', '85887218933', 'e1b4a0273920fbc3fa2c117944d75222bab27252781020d7dc15bd47b2bc2b5f', 5),
('Олег ', 'Шестаков ', 'Андреевич ', 2, '1290250854', 'ztjr1@-lw---.com', 34, '86e50149658661312a9e0b35558d84f6c6d3da797f552a9657fe0558ca40cdef', '84369129897', '222c88e5f6a55d4e04a16a53814742773bc67c2d552257941ccab66ccac50e36', 5),
('Валерий ', 'Дьячков ', 'Матвеевич ', 0, '1315116791', 'kylfg4@p-c--m.org', 35, '9f14025af0065b30e47e23ebb3b491d39ae8ed17d33739e5ff3827ffb3634953', '84183992990', 'fd775061dcd3ad5b19226c85685438f82c8b23446a44465a852d27021e960fd9', 5),
('Марат ', 'Одинцов ', 'Станиславович ', 12, '1353556367', 'fmqm5@t-yjuc.com', 36, '76a50887d8f1c2e9301755428990ad81479ee21c25b43215cf524541e0503269', '87812575565', 'ecdd6083fdea27b7f4ebd000ea5aff572139a7a3efe9679ae699a2fcd97c1e87', 5),
('Олег ', 'Орлов ', 'Матвеевич ', 0, '1971040626', 'rbzi@--ol--.org', 37, '7a61b53701befdae0eeeffaecc73f14e20b537bb0f8b91ad7c2936dc63562b25', '86510899166', 'f5d42e3707a485a2b163d01dc37bbbce396bc6d6286ac8d5373bc8aec2a82813', 5),
('Кирилл ', 'Комиссаров ', 'Васильевич ', 0, '1601221380', 'wvob@---o--.com', 38, 'aea92132c4cbeb263e6ac2bf6c183b5d81737f179f21efdc5863739672f0f470', '89116769442', '5b650411534ddc045b539663f3b4407f773f8361ada6363ab8d380b98c2c8565', 5),
('Альберт ', 'Лихачёв ', 'Владимирович ', 0, '1844881587', 'bbkv@--n-ad.com', 39, '0b918943df0962bc7a1824c0555a389347b4febdc7cf9d1254406d80ce44e3f9', '86051150017', 'a5a9b6aec76904baee51c5cdc34134deb73f7677f16f00afe9f1d1b5aadabdf8', 5),
('Сергей ', 'Антонов ', 'Тимофеевич ', 7, '1509695321', 'fibp.nhofrpe@gv-pfn.net', 40, 'd59eced1ded07f84c145592f65bdf854358e009c5cd705f5215bf18697fed103', '82905442065', 'ee0870f7890f5fcc2d010ee813af98a5e420c3eabeaa97d6566c2e2be17343fa', 5),
('Матвей ', 'Соболев ', 'Владиславович ', 0, '1165739583', 'rjwzv8@e-y-jg.com', 41, '3d914f9348c9cc0ff8a79716700b9fcd4d2f3e711608004eb8f138bcba7f14d9', '86373760585', '476c81395af4d326ddbf7b4925b4a5764de2a7948c87d8c8ca8d738f49e993b7', 5),
('Богдан ', 'Пестов ', 'Игоревич ', 0, '1764339860', 'yaom.oryved@ncgngmk.-a----.com', 42, '73475cb40a568e8da8a045ced110137e159f890ac4da883b6b17dc651b3a8049', '83152477036', '0cd3adc0f3c129a4e4b49c6ecaead1e71b706c0b00597238ee95a3b7adf6bb92', 5),
('Рафаэль ', 'Игнатов ', 'Матвеевич ', 0, '1365618885', 'yhvn.icuq@-wz-v-.net', 43, '44cb730c420480a0477b505ae68af508fb90f96cf0ec54c6ad16949dd427f13a', '86641103734', 'cb1763b41fa8a226db3c0f264efb433a28f1db0598ea42ef71d6d7139d59815b', 5),
('Александр ', 'Мышкин ', 'Богданович ', 2, '1555339606', 'uwfe@atbt.wy----.org', 44, '71ee45a3c0db9a9865f7313dd3372cf60dca6479d46261f3542eb9346e4a04d6', '83748087868', 'efe736ce9359be0c8f84614c3d7bbecdffa4df46f47265fef41108f9df905b12', 5),
('Геннадий ', 'Пахомов ', 'Витальевич ', 3, '1450403601', 'wjdk084@xm-dlc.com', 45, '811786ad1ae74adfdd20dd0372abaaebc6246e343aebd01da0bfc4c02bf0106c', '88817128445', '4d559468ad95fffccc87eed4ccc66e30c103aee7721c111bd1291c619b633afe', 5),
('Альберт ', 'Иванков ', 'Ярославович', 0, '2145498700', 'whxy8@-n--r-.com', 46, '25fc0e7096fc653718202dc30b0c580b8ab87eac11a700cba03a7c021bc35b0c', '82841378928', 'f87017ff65ee8643a9c295d9675d7ce08072a365a5cf36bd1b80c357cecccd11', 5),
('Роберт ', 'Елисеев ', 'Яковлевич ', 5, '1511229633', 'dzhl.fnklsq@-d-s--.org', 47, '31489056e0916d59fe3add79e63f095af3ffb81604691f21cad442a85c7be617', '87755509613', 'bda56221611dc2b8d8d2ebf323f1931bcdc0e4e6a83131f76048c522ddbdff3b', 5),
('Богдан ', 'Данилов ', 'Дмитриевич ', 0, '1749601402', 'tisn@-tam-r.org', 48, '98010bd9270f9b100b6214a21754fd33bdc8d41b2bc9f9dd16ff54d3c34ffd71', '82534115488', '03d19c183907979a3ef92fbdf9d9658f87ad3241e0611f15f266bad60167f658', 5),
('Богдан ', 'Потапов ', 'Феликсович ', 0, '1699160642', 'fvvk@-l-fwi.org', 49, '0e17daca5f3e175f448bacace3bc0da47d0655a74c8dd0dc497a3afbdad95f1f', '88000529407', '7adeb6998c49f0099cb54993d8c263f5b3d491d22139ab8b26fe2f19629e6503', 5),
('Геннадий ', 'Артемьев ', 'Олегович ', 0, '1610305649', 'kllr2@--d---.org', 50, '1a6562590ef19d1045d06c4055742d38288e9e6dcd71ccde5cee80f1d5a774eb', '89242412578', '37dd2c8dd8a25d8989515f4acb765e6161bb2c8ebc95523b752060b822fd3fb8', 5),
('Аркадий', 'Авдеев ', 'Аркадьевич ', 0, '1177235381', 'hjir.warucf@qi---j.org', 51, '031b4af5197ec30a926f48cf40e11a7dbc470048a21e4003b7a3c07c5dab1baa', '82210474976', '2b60ef3379989afaec1a0cf529114d4a1cae244ceab76aea477c61309ade7c36', 5),
('Станислав ', 'Мясников ', 'Тарасович ', 5, '1817253963', 'ksnt978@---m-g.com', 52, '41cfc0d1f2d127b04555b7246d84019b4d27710a3f3aff6e7764375b1e06e05d', '83325137453', 'bbbc86882a3b77370ac2626491278a60529ce491d8c431ffd64b10a5058aaf12', 5),
('Савелий ', 'Белов ', 'Игоревич ', 7, '1444049771', 'wdjpo.tiov@-a--g-.org', 53, '2858dcd1057d3eae7f7d5f782167e24b61153c01551450a628cee722509f6529', '89994262643', '7076bafa28bc11d277ac27ffdeee6d0f8f83b65fc0c765b3f422da8577ac2933', 5),
('Даниил ', 'Беспалов ', 'Борисович ', 0, '1912387078', 'owel725@du--e-.net', 54, '2fca346db656187102ce806ac732e06a62df0dbb2829e511a770556d398e1a6e', '89995901166', '6cc143aed760c8978e7fd5f9696046b4c5d5ac53dfbdb8724fa8ec20d0475428', 5),
('Эрик ', 'Ефимов ', 'Михайлович ', 5, '1428531099', 'mshq9@----w-.com', 55, '02d20bbd7e394ad5999a4cebabac9619732c343a4cac99470c03e23ba2bdc2bc', '89996718206', '04bf85331aa5c197e0a83e99eb0c43cd27147cfc87ee54589337f5021c2b142f', 5),
('Геннадий ', 'Кондратьев ', 'Владиславович ', 0, '1412173630', 'qutbs6@-s-qxs.com', 56, '7688b6ef52555962d008fff894223582c484517cea7da49ee67800adc7fc8866', '89995887838', '984683a54caffa44c3c408729d223ebe2222092c92b60d195a7956d2ca99ee4f', 5),
('Тимофей ', 'Панфилов ', 'Васильевич ', 7, '1073385214', 'yymf@-l--h-.org', 57, 'c837649cce43f2729138e72cc315207057ac82599a59be72765a477f22d14a54', '89989284882', '11404d7fba0ae27ba74d26ddfb1a3a319f32e64cc6477bcbd175a4fc7a7ddd39', 5),
('Василий ', 'Федотов ', 'Денисович ', 0, '1780834856', 'nbim5@fzh---.com', 58, '6208ef0f7750c111548cf90b6ea1d0d0a66f6bff40dbef07cb45ec436263c7d6', '89958761204', 'e97eb66f207b36a1b8476a112418e6c577424d148a86ccf568fe355757c4657b', 5),
('Виктор ', 'Артемьев ', 'Станиславович ', 6, '1018978215', 'bivc.sfqvvvvrfk@r-y-wy.com', 59, '3e1e967e9b793e908f8eae83c74dba9bcccce6a5535b4b462bd9994537bfe15c', '89825951680', 'd3442222c73c25cc8825c64a1633798748ed478e4bb8edb9de64e81d83a0d2bf', 5),
('Густав ', 'Кошелев ', 'Андреевич ', 0, '1781560952', 'hkgj7@--nj-d.net', 60, '39fa9ec190eee7b6f4dff1100d6343e10918d044c75eac8f9e9a2596173f80c9', '89253475097', 'd050befe6a9b6d3635a3eaca6c63a798a194edbae5ee2c9d793e68ca27fa4a78', 5),
('Эдуард ', 'Григорьев ', 'Владимирович ', 7, '1233468046', 'ywnr351@-----w.net', 61, 'd029fa3a95e174a19934857f535eb9427d967218a36ea014b70ad704bc6c8d1c', '86789520752', '6a8ac03a5e1f88dc250a77faa6b6e666955b4f8ccc96926255cc816713eec4d8', 5),
('Кирилл ', 'Мишин ', 'Леонидович ', 0, '1752494323', 'evom@---twf.com', 62, '81b8a03f97e8787c53fe1a86bda042b6f0de9b0ec9c09357e107c99ba4d6948a', '86187178778', '98c34705a02e5e46078294029f74047426e46e2c0ee43d202f6213890d300096', 5),
('Вячеслав ', 'Кириллов ', 'Николаевич ', 0, '1315714390', 'brbu.nwbe@--obj-.com', 63, 'da4ea2a5506f2693eae190d9360a1f31793c98a1adade51d93533a6f520ace1c', '85673331939', '4e9278c04a37b8b423cc2287fffe5a9090ee3de6fdc522df17b139a7cdf78b0a', 5),
('Олег ', 'Жуков ', 'Валерьевич ', 1, '1489043403', 'lyvi.cgfa@------.net', 64, 'a68b412c4282555f15546cf6e1fc42893b7e07f271557ceb021821098dd66c1b', '84275123667', 'aaef490f54f0b38a17e3f7fbc99288b4fd8c1239e06271fbf3f020550f53443a', 5),
('Альберт ', 'Волков ', 'Валерьевич ', 0, '1316744444', 'lhwe@gobs--.net', 65, '108c995b953c8a35561103e2014cf828eb654a99e310f87fab94c2f4b7d2a04f', '89673622828', '2a140d8d82af947898cf65f0a39a4b258bbedef47af73b85d84cae68dc47ee90', 5),
('Никита ', 'Брагин ', 'Максимович ', 0, '1103898477', 'epvv@p-qe-m.net', 66, '3ada92f28b4ceda38562ebf047c6ff05400d4c572352a1142eedfef67d21e662', '85542743444', '616758847b251c58a10a92f423bf81e5e1b722d7af822c9d1a1256e481c8ff83', 5),
('Роман ', 'Медведев ', 'Аркадьевич ', 8, '1197022108', 'uqjj@-f--h-.net', 67, '49d180ecf56132819571bf39d9b7b342522a2ac6d23c1418d3338251bfe469c8', '88692849044', 'ee4bfbc9a002833344a7427b2563f3fa9bad7f7512236cf1cdde50532504a2bf', 5),
('Владислав ', 'Белов ', 'Андреевич ', 0, '1648148630', 'ervt78@-ubsgn.net', 68, 'a21855da08cb102d1d217c53dc5824a3a795c1c1a44e971bf01ab9da3a2acbbf', '86836015197', '2db1b643f2833a672b5aa4ac1bf02e259c769c48e3b6d361cf0a216c59a01a2c', 5),
('Владимир ', 'Носов ', 'Валентинович ', 0, '1630334136', 'gzqth38@w-v-md.org', 69, 'c75cb66ae28d8ebc6eded002c28a8ba0d06d3a78c6b5cbf9b2ade051f0775ac4', '88101529161', 'd055af0871befc38b002462dfe41636af7ba09784f4e56560a8501e397b9db93', 5),
('Михаил ', 'Блинов ', 'Петрович ', 0, '1683532047', 'xhbk52@h----r.org', 70, 'ff5a1ae012afa5d4c889c50ad427aaf545d31a4fac04ffc1c4d03d403ba4250a', '89999600518', 'e4696a5b3fd2b8afc614c5e515caf91e9f13c29aa3ac2577093d518406702b02', 5),
('Густав ', 'Ларионов ', 'Матвеевич ', 2, '1622382856', 'opap.isvuxxe@f-er--.net', 71, '7f2253d7e228b22a08bda1f09c516f6fead81df6536eb02fa991a34bb38d9be8', '85693415418', '0f68b393c1ca14c678405d674f0dca800a15735b92f79ba7edcc3b4b4229c4bc', 5),
('Мурат ', 'Максимов ', 'Юрьевич ', 0, '1511655265', 'lpcqp3@-kh---.org', 72, '8722616204217eddb39e7df969e0698aed8e599ba62ed2de1ce49b03ade0fede', '88468275842', '3e1f09bc3df892447c8d4ce4fa3e843c65e17b5efc202c18a81e37a2beae5af4', 5),
('Алексей ', 'Волков ', 'Анатольевич ', 0, '1392488729', 'ebth@guay.-lik--.org', 73, '96061e92f58e4bdcdee73df36183fe3ac64747c81c26f6c83aada8d2aabb1864', '85261133262', '56187618c27e4ab0e39586f790431a1ce830d1504f38a37eb7795d242853a15a', 5),
('Мурат ', 'Моисеев ', 'Анатольевич ', 0, '1822202360', 'lsylt5@-o-n--.com', 74, 'eb624dbe56eb6620ae62080c10a273cab73ae8eca98ab17b731446a31c79393a', '89008392093', '532e833a7c6cbb73d5d90d5defcdf66da3a70b64d617bfd4bd6f347bd958a887', 5),
('Василий ', 'Селиверстов ', 'Дмитриевич ', 0, '1873750747', 'hrdi.xegsq@alo--u.com', 75, 'f369cb89fc627e668987007d121ed1eacdc01db9e28f8bb26f358b7d8c4f08ac', '88720795986', '7c47744523fb807e48d080b98dc006964ac4c7dbb8cb87b6ef961cd44dfeaa3a', 5),
('Павел ', 'Евдокимов ', 'Георгиевич ', 0, '1978912646', 'fxoz@j-----.net', 76, 'f74efabef12ea619e30b79bddef89cffa9dda494761681ca862cff2871a85980', '89014622958', '93c22a572ad6207e698db1b5f90c46d58b17dd78343a9f0889d0fcd320caef90', 5),
('Марат ', 'Владимиров ', 'Игоревич ', 1, '2073399239', 'dzyd24@uv-ci-.com', 77, 'a88a7902cb4ef697ba0b6759c50e8c10297ff58f942243de19b984841bfe1f73', '88344927140', '372015fd8e173344ea9b2e11d136a171949fd79ce3f21123045118ab5f0ce5dc', 5),
('Илья ', 'Сергеев ', 'Игоревич ', 0, '1914905820', 'bypa.fhbx@--g--c.net', 78, '349c41201b62db851192665c504b350ff98c6b45fb62a8a2161f78b6534d8de9', '89020247133', '182527cea58b5f2884a352562589051f6c90c886ed072c75c873f9e5f7bf0b4b', 5),
('Мурат ', 'Михайлов ', 'Викторович ', 0, '1255571006', 'pogq9@-j----.com', 79, '98a3ab7c340e8a033e7b37b6ef9428751581760af67bbab2b9e05d4964a8874a', '86645454550', '7a1e3d32490f87446047de4b4fe4e5a54ab2a29f517a89a8107cce4444963a84', 5),
('Артур ', 'Суворов ', 'Матвеевич ', 0, '1540203401', 'gouxcu9@----v-.net', 80, '48449a14a4ff7d79bb7a1b6f3d488eba397c36ef25634c111b49baf362511afc', '83271531661', '14941a0b11dfdf133604e17daf6effad39ea537a885283e90aef6bd99e5bd6c6', 5),
('Павел ', 'Князев ', 'Сергеевич ', 0, '1629054277', 'iqup.jdrcwlfy@-pjxud.com', 81, '5316ca1c5ddca8e6ceccfce58f3b8540e540ee22f6180fb89492904051b3d531', '86158294963', 'da6b2e8522c58fce8f55276831df0aa24908fa35fa7d17921f3034452c7ebaad', 5),
('Герман ', 'Герасимов ', 'Данилович ', 12, '2009225826', 'vqpc713@w-x-xi.com', 82, 'a46e37632fa6ca51a13fe39a567b3c23b28c2f47d8af6be9bd63e030e214ba38', '89768870138', '31b1a5a76a7b142d46f45b89512bcabf5ff5beca524517e07473e95421ad9cd3', 5),
('Мурат ', 'Савельев ', 'Тарасович ', 0, '1431617921', 'kdki2@--h--e.com', 83, 'bbb965ab0c80d6538cf2184babad2a564a010376712012bd07b0af92dcd3097d', '86409516108', '25bca41f0033d800efc6bd270e066758f5b0334590cb82cd98484a0becb1f3c9', 5),
('Савелий ', 'Беляков ', 'Андреевич ', 7, '1732115562', 'rhkb.xmpr@qw--m-.com', 84, '44c8031cb036a7350d8b9b8603af662a4b9cdbd2f96e8d5de5af435c9c35da69', '89116940432', '966f68af971e1fb40caa0d9af64b6090271d17206d8981f5a82878bc86434fdf', 5),
('Эрик ', 'Дроздов ', 'Романович ', 5, '1889819795', 'aefd3@-f-s-b.net', 85, 'b4944c6ff08dc6f43da2e9c824669b7d927dd1fa976fadc7b456881f51bf5ccc', '86356154146', '3b3560a6e34a77b2ccdca100b0eac81a44dcd961fd5d4a8ea4144141621e8925', 5),
('Виталий ', 'Блинов ', 'Семенович ', 0, '1826683936', 'soqw@---zyh.net', 86, '434c9b5ae514646bbd91b50032ca579efec8f22bf0b4aac12e65997c418e0dd6', '84429949740', '58a8b04852151aabbd7cdf8b58739e09ca312734249458de4c53d4e77fea0d1e', 5),
('Ринат ', 'Мамонтов ', 'Артемович ', 8, '1725207540', 'sehw.ebgcxvq@w-----.net', 87, 'bdd2d3af3a5a1213497d4f1f7bfcda898274fe9cb5401bbc0190885664708fc2', '83081286571', '127abdf7c7fca546fe3b3d10ec230fa8b0414482812c44ca55db71c6c50b11c7', 5),
('Олег ', 'Маслов ', 'Павлович ', 0, '1569363827', 'wyzv@m--ijb.net', 88, '8b940be7fb78aaa6b6567dd7a3987996947460df1c668e698eb92ca77e425349', '82116583942', 'cf8db2fc2880eaaf6fbd30bda246121b0a1d7ee41e986bcdca2c51e26e2a3465', 5),
('Аркадий', 'Мухин ', 'Тимофеевич ', 0, '1919989645', 'djcg.qkou@x--b-e.org', 89, 'cd70bea023f752a0564abb6ed08d42c1440f2e33e29914e55e0be1595e24f45a', '81339060302', '6f0d68078394b6048b817cfaedb0ad0316bcc4573cef92677d8f159ddd3bac1b', 5),
('Ярослав ', 'Шашков ', 'Феликсович ', 2, '1402284007', 'ubwe@c--nx-.com', 90, '69f59c273b6e669ac32a6dd5e1b2cb63333d8b004f9696447aee2d422ce63763', '83455649994', 'b957d51973ef5d5e42786c1c5bf3e4d21aad692adb2278411321010f4aa17c53', 5),
('Дмитрий ', 'Емельянов ', 'Владимирович ', 0, '1928281372', 'nuot01@un-e--.com', 91, '1da51b8d8ff98f6a48f80ae79fe3ca6c26e1abb7b7d125259255d6d2b875ea08', '87710569368', '8c169841362ffd4188072d4b4599324ff43bcada2e640cf78762b92f4b706d89', 5),
('Матвей ', 'Рыбаков ', 'Артемович ', 0, '1206844908', 'ivvc@--tr-q.net', 92, '8241649609f88ccd2a0a5b233a07a538ec313ff6adf695aa44a969dbca39f67d', '87516197169', 'd058e63ff1fe846dec2076a544ed74cdb2e59d109bd0188798b8a1f9ada9ac79', 5),
('Михаил ', 'Евдокимов ', 'Данилович ', 0, '2043643431', 'mqlh500@b-e-am.com', 93, '6e4001871c0cf27c7634ef1dc478408f642410fd3a444e2a88e301f5c4a35a4d', '84449278046', '847c159cf56c7980d0e9cc7d06efb4d4461c12f946ecdcdfe1a13790ff517163', 5),
('Леонид ', 'Жуков ', 'Иосифович ', 0, '1556445681', 'ldtu@--cus-.com', 94, 'e3d6c4d4599e00882384ca981ee287ed961fa5f3828e2adb5e9ea890ab0d0525', '89697799030', '60afd2708ae43905b80c2ca5894fe98b20074672540ed27a3e0de6f256bc2797', 5),
('Эрик ', 'Гурьев ', 'Львович ', 3, '1534460722', 'pfsq@d--p-o.net', 95, 'ad48ff99415b2f007dc35b7eb553fd1eb35ebfa2f2f308acd9488eeb86f71fa8', '85141161322', '8f8d7271381e7064191cbb6d5fafcfe36d76fde84e3e584fb51da8edddb3c0fa', 5),
('Николай ', 'Смирнов', 'Феликсович ', 0, '1247169706', 'huvr23@--gno-.org', 96, '7b1a278f5abe8e9da907fc9c29dfd432d60dc76e17b0fabab659d2a508bc65c4', '86612409825', 'a1d22dda463a70626d75d977240024255dde54a30a07d01dc4a05e80031dcf4b', 5),
('Константин ', 'Александров ', 'Тарасович ', 1, '1393106530', 'gtlq.gvkwj@-o----.net', 97, 'd6d824abba4afde81129c71dea75b8100e96338da5f416d2f69088f1960cb091', '87638565467', '299a3f77dc80e534c3042a5fa35bb3e83eacc996152fe72b07178f0ea7b84e4f', 5),
('Вячеслав ', 'Большаков ', 'Викторович ', 0, '1313298365', 'kzcv@t-b--u.com', 98, '29db0c6782dbd5000559ef4d9e953e300e2b479eed26d887ef3f92b921c06a67', '88355598169', '7584332197718a1275d789d009151416c2e90bf439b528ede2cdc9ad32a14690', 5),
('Станислав ', 'Шарапов ', 'Владимирович ', 8, '1787607533', 'syjs.gxdzj@x-kimt.net', 99, '8c1f1046219ddd216a023f792356ddf127fce372a72ec9b4cdac989ee5b0b455', '88862294749', 'dc6fb62cf631afabdd40116d6c025810298b839df868506f3776973ec3233aca', 5),
('Марсель ', 'Медведев ', 'Георгиевич ', 0, '1188589857', 'txmbp571@b-l--i.com', 100, 'ad57366865126e55649ecb23ae1d48887544976efea46a48eb5d85a6eeb4d306', '89244679547', '037eb2546a73fd7ad47837ded8bb67e321417f73cf109eec8d9541edf2f77965', 5),
('Олег', 'Костоломов', 'Александрович', 0, '4562456989', 'kola@melk.su', 101, '16dc368a89b428b2485484313ba67a3912ca03f2b2b42429174a4f8b3dc84e44', '89244679762', '9aa8a5086d86936ae6b036a6ffff787584b3d8303950e74ea95ec3ac7419a9f5', 5),
('Иван', 'Ломоносов', 'Васиьевич', 0, '483276540092', 'kremen@fig.lo', 102, '37834f2f25762f23e1f74a531cbe445db73d6765ebe60878a7dfbecd7d4af6e1', '89501235544', 'c03c8946d1d8e9ce7a77e075537f8c10f8789bf4e13cc81d7bc3d9df43697a6d', 5),
('Акакий', 'Стругацкий', 'Владиславович', 0, '9874321765', 'topmop@vs.mu', 103, '454f63ac30c8322997ef025edff6abd23e0dbe7b8a3d5126a894e4a168c1b59b', '89087654321', '47b7b8ab8d214a15161b3971bb23d2930d821905d690458b8403004455c4053b', 5),
('Володя', 'Вышнеградский', 'Антонович', 0, '9874321776', 'svet@me.mu', 104, '5ef6fdf32513aa7cd11f72beccf132b9224d33f271471fff402742887a171edf', '89087654332', '85dc2d30451f2314f47505ae4a5ba6704c3455aa8ef40016d5f48f9c01673c86', 5),
('Гвен', 'Стейси', 'Иванова', 15, '4562456333', 'vsenalevo@me.vs', 105, '1253e9373e781b7500266caa55150e08e210bc8cd8cc70d89985e3600155e860', '89087654388', '363cbbd7fa5b5584b700ece5ea2dc991993a0b41becfbabc7c6ff58daf600854', 5),
('Питер', 'Паркер', 'Вячеславович', 9, '8769776324', 'peter@fne.co', 106, '482d9673cfee5de391f97fde4d1c84f9f8d6f2cf0784fcffb958b4032de7236c', '87965432216', 'f1ce4b4abe7f10daa9cd3b958f33bddfc4ccd9b5992e22b0b6f77f558ac5156a', 5);

-- 
-- Вывод данных для таблицы street
--
INSERT INTO street VALUES
(720, ''),
(401, '1-го Мая '),
(1, 'Абросимова '),
(2, 'Авангардная '),
(3, 'Авиационная '),
(385, 'Аврова '),
(4, 'Автобусная '),
(5, 'Автовская '),
(6, 'Автомобильная '),
(7, 'Академика Байкова '),
(427, 'Академика Комарова '),
(8, 'Академика Константинова '),
(9, 'Академика Крылова '),
(10, 'Академика Лебедева '),
(11, 'Академика Павлова '),
(12, 'Академика Шиманского '),
(13, 'Аккуратова '),
(14, 'Александра Блока '),
(15, 'Александра Матросова '),
(16, 'Александра Невского '),
(407, 'Александра Попова '),
(17, 'Александра Ульянова '),
(18, 'Александровская '),
(408, 'Алексея Лебедева '),
(545, 'Алтайская '),
(409, 'Аммермана '),
(546, 'Амурская '),
(465, 'Андреева '),
(410, 'Андреевская '),
(547, 'Антонова-Овсеенко '),
(548, 'Антоновская '),
(549, 'Апрельская '),
(550, 'Арктическая '),
(551, 'Арсенальная '),
(430, 'Артиллерийская '),
(431, 'Архитектора Данини '),
(552, 'Асафьева '),
(553, 'Астраханская '),
(554, 'Атаманская '),
(555, 'Афанасьевская '),
(556, 'Афонская '),
(432, 'Ахматовская '),
(557, 'Аэродромная '),
(19, 'Бабушкина '),
(20, 'Бадаева '),
(494, 'Байкальская '),
(21, 'Байконурская '),
(22, 'Балтийская '),
(23, 'Барклаевская '),
(24, 'Бармалеева '),
(25, 'Барочная '),
(26, 'Баррикадная '),
(27, 'Бассейная '),
(28, 'Белградская '),
(29, 'Белинского '),
(30, 'Беломорская '),
(31, 'Белоостровская '),
(32, 'Белорусская '),
(33, 'Белоусова '),
(34, 'Белы Куна '),
(35, 'Белышева '),
(36, 'Береговая '),
(37, 'Березовая '),
(38, 'Беринга '),
(39, 'Бестужевская '),
(40, 'Бехтерева '),
(41, 'Благодатная '),
(42, 'Благоева '),
(43, 'Блохина '),
(44, 'Бобруйская '),
(455, 'Богумиловская '),
(558, 'Бокситогорская '),
(559, 'Болотная '),
(519, 'Большая '),
(466, 'Большая Горская '),
(560, 'Большая Десятинная '),
(561, 'Большая Зеленина '),
(562, 'Большая Конюшенная '),
(563, 'Большая Монетная '),
(564, 'Большая Морская '),
(565, 'Большая Московская '),
(566, 'Большая Подьяческая '),
(567, 'Большая Пороховская '),
(568, 'Большая Посадская '),
(569, 'Большая Пушкарская '),
(570, 'Большая Разночинная '),
(411, 'Большевистская '),
(571, 'Бонч-Бруевича '),
(467, 'Борисова '),
(497, 'Боровая '),
(572, 'Бородинская '),
(386, 'Ботаническая '),
(573, 'Боткинская '),
(574, 'Братская '),
(387, 'Братьев Горкушенко '),
(507, 'Братьев Радченко '),
(575, 'Броневая '),
(522, 'Бронетанковая '),
(576, 'Бронницкая '),
(577, 'Брюсовская '),
(578, 'Брянцева '),
(579, 'Будапештская '),
(580, 'Булавского '),
(581, 'Бумажная '),
(582, 'Буренина '),
(583, 'Бурцева '),
(584, 'Бутлерова '),
(585, 'Бухарестская '),
(508, 'Вавилова '),
(45, 'Вавиловых '),
(46, 'Вакуленчука '),
(47, 'Валерия Гаврилина '),
(48, 'Ванеева '),
(49, 'Варваринская '),
(50, 'Варфоломеевская '),
(51, 'Варшавская '),
(52, 'Васенко '),
(53, 'Васи Алексеева '),
(54, 'Васильковая '),
(55, 'Ватутина '),
(56, 'Введенская '),
(57, 'Введенского канала '),
(58, 'Веденеева '),
(721, 'Веерштрасса'),
(412, 'Велещинского '),
(59, 'Вербная '),
(60, 'Верейская '),
(61, 'Верности '),
(62, 'Верхняя '),
(530, 'Верхняя Ижорская '),
(509, 'Веры Слуцкой '),
(63, 'Веры Фигнер '),
(64, 'Весенняя '),
(413, 'Викторская '),
(65, 'Виндавская '),
(66, 'Витебская '),
(67, 'Витебская-Сортировочная '),
(414, 'Владимирская '),
(586, 'Внуковская '),
(498, 'Военная '),
(587, 'Воздухоплавательная '),
(588, 'Возрождения '),
(433, 'Вокзальная '),
(388, 'Волконская '),
(589, 'Вологдина '),
(415, 'Володарского '),
(389, 'Володи Дубинина '),
(590, 'Володи Ермака '),
(390, 'Воровского '),
(591, 'Воронежская '),
(592, 'Ворошилова '),
(468, 'Воскова '),
(416, 'Восстания '),
(523, 'Восстановления '),
(417, 'Всеволода Вишневского '),
(593, 'Всеволожская '),
(450, 'Выборгская '),
(499, 'Высокая '),
(512, 'Выставочная '),
(594, 'Вязовая '),
(434, 'Вячеслава Шишкова '),
(451, 'Гаванная '),
(68, 'Гаванская '),
(69, 'Гаврская '),
(70, 'Гагаринская '),
(71, 'Газовая '),
(418, 'Газовый Завод '),
(72, 'Гаккелевская '),
(73, 'Галерная '),
(74, 'Галстяна '),
(75, 'Гангутская '),
(76, 'Гапсальская '),
(77, 'Гастелло '),
(78, 'Гатчинская '),
(524, 'Гвардейская '),
(79, 'Гданьская '),
(80, 'Гдовская '),
(81, 'Гельсингфорская '),
(82, 'Генерала Лагуткина '),
(83, 'Генерала Симоняка '),
(435, 'Генерала Хазова '),
(525, 'Геологическая '),
(84, 'Герасимовская '),
(85, 'Гжатская '),
(86, 'Гидростроителей '),
(87, 'Гидротехников '),
(88, 'Главная '),
(89, 'Гладкова '),
(90, 'Глазурная '),
(91, 'Глеба Успенского '),
(92, 'Глинки '),
(93, 'Глиняная '),
(500, 'Глухариная '),
(595, 'Глухарская '),
(596, 'Глухая Зеленина '),
(513, 'Гоголя '),
(495, 'Голицынская '),
(597, 'Гончарная '),
(526, 'Горбунова '),
(428, 'Горная '),
(598, 'Гороховая '),
(535, 'Горская '),
(483, 'Горького '),
(436, 'Госпитальная '),
(391, 'Гостилицкая '),
(452, 'Гостиная '),
(392, 'Гофмейстерская '),
(393, 'Гражданская '),
(599, 'Гранитная '),
(531, 'Граничная '),
(600, 'Графова '),
(601, 'Графтио '),
(602, 'Гренадерская '),
(603, 'Грибакиных '),
(604, 'Грибалевой '),
(469, 'Григорьева '),
(605, 'Громова '),
(606, 'Грота '),
(607, 'Грузинская '),
(510, 'Губина '),
(484, 'Гуммолосаровская '),
(437, 'Гусарская '),
(419, 'Гусева '),
(94, 'Даля '),
(521, 'Дачная '),
(95, 'Двинская '),
(438, 'Дворцовая '),
(96, 'Дегтярная '),
(97, 'Декабристов '),
(501, 'Деловая '),
(98, 'Демьяна Бедного '),
(99, 'Депутатская '),
(100, 'Дерновая '),
(101, 'Десантников '),
(102, 'Детская '),
(485, 'Детскосельская '),
(103, 'Джона Рида '),
(104, 'Диагональная '),
(105, 'Дибуновская '),
(608, 'Дивенская '),
(609, 'Димитрова '),
(610, 'Динамовская '),
(502, 'Дмитриевская '),
(611, 'Дмитрия Устинова '),
(612, 'Днепропетровская '),
(613, 'Доблести '),
(614, 'Добровольцев '),
(615, 'Долгоозерная '),
(616, 'Домостроительная '),
(496, 'Донецкая '),
(617, 'Донская '),
(618, 'Достоевского '),
(619, 'Дрезденская '),
(620, 'Дровяная '),
(621, 'Дубровская '),
(503, 'Дуговая '),
(622, 'Дудко '),
(623, 'Думская '),
(624, 'Дыбенко '),
(106, 'Евгеньевская '),
(107, 'Евдокима Огнева '),
(108, 'Егорова '),
(486, 'Екатерининская '),
(109, 'Еленинская '),
(625, 'Елецкая '),
(487, 'Елизаветинская '),
(626, 'Елисеевская '),
(627, 'Ельнинская '),
(470, 'Емельянова '),
(628, 'Енотаевская '),
(629, 'Есенина '),
(630, 'Ефимова '),
(110, 'Жака Дюкло '),
(111, 'Ждановская '),
(112, 'Железноводская '),
(113, 'Железнодорожная '),
(488, 'Желябова '),
(536, 'Жоры Антоненко '),
(631, 'Жукова '),
(439, 'Жуковско-Волынская '),
(632, 'Жуковского '),
(114, 'Забайкальская '),
(115, 'Заводская '),
(456, 'Загородная '),
(116, 'Задворная '),
(117, 'Зайцева '),
(118, 'Замшина '),
(119, 'Заозерная '),
(120, 'Заповедная '),
(121, 'Запорожская '),
(122, 'Заречная '),
(123, 'Зарубинская '),
(124, 'Заславская '),
(125, 'Заставская '),
(126, 'Заусадебная '),
(440, 'Захаржевская '),
(127, 'Захарьевская '),
(633, 'Звездная '),
(634, 'Звенигородская '),
(489, 'Звериницкая '),
(635, 'Зверинская '),
(457, 'Зеленая '),
(636, 'Зеленогорская '),
(637, 'Земледельческая '),
(638, 'Зенитчиков '),
(639, 'Зины Портновой '),
(394, 'Знаменская '),
(640, 'Зодчего Росси '),
(641, 'Зои Космодемьянской '),
(395, 'Золотая '),
(642, 'Зольная '),
(471, 'Зоологическая '),
(420, 'Зосимова '),
(643, 'Зубковская '),
(128, 'Ивана Фомина '),
(129, 'Ивана Черных '),
(130, 'Ивановская '),
(131, 'Ижорская '),
(132, 'Ильинская слобода '),
(421, 'Ильмянинова '),
(133, 'Ильюшина '),
(134, 'Инженерная '),
(644, 'Инструментальная '),
(422, 'Интернациональная '),
(453, 'Исполкомская '),
(645, 'Итальянская '),
(135, 'Кавалергардская '),
(429, 'Кавалерийская '),
(136, 'Казанская '),
(137, 'Казначейская '),
(138, 'Калинина '),
(396, 'Калининская '),
(139, 'Калязинская '),
(140, 'Камская '),
(141, 'Камчатская '),
(142, 'Камышинская '),
(143, 'Канареечная '),
(144, 'Канатная '),
(145, 'Канонерская '),
(146, 'Кантемировская '),
(147, 'Капитана Воронина '),
(148, 'Капитанская '),
(149, 'Караваевская '),
(150, 'Караванная '),
(151, 'Карбышева '),
(423, 'Карла Либкнехта '),
(424, 'Карла Маркса '),
(152, 'Карпинского '),
(153, 'Карташихина '),
(154, 'Карьерная '),
(155, 'Касимовская '),
(472, 'Каугиевская '),
(441, 'Кедринская '),
(156, 'Кемская '),
(157, 'Кибальчича '),
(158, 'Киевская '),
(537, 'Кипренского '),
(159, 'Кирилловская '),
(160, 'Киришская '),
(161, 'Кирочная '),
(162, 'Кленовая '),
(533, 'Клин '),
(163, 'Клиническая '),
(538, 'Ключевая '),
(164, 'Книпович '),
(165, 'Кокколевская '),
(166, 'Коли Томчака '),
(167, 'Коллонтай '),
(532, 'Колодезная '),
(168, 'Колокольная '),
(169, 'Коломенская '),
(170, 'Колпинская '),
(447, 'Колхозная '),
(171, 'Кольская '),
(504, 'Кольцевая '),
(172, 'Кольцова '),
(173, 'Комарова '),
(454, 'Комендантская '),
(174, 'Комиссара Смирнова '),
(473, 'Коммунаров '),
(425, 'Коммунистическая '),
(175, 'Коммуны '),
(176, 'Композиторов '),
(177, 'Комсомола '),
(442, 'Комсомольская '),
(178, 'Конная '),
(397, 'Конно-Гренадерская '),
(179, 'Константина Заслонова '),
(398, 'Константиновская '),
(180, 'Конторская '),
(443, 'Конюшенная '),
(646, 'Кооперативная '),
(647, 'Корабельная '),
(648, 'Кораблестроителей '),
(649, 'Корнеева '),
(474, 'Коробицына '),
(650, 'Короленко '),
(505, 'Короткая '),
(651, 'Корпусная '),
(652, 'Корякова '),
(511, 'Косинова '),
(653, 'Костромская '),
(458, 'Костылева '),
(654, 'Костюшко '),
(655, 'Котина '),
(656, 'Котовского '),
(534, 'Красина '),
(426, 'Красная '),
(459, 'Красноармейская '),
(490, 'Красногвардейская '),
(491, 'Красного Курсанта '),
(657, 'Красного Текстильщика '),
(460, 'Красного Флота '),
(527, 'Красногородская '),
(658, 'Краснодонская '),
(444, 'Красной Звезды '),
(461, 'Краснопрудская '),
(659, 'Краснопутиловская '),
(660, 'Красносельская '),
(448, 'Красных Партизан '),
(661, 'Красуцкого '),
(662, 'Крашенинникова '),
(663, 'Кременчугская '),
(664, 'Кронверкская '),
(462, 'Кронштадтская '),
(665, 'Кропоткина '),
(514, 'Кропоткинская '),
(449, 'Круговая '),
(666, 'Крупской '),
(667, 'Крыленко '),
(668, 'Крюкова '),
(669, 'Кубинская '),
(670, 'Кузнецова '),
(671, 'Кузнецовская '),
(672, 'Куйбышева '),
(673, 'Купчинская '),
(674, 'Курляндская '),
(475, 'Курортная '),
(675, 'Курская '),
(676, 'Курчатова '),
(677, 'Кустодиева '),
(181, 'Лабораторная '),
(182, 'Лабутина '),
(183, 'Лагерная '),
(184, 'Лагоды '),
(185, 'Лазо '),
(186, 'Ланская '),
(187, 'Латышских Стрелков '),
(188, 'Лахтинская '),
(492, 'Лебединая '),
(463, 'Левитана '),
(189, 'Лени Голикова '),
(190, 'Ленина '),
(445, 'Ленинградская '),
(191, 'Ленская '),
(192, 'Ленсовета '),
(399, 'Леонтьевская '),
(528, 'Лермонтова '),
(476, 'Лесная '),
(193, 'Леснозаводская '),
(194, 'Лесопарковая '),
(195, 'Лизы Чайкиной '),
(678, 'Лисичанская '),
(477, 'Лиственная '),
(679, 'Литераторов '),
(680, 'Литовская '),
(681, 'Лифляндская '),
(400, 'Лихардовская '),
(682, 'Лодейнопольская '),
(515, 'Лодыгина '),
(683, 'Ломаная '),
(684, 'Ломовская '),
(446, 'Ломоносова '),
(685, 'Лоцманская '),
(686, 'Луговая'),
(687, 'Лужская '),
(493, 'Луначарского '),
(688, 'Льва Толстого '),
(516, 'Львовская '),
(196, 'Магнитогорская '),
(478, 'Максима Горького '),
(197, 'Малая Балканская '),
(198, 'Малая Бухарестская '),
(479, 'Малая Горская '),
(199, 'Малая Гребецкая '),
(200, 'Малая Десятинная '),
(201, 'Малая Зеленина '),
(480, 'Малая Канонерская '),
(202, 'Малая Карпатская '),
(203, 'Малая Конюшенная '),
(481, 'Малая Ленинградская '),
(204, 'Малая Митрофаньевская '),
(205, 'Малая Монетная '),
(206, 'Малая Морская '),
(207, 'Малая Московская '),
(208, 'Малая Подьяческая '),
(209, 'Малая Посадская '),
(210, 'Малая Пушкарская '),
(211, 'Малая Разночинная '),
(212, 'Малая Садовая '),
(213, 'Малыгина '),
(464, 'Манежная '),
(214, 'Манчестерская '),
(215, 'Марата '),
(216, 'Мариинская '),
(217, 'Маринеско '),
(218, 'Маркина '),
(219, 'Мартыновская '),
(220, 'Маршала Говорова '),
(221, 'Маршала Захарова '),
(222, 'Маршала Казакова '),
(223, 'Маршала Новикова '),
(224, 'Маршала Тухачевского '),
(529, 'Массальского '),
(225, 'Мастерская '),
(226, 'Матроса Железняка '),
(227, 'Матюшенко '),
(228, 'Маяковского '),
(229, 'Мгинская '),
(230, 'Мебельная '),
(506, 'Межевая '),
(689, 'Межевой Канал '),
(402, 'Мельничная '),
(403, 'Менделеевская '),
(690, 'Металлистов '),
(691, 'Метростроевцев '),
(404, 'Мечникова '),
(692, 'Мигуновская '),
(693, 'Миллионная '),
(694, 'Минеральная '),
(695, 'Мира '),
(696, 'Миргородская '),
(697, 'Миронова '),
(698, 'Михаила Дудина '),
(699, 'Михайлова '),
(405, 'Михайловская '),
(700, 'Мичманская '),
(701, 'Мичуринская '),
(702, 'Можайская '),
(703, 'Моисеенко '),
(704, 'Молдагуловой '),
(705, 'Мончегорская '),
(482, 'Морская '),
(406, 'Морского Десанта '),
(706, 'Моховая '),
(707, 'Мытнинская '),
(708, 'Мясная '),
(541, 'Набережная '),
(517, 'Нагорная '),
(231, 'Наличная '),
(232, 'Народная '),
(233, 'Науки '),
(234, 'Нахимова '),
(235, 'Невельская '),
(236, 'Невзоровой '),
(237, 'Нежинская '),
(238, 'Некрасова '),
(239, 'Нижне-Каменская '),
(539, 'Нижняя '),
(518, 'Нижняя Колония '),
(240, 'Николая Рубцова '),
(241, 'Никольская '),
(542, 'Новая '),
(242, 'Новгородская '),
(709, 'Ново-Александровская '),
(710, 'Ново-Рыбинская '),
(520, 'Нововестинская '),
(711, 'Новоладожская '),
(712, 'Новолитовская '),
(713, 'Новоовсянниковская '),
(714, 'Новоорловская '),
(715, 'Новороссийская '),
(716, 'Новорощинская '),
(717, 'Новосельковская '),
(718, 'Новосибирская '),
(540, 'Новостроек '),
(719, 'Новоутиная '),
(243, 'Оборонная '),
(244, 'Обручевых '),
(245, 'Одесская '),
(246, 'Одоевского '),
(247, 'Окраинная '),
(248, 'Олеко Дундича '),
(249, 'Олонецкая '),
(250, 'Ольги Берггольц '),
(251, 'Ольги Форш '),
(252, 'Ольгина '),
(253, 'Панфилова '),
(254, 'Парадная '),
(255, 'Парашютная '),
(256, 'Парголовская '),
(257, 'Парковая '),
(258, 'Парнасная '),
(259, 'Партизана Германа '),
(260, 'Партизанская '),
(261, 'Парусная '),
(262, 'Пасторова '),
(263, 'Пеньковая '),
(264, 'Первомайская '),
(265, 'Перевозная '),
(266, 'Передовиков '),
(267, 'Перекопская '),
(268, 'Перфильева '),
(269, 'Пестеля '),
(270, 'Петроградская '),
(271, 'Петродворцовая '),
(272, 'Петрозаводская '),
(273, 'Петропавловская '),
(274, 'Печатника Григорьева '),
(275, 'Пилотная '),
(276, 'Пилотов '),
(277, 'Пинегина '),
(278, 'Пионерская '),
(279, 'Пионерстроя '),
(280, 'Писарева '),
(281, 'Планерная '),
(282, 'Плуталова '),
(283, 'Победы '),
(284, 'Пограничника Гарькавого '),
(285, 'Подвойского '),
(286, 'Подковырова '),
(287, 'Подольская '),
(288, 'Подрезова '),
(543, 'Полевая '),
(731, 'Просвещения'),
(289, 'Рабфаковская '),
(290, 'Радищева '),
(291, 'Разъезжая '),
(292, 'Ракитовская '),
(293, 'Расстанная '),
(294, 'Рашетова '),
(295, 'Резная '),
(296, 'Ремесленная '),
(297, 'Рентгена '),
(298, 'Репина '),
(299, 'Репищева '),
(300, 'Республиканская '),
(301, 'Решетникова '),
(302, 'Ржевская '),
(303, 'Сабировская '),
(304, 'Саблинская '),
(305, 'Савиной '),
(306, 'Савушкина '),
(307, 'Садовая '),
(308, 'Салова '),
(309, 'Самойловой '),
(310, 'Сантьяго-де-Куба '),
(311, 'Саратовская '),
(312, 'Свеаборгская '),
(313, 'Севастопольская '),
(314, 'Севастьянова '),
(315, 'Седова '),
(316, 'Сергея Марго '),
(317, 'Сердобольская '),
(318, 'Серпуховская '),
(319, 'Сестрорецкая '),
(320, 'Сибирская '),
(321, 'Сикейроса '),
(322, 'Симонова '),
(323, 'Синявинская '),
(324, 'Складская '),
(325, 'Скобелевская '),
(326, 'Славянская '),
(327, 'Слободская '),
(328, 'Смоленская '),
(329, 'Смольного '),
(330, 'Смолячкова '),
(331, 'Таврическая '),
(332, 'Таллинская '),
(333, 'Тамбасова '),
(334, 'Тамбовская '),
(335, 'Танкиста Хрустицкого '),
(336, 'Тарасова '),
(337, 'Ташкентская '),
(338, 'Тбилисская '),
(339, 'Тверская '),
(340, 'Тележная '),
(341, 'Тельмана '),
(342, 'Тепловозная '),
(343, 'Тимуровская '),
(344, 'Типанова '),
(345, 'Тифлисская '),
(346, 'Тихомировская '),
(347, 'Ткачей '),
(348, 'Уральская '),
(349, 'Фарфоровская '),
(350, 'Федеративная '),
(351, 'Федора Абрамова '),
(352, 'Федоровская '),
(353, 'Феодосийская '),
(354, 'Харченко '),
(355, 'Харьковская '),
(356, 'Хасанская '),
(734, 'Хашемина'),
(357, 'Херсонская '),
(358, 'Химиков '),
(359, 'Цветочная '),
(544, 'Центральная '),
(360, 'Чайковского '),
(361, 'Чапаева '),
(362, 'Чапыгина '),
(363, 'Чекистов '),
(364, 'Челябинская '),
(365, 'Червонного Казачества '),
(366, 'Черкасова '),
(367, 'Черниговская '),
(368, 'Чернова '),
(369, 'Шаврова '),
(370, 'Шамшева '),
(371, 'Шарова '),
(372, 'Шателена '),
(373, 'Швецова '),
(374, 'Шевченко '),
(375, 'Шелгунова '),
(376, 'Шепетовская '),
(377, 'Шереметьевская '),
(378, 'Электропультовцев '),
(379, 'Эммануиловская '),
(380, 'Южная '),
(381, 'Яблочкова '),
(382, 'Якорная '),
(383, 'Якубовича '),
(384, 'Ялтинская ');

-- 
-- Вывод данных для таблицы type
--
INSERT INTO type VALUES
(1, 'Дача'),
(2, 'Квартира');

-- 
-- Вывод данных для таблицы settling
--
INSERT INTO settling VALUES
(1, 'Санкт-Петербург', 1),
(2, 'Москва', 1),
(3, 'Екатеринбург', 1),
(4, 'Калининград', 1),
(5, 'Астана ', 1),
(6, 'Подольск', 1),
(7, 'Оредеж', 3),
(8, 'Новые Дубки', 2),
(9, 'Мга', 2),
(10, 'Павлово', 3),
(11, '', 1),
(12, 'Новгород', 1);

-- 
-- Вывод данных для таблицы firm
--
INSERT INTO firm VALUES
(1, '5404042858231676', 1, 97, 3, 1, 'Мердок и сыновья');

-- 
-- Вывод данных для таблицы object
--
INSERT INTO object VALUES
(1, 52, 52, 'Агария', 7575485.00, 1, 5, 2, '2014-05-20 00:00:00', 'Идеальное место для отдыха от городской суеты! Умиротворяющий панорамный вид на горы. Недалеко чайные плантации, родник с чистой горной водой. Абсолютная тишина, только пение птиц и шелест ', 83, 695, 13, 1, 2, 1),
(2, 64, 17, 'Лазурная Обь', 9267464.00, 2, 5, 2, '2013-07-31 00:00:00', 'На территории есть сад с плодовыми деревьями, небольшой дом (можно спокойно заезжать и жить). Все коммуникации, полный пакет документов. Участок находится возле асфальтированной дороги', 86, 395, 14, 1, 1, 1),
(3, 45, 59, 'Солнечная горка', 7116014.00, 3, 2, 1, '2010-02-03 00:00:00', 'На участке трехэтажный дачный дом, который представляет собой: первый уровень - кухня, кладовая, подсобное посещение; второй уровень - три комнаты, баня, санузел; третий уровень - мансарда', 80, 593, 7, 1, 1, 1),
(4, 34, 94, 'Кедровая опушка', 1705489.00, 4, 3, 1, '2011-03-14 00:00:00', 'Дом с мансардой, также на участке расположен гостевой домик. с/т Охотник, з,у 5 соток. Тихое спокойное место, отлично подходит, как для отдыха так и для жизни. Коммуникации: свет, вода, канализация-септик, газ проводят', 43, 191, 7, 1, 1, 1),
(5, 57, 91, 'Усадьба на Лесной', 1223322.00, 5, 4, 1, '2010-10-05 00:00:00', 'Очень симпатичный дом с хорошим садом, теплицами, зоной отдыха, живописным видом. Дом состоит из 3-х комнат, кухни, сан.узла, гаража. Рядом остановка городского транспорта', 75, 121, 12, 1, 1, 1),
(6, 97, 46, 'Тихий уголок', 7293265.00, 6, 4, 2, '2014-11-07 00:00:00', 'Дом в микрорайоне Мамайка, в садовом товариществе, в пешей доступности от моря. Первый этаж жилой, участок ухоженный, двор с паркингом .Есть возможность выкупить соседний участок 2 сотки', 46, 16, 18, 1, 1, 1),
(7, 14, 57, 'Кедровый край', 8244432.00, 7, 5, 2, '2012-09-17 00:00:00', 'Дом в окружении природы,чистый воздух,отличные соседи,капитальный дом,который можно завершить по своему вкусу!', 6, 321, 3, 1, 1, 1),
(8, 5, 91, 'Парус', 2361088.00, 8, 1, 2, '2013-05-10 00:00:00', 'Этот дом с земельным участком необычайно уютный в окружении пышной зелени. Дом находится не так далеко от городских объектов, а все коммуникации уже проведены, с ремонтом и мебелирован. Район тихий, зеленый, идеальное...', 91, 414, 18, 1, NULL, 0),
(9, 99, 93, 'Алые паруса', 9321229.00, 9, 6, 2, '2011-04-17 00:00:00', 'Дом расположен в красивом горном массиве с чистым воздухом с.Каштаны, в 5км. от центра Хосты. Участок 5.5 соток, ступенчатый рельеф. На участке отличный фруктовый сад: хурма, кизил, инжир, яблони, груша, виноград, клубника и т.д.', 39, 393, 1, 1, NULL, 0),
(10, 59, 46, 'Щапово', 7874518.00, 10, 4, 1, '2014-04-19 00:00:00', 'Домик капитальный, кирпичный, в 3-х уровнях, санузел внутри дома. На приусадебном участке плодоносящий сад. Свет в доме есть. Подъезд бетонный', 22, 550, 3, 1, NULL, 0),
(11, 61, 95, 'Малхино ', 1030426.00, 11, 4, 2, '2012-09-18 00:00:00', 'На берегу моря продается трехэтажный жилой дом. Дом с двумя отдельными входами, и имеет следующую планировку: - первый этаж: кухня, гостиная с камином с выходом на большую панорамную террасу, санузел, сауна', 93, 652, 3, 1, NULL, 0),
(12, 5, 6, 'Никольское ', 7627808.00, 12, 3, 1, '2010-01-30 00:00:00', 'Центральный район, ул.Восточная, снт "Тюльпан". Район Магнита на Новой заре. Дом новый. Сад плодоносящий. Южный склон. Коммуникации в 100 метрах. От Виноградной 1,5 км. Документы в порядке. Дорога бетонная.', 96, 128, 3, 1, NULL, 0),
(13, 61, 88, 'Бурцево', 9605980.00, 13, 6, 1, '2015-11-29 00:00:00', 'Полностью сделан новый ремонт. Большой пруд. Рядом лесопарковая зона. Есть бильярд. Сауна. Кто желает уехать от суеты и отдохнуть в окружении леса самое оно', 4, 131, 13, 1, NULL, 0),
(14, 77, 41, 'Верейский уезд', 8412841.00, 14, 4, 2, '2013-10-01 00:00:00', 'Срочная продажа дачи на Мацесте! Супер живописное место, идеальное для летнего отдыха. Граничит с лесом. На участке огромное количество плодоносящих деревьев. Требуется косметический ремонт.', 33, 479, 8, 1, NULL, 0),
(15, 71, 89, 'Богородское', 2698146.00, 15, 4, 2, '2013-04-26 00:00:00', 'Продаётся блочный, маленький, уютный домик в очень хорошем районе, 5 минут на машине от центра, также и до моря! Участок ровный, прямоугольный, плодоносящий сад, родник, огород. Хороший подъезд с двух сторон. Достойные соседи. От остановки вниз 30 м...', 51, 371, 15, 1, NULL, 0),
(16, 18, 74, 'Дурнево', 3934888.00, 16, 2, 1, '2012-07-16 00:00:00', 'Продам полностью оборудованный дом в с. Верхневеселое. Электричество, вода централизованные, туалет – септик. Удобства в доме. Прилегающая территория 6 соток Дополнительная информация по телефону', 57, 623, 18, 1, NULL, 0),
(17, 82, 98, 'Узкое', 7763935.00, 17, 4, 2, '2010-10-04 00:00:00', 'Недалеко от центра в тихом живописном месте с красивым видом на море расположился поселок с/т «Юг». Земельный участок правильной формы, спокойного рельефа со старым плодоносящим садом (яблони, груши, персики, слива, киви...', 30, 78, 13, 1, NULL, 0),
(18, 87, 18, 'Покровское', 3523775.00, 18, 3, 2, '2015-06-13 00:00:00', 'Ухоженный дом с шикарным видом на море. Имеет благоустроенную придомовую территорию, центральные коммуникации, адрес и прописку. Земля категории ИЖС, дом со свидетельством и статусом "жилой". На участке расположен гараж, сауна, капитальная теплица...', 81, 322, 3, 1, NULL, 0),
(19, 44, 71, 'Троицкое-Андреево', 3071024.00, 19, 4, 1, '2013-12-27 00:00:00', 'Жилой дом, хороший подъезд, ровный участок, на участке хоз постройки, крытая стоянка для автомобиля, хорошие соседи, которые всегда присмотрят за вашим домом.', 13, 622, 12, 1, NULL, 0),
(20, 53, 57, 'Бронницкий уезд', 8268612.00, 20, 3, 2, '2011-07-08 00:00:00', 'В доме сделан ремонт. Дорогая кухня стоит новая проводка доски новые на крыльце. Канализация септик. Во дворе течет ручей насос качает в бак и подается в дом.Установлен камин .Также есть 2 печки от...', 22, 387, 14, 1, NULL, 0),
(21, 82, 67, 'Белая дача', 7832913.00, 21, 2, 1, '2010-09-23 00:00:00', 'Небольшой дом имеется свет вода в доме газ по границе много фруктовых деревьев очень красивый вид на море', 71, 172, 3, 1, NULL, 0),
(22, 30, 58, 'Померанцевая оранжерея', 8032388.00, 22, 2, 2, '2015-04-08 00:00:00', 'Продается 2 этажный монолитно-блочный дом. В 500 метрах от общественной остановки. Бетонный подъезд. На участке , сауна, большая теплица, курятник, пруд с рыбками, много фруктовых деревьев. Территория облагорожена . 1 этаж ...', 91, 687, 4, 1, NULL, 0),
(23, 61, 23, 'Нащокино', 9037760.00, 23, 3, 2, '2014-03-12 00:00:00', 'живописное место подъезд асфальт река 50м до моря 30 мин ходьбы по ровному асфальту', 43, 319, 15, 1, NULL, 0),
(24, 36, 91, 'Меньшове ', 5716420.00, 24, 4, 2, '2011-12-16 00:00:00', 'Продается капитальная дача в пос. Дом капитальный блочный 1 этаж + цокольный этаж + мансарда, 2 комнаты и кухня, пластиковые окна. Участок 6 сот в собственности, фактически 12 сот с большим садом - виноград, киви...', 39, 509, 6, 1, NULL, 0),
(32, 14, 1, 'Византия', 15000000.00, 25, 5, 1, '2016-05-20 00:54:59', 'Красивое место, доступное не всем. Прекрасные клумбы заборы и водопады дополняют образ прекрасного садв ', 15, 731, 4, 1, NULL, 0),
(36, 52, 1, 'Пикник на обочине ', 1324134.00, 26, 12, 1, '2016-05-20 01:10:19', 'Прекрасный особняк в три этажа', 1, 721, 33, 12, NULL, 0);

-- 
-- Вывод данных для таблицы filials
--
INSERT INTO filials VALUES
(1, 9848431, 1126089, 'Понедельник - Пятница', 52, 1, 73, 692, 14, 9, '1'),
(2, 7428863, 6918395, 'Понедельник - Пятница', 82, 1, 78, 704, 11, 9, '2'),
(3, 7482247, 7154592, 'Понедельник - Пятница', 85, 1, 12, 5, 1, 7, '3'),
(5, 5092553, 4470094, 'Понедельник - Пятница', 25, 1, 68, 157, 3, 7, '4'),
(6, 4836547, 9965424, 'Понедельник - Пятница', 62, 1, 54, 312, 15, 6, '5'),
(7, 4898853, 1618523, 'Понедельник - Пятница', 7, 1, 89, 405, 9, 10, '6'),
(8, 2283647, 5919047, 'Понедельник - Пятница', 41, 1, 2, 223, 11, 10, '7'),
(9, 6553647, 9214545, 'Понедельник - Пятница', 94, 1, 93, 657, 4, 2, '8'),
(10, 7484777, 5526660, 'Понедельник - Пятница', 10, 1, 52, 503, 13, 4, '9'),
(11, 7900647, 5318616, 'Понедельник - Пятница', 91, 1, 57, 351, 9, 4, '10'),
(12, 7686653, 8992267, 'Понедельник - Пятница', 58, 1, 44, 571, 1, 6, '11'),
(13, 5426632, 1863561, 'Понедельник - Пятница', 75, 1, 98, 85, 18, 6, '12'),
(14, 9807232, 6785566, 'Понедельник - Пятница', 19, 1, 68, 279, 12, 6, '13'),
(15, 6758312, 6749168, 'Понедельник - Пятница', 63, 1, 58, 214, 10, 2, '14'),
(16, 4723321, 3925813, 'Понедельник - Пятница', 61, 1, 22, 35, 8, 5, '15'),
(17, 4322123, 6768426, 'Понедельник - Пятница', 69, 1, 69, 208, 3, 1, '16'),
(18, 7654541, 2169017, 'Понедельник - Пятница', 93, 1, 35, 334, 17, 10, '17'),
(19, 3431135, 6110341, 'Понедельник - Пятница', 40, 1, 50, 564, 12, 10, '18'),
(20, 1431445, 4520389, 'Понедельник - Пятница', 86, 1, 40, 477, 5, 4, '19');

-- 
-- Вывод данных для таблицы reviews
--
INSERT INTO reviews VALUES
(1, 1, 'Очень хорошее место', 8, '2016-05-22 00:34:27'),
(2, 1, 'Мне тоже понравилось', 8, '2016-05-22 00:36:00');

-- 
-- Вывод данных для таблицы transaction
--
INSERT INTO transaction VALUES
(1, 1, '2014-08-16 00:00:00', 18, 52, 52, 52),
(2, 2, '2018-01-11 00:00:00', 2, 82, 29, 69),
(3, 3, '2000-01-31 00:00:00', 24, 85, 49, 34),
(4, 4, '2009-12-08 00:00:00', 7, 82, 44, 39),
(5, 5, '2017-02-03 00:00:00', 14, 25, 18, 86),
(6, 6, '2019-09-19 00:00:00', 19, 62, 80, 67),
(7, 7, '2000-08-31 00:00:00', 22, 7, 54, 34),
(8, 8, '2017-02-21 00:00:00', 6, 41, 72, 97),
(9, 9, '2018-06-18 00:00:00', 21, 94, 40, 87),
(10, 10, '2019-10-01 00:00:00', 16, 10, 58, 62),
(11, 11, '2009-01-21 00:00:00', 9, 91, 8, 12),
(12, 12, '2004-07-24 00:00:00', 20, 58, 65, 13),
(13, 13, '2010-05-26 00:00:00', 12, 75, 30, 60),
(14, 14, '2001-06-30 00:00:00', 1, 19, 8, 27),
(15, 15, '2016-10-21 00:00:00', 10, 63, 78, 33),
(16, 16, '2014-11-11 00:00:00', 17, 61, 25, 11),
(17, 17, '2004-12-11 00:00:00', 4, 69, 80, 75),
(18, 18, '2018-12-28 00:00:00', 23, 93, 93, 77),
(19, 19, '2011-01-28 00:00:00', 21, 40, 52, 75),
(20, 20, '2000-08-10 00:00:00', 5, 86, 31, 88);

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;