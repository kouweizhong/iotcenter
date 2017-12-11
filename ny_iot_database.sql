-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2017-12-11 10:15:34
-- 服务器版本： 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ny_iot_database`
--

-- --------------------------------------------------------

--
-- 表的结构 `algo_web_groups`
--

CREATE TABLE IF NOT EXISTS `algo_web_groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `algo_web_groups`
--

INSERT INTO `algo_web_groups` (`id`, `name`, `description`) VALUES
(1, 'admin', '超级管理员,拥有最高权限'),
(2, 'manager', '管理员'),
(3, 'general', '一般用户');

-- --------------------------------------------------------

--
-- 表的结构 `algo_web_login_attempts`
--

CREATE TABLE IF NOT EXISTS `algo_web_login_attempts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(15) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `algo_web_users`
--

CREATE TABLE IF NOT EXISTS `algo_web_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(45) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `phone` (`phone`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `algo_web_users`
--

INSERT INTO `algo_web_users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
(1, '127.0.0.1', 'SkyBlue', '$2a$07$SeBknntpZror9uyftVopmu61qg0ms8Qv1yV6FG.kQOSM.9QhmTo36', '', 'admin@admin.com', '', NULL, NULL, 'LZso0P5CHo7iR.0DE4GUtu', 1268889823, 1512957528, 1, 'Admin', 'istrator', '陕西省,西安市,碑林区,长安路', '18392993469');

-- --------------------------------------------------------

--
-- 表的结构 `algo_web_users_groups`
--

CREATE TABLE IF NOT EXISTS `algo_web_users_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`),
  KEY `fk_users_groups_users1_idx` (`user_id`),
  KEY `fk_users_groups_groups1_idx` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `algo_web_users_groups`
--

INSERT INTO `algo_web_users_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `iot_device_info`
--

CREATE TABLE IF NOT EXISTS `iot_device_info` (
  `devinfo_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '信息条目id',
  `devinfo_mac` char(12) NOT NULL COMMENT '硬件mac地址',
  `devinfo_project` int(11) NOT NULL COMMENT '项目名称',
  PRIMARY KEY (`devinfo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='硬件设备信息' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `iot_device_msg`
--

CREATE TABLE IF NOT EXISTS `iot_device_msg` (
  `devmsg_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '信息条目id',
  `devmsg_mac` char(6) NOT NULL COMMENT '硬件mac地址',
  `devmsg_len` int(11) NOT NULL COMMENT '数据长度',
  `devmsg_msg` varchar(1024) NOT NULL COMMENT '交互的具体内容',
  `devmsg_orient` tinyint(4) NOT NULL COMMENT '数据流方向,1上行;2下行',
  `devmsg_status` tinyint(4) NOT NULL COMMENT '状态,10上行待接收;11上行接收成功;12上行接收失败;20下行待接收;21下行接收成功;22下行接收失败',
  `devmsg_time` datetime NOT NULL COMMENT '接收数据时间',
  PRIMARY KEY (`devmsg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='硬件数据交互' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `iot_equ_info`
--

CREATE TABLE IF NOT EXISTS `iot_equ_info` (
  `equinfo_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '信息条目id',
  `equinfo_name` varchar(32) NOT NULL COMMENT '设备名称',
  `equinfo_mac` char(12) NOT NULL COMMENT '硬件mac地址',
  `equinfo_project` int(11) NOT NULL COMMENT '所属项目(prjtinfo_id)',
  `equinfo_create_time` datetime NOT NULL COMMENT '创建时间',
  `equinfo_update_time` datetime NOT NULL COMMENT '更新时间',
  `equinfo_type` int(11) NOT NULL COMMENT '设备类型',
  `equinfo_is_dele` int(11) NOT NULL COMMENT '是否删除',
  `equinfo_dele_time` int(11) NOT NULL COMMENT '删除时间',
  `equinfo_comment` varchar(512) NOT NULL COMMENT '硬件备注信息',
  PRIMARY KEY (`equinfo_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='硬件设备信息' AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `iot_equ_info`
--

INSERT INTO `iot_equ_info` (`equinfo_id`, `equinfo_name`, `equinfo_mac`, `equinfo_project`, `equinfo_create_time`, `equinfo_update_time`, `equinfo_type`, `equinfo_is_dele`, `equinfo_dele_time`, `equinfo_comment`) VALUES
(1, '热释红外传感器', '010203040501', 1, '2017-12-11 10:11:55', '0000-00-00 00:00:00', 0, 0, 0, '整栋楼部署'),
(2, '紫外线传感器', '010203040502', 1, '2017-12-11 10:12:37', '0000-00-00 00:00:00', 0, 0, 0, '大厅前广场'),
(3, '加速度传感器', '010203040503', 1, '2017-12-11 10:13:18', '0000-00-00 00:00:00', 0, 0, 0, '防碰撞检测'),
(4, '大气压力传感器', '010203040504', 1, '2017-12-11 10:13:44', '0000-00-00 00:00:00', 0, 0, 0, '测试用'),
(5, '继电器执行机构', '010203040505', 1, '2017-12-11 10:14:06', '0000-00-00 00:00:00', 0, 0, 0, '测试');

-- --------------------------------------------------------

--
-- 表的结构 `iot_project_info`
--

CREATE TABLE IF NOT EXISTS `iot_project_info` (
  `prjtinfo_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '信息条目id',
  `prjtinfo_name` varchar(32) NOT NULL COMMENT '项目名称',
  `prjtinfo_create_time` datetime NOT NULL COMMENT '创建时间',
  `prjtinfo_update_time` datetime NOT NULL COMMENT '更新时间',
  `prjtinfo_is_delete` int(11) NOT NULL COMMENT '是否删除',
  `prjtinfo_delete_time` datetime NOT NULL COMMENT '删除时间',
  `prjtinfo_app_key` char(15) NOT NULL COMMENT '项目key',
  `prjtinfo_app_id` char(15) NOT NULL COMMENT 'appID',
  `prjtinfo_user_id` int(11) NOT NULL COMMENT '所属用户id',
  `prjtinfo_comment` varchar(512) NOT NULL COMMENT '项目备注信息',
  PRIMARY KEY (`prjtinfo_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='项目信息' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `iot_project_info`
--

INSERT INTO `iot_project_info` (`prjtinfo_id`, `prjtinfo_name`, `prjtinfo_create_time`, `prjtinfo_update_time`, `prjtinfo_is_delete`, `prjtinfo_delete_time`, `prjtinfo_app_key`, `prjtinfo_app_id`, `prjtinfo_user_id`, `prjtinfo_comment`) VALUES
(1, '财富中心测试平台', '2017-12-11 10:07:03', '2017-12-11 10:07:03', 0, '0000-00-00 00:00:00', '996f6640636f980', 'e82b30da1f9745b', 1, '位于西安市高新区高新路1号');

--
-- 限制导出的表
--

--
-- 限制表 `algo_web_users_groups`
--
ALTER TABLE `algo_web_users_groups`
  ADD CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `algo_web_groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `algo_web_users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
